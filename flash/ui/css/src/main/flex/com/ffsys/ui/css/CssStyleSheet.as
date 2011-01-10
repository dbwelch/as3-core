package com.ffsys.ui.css {
	
	import flash.display.DisplayObject;	
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.core.processor.*;
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	import com.ffsys.utils.properties.PropertiesMerge;
	
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
		* 	The default name for css bean documents.
		*/
		public static const NAME:String = "css";	
		
		/**
		* 	The name of the property to search for when
		* 	mapping font family declarations.
		*/
		public static const FONT_PROPERTY:String = "font";
			
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
			this.id = NAME;
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function toStyleSheet():StyleSheet
		{
			var styles:StyleSheet = new StyleSheet();
			
			var names:Array = this.styleNames;
			var style:Object = null;
			var name:String = null;
			for( var i:int = 0;i < names.length;i++ )
			{
				name = names[ i ];
				style = getStyle( name );
				styles.setStyle( name, style );
			}
			return styles;
		}
		
		/**
		* 	Configures the default beans for this
		* 	style sheet.
		*/
		override protected function configure():void
		{
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				BeanNames.BEAN_ELEMENT_PARSER );
			descriptor.instanceClass = CssTextElementParser;
			addBeanDescriptor( descriptor );
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
				//the css parsing converts style names to lowercase
				//so force this convention until we write a custom css parser
				styleName = styleName.toLowerCase();
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
				//trace("::::::::::::::::::::::::::::::::::::: CssStyleSheet::style() styling target: ", target );
				
				custom.unshift( target );
				var styles:Array = getStyleObjects.apply( this, custom );
				if( styles.length > 0 )
				{
					applyStyles( target, styles );
				}
				
				//trace("::::::::::::::::::::::::::::::::::::: CssStyleSheet::style() finished styling target: ", target );
				
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
			if( target != null )
			{
				var i:int = 0;
				var styleParts:Array = target.styles ? target.styles.split( STYLE_DELIMITER ) : new Array();

				//add identifier style name
				if( target is IStringIdentifier
					&& IStringIdentifier( target ).id )
				{
					styleParts.unshift( "#" + IStringIdentifier( target ).id );
				}
	
				//add the class level style names
				var id:String = null;
				var classes:Vector.<String> = target.getClassLevelStyleNames();
				for each( id in classes )
				{
					if( id != null )
					{
						styleParts.unshift( id.toLowerCase() );
					}
				}

				styles = styleParts;
				
				if( custom.length > 0 )
				{
					for( i = 0;i < custom.length;i++ )
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
				
				//trace(">>>>>>>>>>>>>>>>>>>>> CssStyleSheet::getStyleObjects() got styles: ", styles );
				
				if( styles.length > 0 )
				{
					output = getStyles( styles );
				}
				
				//trace(">>>>>>>>>>>>>>>>>>>>> CssStyleSheet::getStyleObjects() got style objects: ", output );
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleInformation( target:IStyleAware, ... custom ):Array
		{
			var output:Array = new Array();
			if( target )
			{
				custom.unshift( target );
				var styleNames:Array = getStyleNameList.apply( this, custom );
				var styleObjects:Array = new Array();
				for( var i:int = 0;i < styleNames.length;i++ )
				{
					styleObjects.push( getStyle( styleNames[ i ] ) );
				}
				output[ 0 ] = styleNames;
				output[ 1 ] = styleObjects;				
				
				//trace(">>>>>>>>>>>>>>>>>>>>> CssStyleSheet::getStyleObjects() got style objects: ", output );
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
		* 	@inheritDoc
		*/
		public function getFlatStyle( styles:Array ):Object
		{
			var cumulative:Object = new Object();
			
			//TODO: consider looping in reverse order and only 
			//set the property if it hasn't already been set
			//prevents re-instantiation on merge of objects with the
			//same properties 
			
			if( styles != null && styles.length > 0 )
			{
				
				//var merger:PropertiesMerge = new PropertiesMerge();
				
				/*
				merge(
					target:Object,
					source:Object,
					strict:Boolean = true,
					ignore:Array = null,
					callback:Function = null,
					interceptor:Function = null ):void
				*/
				
				/*
				var props:Vector.<String> = new Vector.<String>();				
				var style:Object = null;
				var z:String = null;
				for( var i:int = (styles.length - 1 );i >= 0;i-- )
				{
					style = styles[ i ];
					for( z in style )
					{
						if( props.indexOf( z ) == -1 )
						{
							props.push( z );
							cumulative[ z ] = styles[ z ];
						}
					}
				}
				*/
				
				var merger:PropertiesMerge = new PropertiesMerge();
				for( var i:int = 0;i < styles.length;i++ )
				{
					merger.merge( cumulative, styles[ i ], false );
				}
			}
			
			return cumulative;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyStyles( target:Object, styles:Array ):void
		{
			//trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> !!! CssStyleSheet::applyStyles()", target, styles );
			
			//calling applyStyle() is potentially expensive
			//so we merge all styles into a single object
			//in the order styles are declared and apply
			//the cumulative style			
			if( target && styles )
			{
				var cumulative:Object = getFlatStyle( styles );
				
				//trace("|||||||||||||||||||||| CssStyleSheet::applyStyles()", target, cumulative );				
				
				applyStyle( target, cumulative );
			}
		}
		
		/**
		* 	@private
		*/
		private function applyPadding( target:IPaddingAware, style:Object ):void
		{
			//trace("CssStyleSheet::applyPadding()", target, style );
			
			if( target && target.paddings )
			{
				//trace("CssStyleSheet::applyPadding()", style.padding );
				
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
		* 	@private
		*/
		private function intercept(
			target:Object,
			source:Object,
			name:String,
			value:* ):Boolean
		{
			if( name.indexOf( "." ) > -1 )
			{
				//trace("CssStyleSheet::assign() FOUND DOT STYLE PROPERTY NAME: ", target, name, value );
				var assignment:IPropertyProcessor = new PropertyAssignmentProcessor(
					name, target, value );
				assignment.process();
				
				return false;
				
				/*
				trace("CssStyleSheet::assign() AFTER ASSIGNMENT: ",
					assignment.currentTarget, assignment.targets );
				*/
			}

			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyStyle( target:Object, style:Object ):void
		{
			//trace("CssStyleSheet::applyStyle()", target, style, target is IPaddingAware  );
			if( style && target )
			{
				
				//trace("CssStyleSheet::applyStyle() CHECKING PADDING AWARE: ", target, ( target is IPaddingAware ) );
				
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

				//got a font family declaration
				if( style.fontFamily is FontFamily )
				{
					var family:FontFamily = style.fontFamily as FontFamily;
					
					//trace("CssStyleSheet::intercept() GOT FONT FAMILY DECLARATION: ", target, style, style.fontFamily.fontNames );
					
					var embed:Boolean = style.embedFonts is Boolean ? style.embedFonts as Boolean : false;
					var fte:Boolean = style.fte is Boolean ? style.fte as Boolean : false;
					var font:String = family.getFont( embed, fte );
					if( font == null )
					{
						throw new Error( "Could not locate a valid font for font family declaration '"
						 + family.fontNames + "'." );
					}
					style[ FONT_PROPERTY ] = font;
				}
				
				//allow an target to perform last minute modification
				//of the style object applied
				
				if( target is ICssStyleInterceptor )
				{
					style = ICssStyleInterceptor( target ).doWithStyleObject( style );
				}
			
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( target, style, true, null, assign, intercept );
				
				//ensure color transforms are applied
				if( target is DisplayObject )
				{
					if( style.colorTransform is ColorTransform )
					{
						DisplayObject( target ).transform.colorTransform =
							ColorTransform( style.colorTransform );
					}
				}
				
				//TODO: handle cursor changes here
				
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
						if( !txt )
						{
							continue;
						}
						
						if( txt.styleSheet == null )
						{
							txt.defaultTextFormat = format;
						}
					
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