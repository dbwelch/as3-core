package com.ffsys.ui.css {
	
	import flash.filters.BitmapFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;	
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	import com.ffsys.utils.properties.PropertiesMerge;
	import com.ffsys.utils.string.StringTrim;
	
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
	public class CssStyleCollection extends StyleSheet {
		
		/**
		*	Represents a CSS class reference declaration.
		*/
		public static const CLASS_REFERENCE:String = "class";
		
		/**
		*	Represents a hexadecimal number notation.
		*/
		public static const HEX_NUMBER:String = "#";
		
		/**
		*	Creates a <code>CssStyleCollection</code> instance.
		*/
		public function CssStyleCollection()
		{
			super();
		}
		
		/**
		*	Extends the native style sheet parsing capability.
		*	
		*	@param text The CSS text to parse.
		*/
		override public function parseCSS( text:String ):void
		{
			super.parseCSS( text );
			postProcessCss();
		}
		
		/**
		*	Overrides the default text format tranform ability.	
		*	
		*	@param style The style object to transform to a text format.
		*	
		*	@return The transformed text format.
		*/
		override public function transform( style:Object ):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			if( style )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( tf, style );
			}
			return tf;
		}
		
		public function getFilter( styleName:String ):BitmapFilter
		{
			var filter:BitmapFilter = null;
			var style:Object = getStyle( styleName );
			
			if( !style || !( style.filterClass is Class ) )
			{
				throw new Error( "Could not find a valid filter class"
					+ " reference when attempting to get a filter with styleName '"
					+ styleName + "'" );
			}
			
			try
			{
				filter = new style.filterClass();
			}catch( e:Error )
			{
				throw new Error( "Could not instantiate filter with class '"
					+ style.filterClass + "'." );
			}
			
			var merger:PropertiesMerge = new PropertiesMerge();
			merger.merge( filter, style );
			
			return filter;
		}
		
		/**
		*	Applies a style to a target object.
		*	
		*	@param styleName The name of the style to apply.
		*	@param target The target object to apply the style to.
		*	@param styles An array to place the applied style objects into.
		*	
		*	@return An array of the style objects that were applied or an empty
		*	array if no styles were applied.
		*/
		public function apply(
			styleName:String,
			target:Object,
			styles:Array = null ):Array
		{
			if( styleName == null )
			{
				return new Array();
			}
			
			if( styles == null )
			{
				styles = new Array();
			}
			
			//deal with multiple style names separated by spaces
			if( styleName.indexOf( " " ) > -1 )
			{
				var styleNames:Array = styleName.split( " " );
				for( var i:int = 0;i < styleNames.length;i++ )
				{
					apply( styleNames[ i ], target, styles );
				}
				return styles;
			}
			
			//apply an individual style
			var style:Object = getStyle( styleName );
			
			if( style && target )
			{
				var txt:TextField = null;
				var format:TextFormat = null;

				var targets:Vector.<TextField> = new Vector.<TextField>(); 
				
				if( target is TextField )
				{
					targets.push( TextField( target ) );				
				}
				
				//trace("CssStyleCollection::apply(), ", target, ( target is ICssTextFieldProxy ) );
				
				if( target is ICssTextFieldProxy )
				{
					targets = ICssTextFieldProxy( target ).getProxyTextFields();
					
					//trace("CssStyleCollection::applied(), got proxy targets: ", target, targets );
				}
			
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( target, style );
				
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
						//trace("CssStyleCollection::apply(), apply textformat to : ", txt );
					
						txt.defaultTextFormat = format;
					
						if( style.hasOwnProperty( "width" ) )
						{
							//trace("CssStyleCollection::applied(), ", style.width );
							target.width = style.width;
						}
					
						if( style.hasOwnProperty( "height" ) )
						{
							target.height = style.height;
						}
					
						//trace("CssStyleCollection::apply(), txt text: ", txt.text );
					
						if( txt.text )
						{
							txt.text = txt.text;
						}
						
						//txt.border = true;
						//txt.background = true;
						
						/*
						trace("CssStyleCollection::apply(), ",
							txt, txt.embedFonts, txt.defaultTextFormat, txt.defaultTextFormat.font, txt.width, txt.height, txt.visible, txt.defaultTextFormat.color );
						*/
					}
				
				}
				
				/*
				if( target is TextField )
				{
					if( style.hasOwnProperty( "width" ) )
					{
						//trace("CssStyleCollection::applied(), ", style.width );
						target.width = style.width;
					}
					
					if( style.hasOwnProperty( "height" ) )
					{
						target.height = style.height;
					}
					
					trace("CssStyleCollection::apply(), txt text: ", txt.text );
					
					if( txt.text )
					{
						txt.text = txt.text;
					}									
				}
				*/
				
				styles.push( style );
			}
			
			return styles;
		}
		
		/**
		*	@private	
		*/
		private function postProcessCss():void
		{
			var z:String = null;
			var style:Object = null;
			var styleName:String = null;
			var parser:PrimitiveParser = new PrimitiveParser();
			var value:*;
			var clazz:Class = null;
			var re:RegExp = null;
			
			var styles:Array = styleNames;
			
			//trace("CssStyleCollection::postProcessCss(), STYLE NAMES: ", styles );
			
			for( var i:int = 0;i < styles.length;i++ )
			{
				styleName = styles[ i ];
				//trace("*** >>>>>>> Parsing style name :", i, styleName );
				style = getStyle( styleName );
				for( z in style )
				{
					//trace("*** Parsing property :", z );
					
					value = style[ z ];
					
					//trace("CssStyleCollection::postProcessCss(), pre-parsing: ", value  );
					value = parser.parse( value, true );

					//we've parsed the primitives
					//now deal with css specific parsing
					if( value is String )
					{
						re = /^#[0-9a-fA-F]{2,6}$/;

						/*
						trace("CssStyleCollection::test RegExp(), ",
							"'" + value + "'", re.test( value ) );
						*/
						
						if( re.test( value ) )
						{
							value = parseHexNumber( value );
						}else
						{
							clazz = parseClassReference( value );
							if( clazz != null )
							{
								value = clazz;
							}
						}
					}
					
					style[ z ] = value;
				}

				setStyle( styleName, style );
			}
		}
		
		/**
		*	@private	
		*/
		private function parseHexNumber( candidate:String ):Number
		{
			candidate = candidate.replace( /^#/, "0x" );
			var parsed:Number = Number( candidate );
			return parsed;
		}
		
		/**
		*	@private
		*/
		private function parseClassReference( candidate:String ):Class
		{
			if( candidate.indexOf( CLASS_REFERENCE ) == -1 )
			{
				return null;
			}
			
			var clazz:Class = null;
			
			var classPath:String = candidate.replace(
				/^class\s*\(\s*([a-zA-Z0-9\.]+)\s*\)$/, "$1" );
			classPath = new StringTrim().trim( classPath );
			try
			{
				clazz = Class( getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error( "Could not locate css class reference '"
					+ classPath + "'." );
			}
			
			return clazz;
		}
	}
}