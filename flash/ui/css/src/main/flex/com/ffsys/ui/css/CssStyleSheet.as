package com.ffsys.ui.css {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.ImageLoader;
	import com.ffsys.io.loaders.types.MovieLoader;
	import com.ffsys.io.loaders.types.SoundLoader;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	import com.ffsys.utils.properties.PropertiesMerge;
	import com.ffsys.utils.string.StringTrim;
	
	import com.ffsys.utils.substitution.*;
	
	/**
	*	Represents a collection of CSS styles.
	*	
	*	Extends the style sheet parsing capability to add
	*	support for parsing style values into primitives.
	*	
	*	Arrays can be specified in the CSS by delimiting
	*	values with commas. References to classes using
	*	the <code>class(flash.display.Sprite)</code>
	*	syntax are resolved. If the class is not available when
	*	the CSS is parsed a runtime exception will be thrown.
	*	
	*	The extended parsing capability also supports hexadecimal
	*	numbers using the notation <code>#ffffff</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.10.2010
	*	
	*	@see com.ffsys.utils.primitives.PrimitiveParser
	*/
	public class CssStyleSheet extends BeanDocument
		implements ICssStyleSheet {
			
		/**
		* 	The delimiter used to delimit style names in a string value.
		*/
		public static const STYLE_DELIMITER:String = " ";
		
		/**
		*	Creates a <code>CssStyleSheet</code> instance.
		*/
		public function CssStyleSheet()
		{
			super();
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasStyle( styleName:String ):Boolean
		{
			var names:Array = this.styleNames;
			return names.indexOf( styleName ) > -1;
		}
		
		/**
		*	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			if( styleName != null )
			{
				var descriptor:IBeanDescriptor = getBeanDescriptor( styleName );
				if( !descriptor && style )
				{
					descriptor = new BeanDescriptor();
					descriptor.id = styleName;
					addBeanDescriptor( descriptor );
				}
				
				//clear the existing bean
				if( !style && descriptor )
				{
					removeBeanDescriptor( descriptor );
				//update the existing bean descriptor
				}else if( descriptor && style )
				{
					descriptor.transfer( style );
				}
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function getStyle( styleName:String ):Object
		{
			var style:Object = null;
			if( styleName != null )
			{
				return getBean( styleName );
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function transform( style:Object ):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			if( style )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( tf, style );
			}
			return tf;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( styleName:String ):BitmapFilter
		{
			return getStyle( styleName ) as BitmapFilter;
		}

		/**
		*	@inheritDoc	
		*/
		public function getStyles( styleName:String ):Array
		{
			var output:Array = new Array();
			var style:Object = null;
			if( styleName.indexOf( STYLE_DELIMITER ) > -1 )
			{
				var styleNames:Array = styleName.split( STYLE_DELIMITER );
				var styles:Array = null;
				for( var i:int = 0;i < styleNames.length;i++ )
				{
					styles = getStyles( styleNames[ i ] );
					if( styles )
					{
						output = output.concat( styles );
					}
				}
			}
			
			style = getStyle( styleName );
			if( style )
			{
				output.push( style );
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function style( target:IStyleAware, ...custom ):Array
		{
			if( target )
			{
				custom.unshift( target );
				var styles:Array = getStyleObjects.apply( this, custom );
				if( styles.length > 0 )
				{
					applyStyles( target, styles );
				}
				return styles;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleNameList( target:IStyleAware, ... custom ):Array
		{
			var styles:Array = new Array();
			if( target )
			{
				var styleParts:Array = target.styles ? target.styles.split( STYLE_DELIMITER ) : new Array();

				//add identifier style name
				if( target is IStringIdentifier
					&& IStringIdentifier( target ).id )
				{
					styleParts.unshift( "#" + IStringIdentifier( target ).id );
				}
	
				//add the class level style name
				var className:String = getQualifiedClassName( target );
				
				//class name must be converted to lower case as the StyleSheet
				//style parsing logic converts style names to lower case
				className = className.substr( className.indexOf( "::" ) + 2 ).toLowerCase();
				if( className )
				{
					styleParts.unshift( className );
				}
				
				styles = styleParts;
				
				if( custom.length > 0 )
				{
					for( var i:int = 0;i < custom.length;i++ )
					{
						styles.push( custom[ i ] );
					}
				}
			}
			
			return styles;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleNames():Array
		{
			return this.beanNames;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleNames( target:IStyleAware, ... custom ):String
		{
			var output:String = "";
			if( target )
			{
				custom.unshift( target );
				var styles:Array = getStyleNameList.apply( this, custom );
				output = styles.join( STYLE_DELIMITER );
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleObjects( target:IStyleAware, ... custom ):Array
		{
			var output:Array = new Array();
			if( target )
			{
				custom.unshift( target );
				var styles:String = getStyleNames.apply( this, custom );
				if( styles.length > 0 )
				{
					output = getStyles( styles );
				}
			}
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function apply(
			target:Object,
			styleName:String ):Array
		{
			if( styleName == null )
			{
				return new Array();
			}
			
			var styles:Array = getStyles( styleName );
			applyStyles( target, styles );
			return styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyStyles( target:Object, styles:Array ):void
		{
			//calling applyStyle() is potentially expensive
			//so we merge all styles into a single object
			//in the order styles are declared and apply
			//the cumulative style			
			if( target && styles )
			{
				var cumulative:Object = new Object();
				var merger:PropertiesMerge = new PropertiesMerge();
				for( var i:int = 0;i < styles.length;i++ )
				{
					merger.merge( cumulative, styles[ i ], false );
				}
				applyStyle( target, cumulative );
			}
		}
		
		/**
		* 	@private
		*/
		private function applyPadding( target:IPaddingAware, style:Object ):void
		{
			if( target && target.paddings )
			{
				if( style.padding is Number )
				{
					target.paddings.padding = style.padding;
				}
			
				if( style.paddingLeft is Number )
				{
					target.paddings.left = style.paddingLeft;
				}
				
				if( style.paddingTop is Number )
				{
					target.paddings.top = style.paddingTop;	
				}
				
				if( style.paddingRight is Number )
				{
					target.paddings.right = style.paddingRight;					
				}
				
				if( style.paddingBottom is Number )
				{
					target.paddings.bottom = style.paddingBottom;					
				}				
			}
		}
		
		/**
		* 	@private
		*/
		private function applyMargin( target:IMarginAware, style:Object ):void
		{
			if( target && target.margins )
			{
				if( style.margin is Number )
				{
					target.margins.margin = style.margin;
				}
			
				if( style.marginLeft is Number )
				{
					target.margins.left = style.marginLeft;
				}
				
				if( style.marginTop is Number )
				{
					target.margins.top = style.marginTop;	
				}
				
				if( style.marginRight is Number )
				{
					target.margins.right = style.marginRight;					
				}
				
				if( style.marginBottom is Number )
				{
					target.margins.bottom = style.marginBottom;					
				}				
			}
		}		
		
		/**
		* 	@private
		*/
		private function assign(
			target:Object,
			source:Object,
			name:String,
			value:* ):Boolean
		{
			//trace("CssStyleSheet::assign()", target, name, value );
			
			if( target is IBeanProperty )
			{
				var property:IBeanProperty = IBeanProperty( target );
				if( property.shouldSetBeanProperty( name, value ) )
				{
					//delegate bean property assignment
					property.setBeanProperty( name, value );
					return false;
				}
			}
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyStyle( target:Object, style:Object ):void
		{
			if( style && target )
			{
				
				if( target is IPaddingAware )
				{
					applyPadding( IPaddingAware( target ), style );
				}
				
				if( target is IMarginAware )
				{
					applyMargin( IMarginAware( target ), style );
				}
				
				var txt:TextField = null;
				var format:TextFormat = null;

				var targets:Vector.<TextField> = new Vector.<TextField>(); 
				
				if( target is TextField )
				{
					targets.push( TextField( target ) );			
				}
				
				if( target is ICssTextFieldProxy )
				{
					targets = ICssTextFieldProxy( target ).getProxyTextFields();
				}
				
				//trace("CssStyleSheet::applyStyle() APPLYING STYLE PROPERTIES: ", target, style );
			
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( target, style, true, null, assign );
				
				//we cannot guarantee the order that styles will
				//be applied so we need to ensure that any width/height
				//are applied after other properties such as autoSize
				//for the textfield to render correctly
				
				if( targets.length )
				{
					format = new TextFormat();
					format = transform( style );
				
					for each( txt in targets )
					{
						txt.defaultTextFormat = format;
					
						if( style.hasOwnProperty( "width" ) )
						{
							target.width = style.width;
						}
					
						if( style.hasOwnProperty( "height" ) )
						{
							target.height = style.height;
						}
					
						if( txt.text )
						{
							txt.text = txt.text;
						}
						
					}
				}
			}			
		}
	}
}