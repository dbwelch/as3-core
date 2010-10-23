package com.ffsys.ui.css {
	
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.ImageLoader;
	import com.ffsys.io.loaders.types.MovieLoader;
	import com.ffsys.io.loaders.types.SoundLoader;
	
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
	public class CssStyleCollection extends StyleSheet
		implements ICssStyleCollection {
		
		private var _extensionExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*([^)\s]+)\s*\)$/;
		private var _dependencies:ILoaderQueue;
		private var _cache:Dictionary;
		
		private static var extensions:Object = {
			"class": Class,
			"url": URLRequest,
			"img": ImageLoader,
			"sound": SoundLoader,
			"swf": MovieLoader
		};
		
		/**
		*	Represents a css extension that references a class.
		*	
		*	The class must be available when the css document is
		*	parsed.
		*/
		public static const CLASS:String = "class";
		
		/**
		*	Represents an external css url extension.
		*/
		public static const URL:String = "url";
		
		/**
		*	Represents an external css bitmap extension.
		*/
		public static const BITMAP:String = "img";
		
		/**
		*	Represents an external css sound extension.
		*/
		public static const SOUND:String = "sound";
		
		/**
		*	Represents an external css swf movie extension.
		*/
		public static const SWF:String = "swf";
		
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
		*	@inheritDoc
		*/
		public function get dependencies():ILoaderQueue
		{
			return _dependencies;
		}
		
		/**
		*	Parses the css text into this instance
		*	and returns a loader queue implementation
		*	responsible for loading any external dependencies
		*	declared in the css.
		*/
		public function parse( text:String ):ILoaderQueue
		{
			if( _dependencies )
			{
				_dependencies.destroy();
			}
			
			_cache = new Dictionary();
			_dependencies = new LoaderQueue();
			_dependencies.addEventListener(
				LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			parseCSS( text );
			return _dependencies;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getStyle( styleName:String ):Object
		{
			//the default behaviour of returning an empty
			//object when the style does not exist is undesirable
			//so we test for existence of at least one property
			var style:Object = super.getStyle( styleName );
			for( var z:String in style ){ break; };
			return z ? style : null;
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
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( styleName:String ):BitmapFilter
		{
			var filter:BitmapFilter = null;
			var style:Object = getStyle( styleName );

			if( style && ( style.filterClass is Class ) )
			{
				try
				{
					filter = new style.filterClass();
				}catch( e:Error )
				{
					throw new Error( "Could not instantiate filter with class '"
						+ style.filterClass + "'." );
				}
				
				if( filter )
				{
					var merger:PropertiesMerge = new PropertiesMerge();
					merger.merge( filter, style );
				}
			}
			
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
				
				if( target is ICssTextFieldProxy )
				{
					targets = ICssTextFieldProxy( target ).getProxyTextFields();
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
						txt.defaultTextFormat = format;
					
						if( style.hasOwnProperty( "width" ) )
						{
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
			var extension:Object = null;
			var hexExpression:RegExp = /^#[0-9a-fA-F]{2,6}$/;
			
			var styles:Array = styleNames;
			
			//trace("********************** CssStyleCollection::postProcessCss(), " );

			for( var i:int = 0;i < styles.length;i++ )
			{
				styleName = styles[ i ];
				style = getStyle( styleName );
				//trace("CssStyleCollection::postProcessCss(), ", styleName, style );
				for( z in style )
				{
					value = style[ z ];
					value = parser.parse( value, true );
					//trace("CssStyleCollection::postProcessCss(), ", value );

					//we've parsed the primitives
					//now deal with css specific parsing
					if( value is String )
					{
						if( hexExpression.test( value ) )
						{
							value = parseHexNumber( value );
						}else if( _extensionExpression.test( value ) )
						{
							extension = parseExtension( value, styleName, z );
							if( extension != null )
							{
								value = extension;
							}
						}
					}
					
					style[ z ] = value;
				}
				
				//trace("********************** CssStyleCollection::postProcessCss(), setting style: ", styleName, style );

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
		*	Determines whether an extension is valid.
		*	
		*	@param candidate The string candidate.
		*	
		*	@return Whether the extension candidate represents a
		*	valid extension.
		*/
		private function isValidExtension( candidate:String ):Boolean
		{
			for( var z:String in extensions )
			{
				if( candidate.indexOf( z ) > -1 )
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	@private
		*/
		private function parseExtension(
			candidate:String,
			styleName:String,
			styleProperty:String ):Object
		{
			if( !isValidExtension( candidate ) )
			{
				return null;
			}
			
			var extension:String = candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
			var output:Object = null;
			
			//var valueExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*([a-zA-Z0-9\.]+)\s*\)$/;
			var value:String = candidate.replace( _extensionExpression, "$1" );
	
			//is this necessary, the css parsing of StyleSheet seems to strip
			//leading white space - verify trailing is also removed
			value = new StringTrim().trim( value );
			
			switch( extension )
			{
				case CLASS:
					try
					{
						output = Class( getDefinitionByName( value ) );
					}catch( e:Error )
					{
						throw new Error( "Could not locate css class reference with class path '"
							+ value + "'." );
					}
					break;
				case URL:
					output = new URLRequest( value );
					break;			
				case BITMAP:
					output = new ImageLoader( new URLRequest( value ) );
					break;
				case SOUND:
					output = new SoundLoader( new URLRequest( value ) );
					break;
				case SWF:
					output = new MovieLoader( new URLRequest( value ) );
					break;
			}
			
			//trace("CssStyleCollection::parseExtension(), ", output );
			
			if( _dependencies && ( output is ILoader ) )
			{
				_dependencies.addLoader( ILoader( output ) );
				_cache[ output ] = { styleName: styleName, styleProperty: styleProperty };
			}
			
			return output;
		}
		
		/**
		*	@private	
		*/
		protected function dependenciesLoaded( event:LoadEvent ):void
		{
			_dependencies.removeEventListener(
				LoadEvent.LOAD_COMPLETE, dependenciesLoaded );			

			var loader:ILoader = null;
			var cached:Object = null;
			var style:Object = null;
			for( var i:int = 0;i < _dependencies.getLength();i++ )
			{
				loader = _dependencies.getLoaderAt( i ) as ILoader;
				
				//resource not founds won't have a resource
				if( loader && loader.resource )
				{
					cached = _cache[ loader ];
					if( cached )
					{
						style = getStyle( cached.styleName );
						style[ cached.styleProperty ] = loader.resource.data;
						setStyle( cached.styleName, style );
					}
				}
			}
			
			_cache = null;
			_dependencies = null;
		}
	}
}