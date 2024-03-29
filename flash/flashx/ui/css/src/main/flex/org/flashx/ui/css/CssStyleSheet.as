package org.flashx.ui.css {
	
	import flash.display.DisplayObject;	
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.utils.getQualifiedClassName;
	
	import org.flashx.ioc.*;
	
	import org.flashx.core.processor.*;
	
	import org.flashx.ui.common.IMarginAware;
	import org.flashx.ui.common.IPaddingAware;
	import org.flashx.ui.common.IStyleAware;
	
	import org.flashx.core.IStringIdentifier;
	
	import org.flashx.utils.primitives.PrimitiveParser;
	import org.flashx.utils.properties.PropertiesMerge;
	
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
			
			//default wildcard styles
			var data:Object = {
				fontFamily: "Arial, Verdana, sans-serif",
				fontSize: 11,
				color: 0,
				backgroundColor: "transparent"
			}
			
			descriptor = new BeanDescriptor(
				"*", data );
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
				
				style = getBean( styleName );
				if( style != null )
				{
					try
					{
						style.styleName = styleName;
					}catch( e:Error )
					{
						//ignore the style name on non-dynamic objects
					}
				}
			}
			return style;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getCssStyle( styleName:String ):CssStyle
		{
			var style:CssStyle = null;
			if( styleName != null )
			{
				style = new CssStyle( getStyle( styleName ) );
				style.styleName = styleName;
			}
			return style;
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
				
				//TODO: remove this as the style aware target supplies class level identifiers
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
		public function getFlatStyle( styles:Array ):CssStyle
		{
			var cumulative:CssStyle = new CssStyle();
			
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
		* 	The default instance class to use for css beans.
		*/
		override public function getDefaultInstanceClass():Class
		{
			return CssStyle;
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
				
				//var style:CssStyle = new CssStyle( cumulative );
				//style.apply( target );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyStyle( target:Object, style:Object ):void
		{
			var css:CssStyle = new CssStyle( style );
			css.apply( target );
		}
	}
}