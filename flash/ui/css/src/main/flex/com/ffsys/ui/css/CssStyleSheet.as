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
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.graphics.IComponentGraphic;	
	import com.ffsys.ui.graphics.IFill;
	import com.ffsys.ui.graphics.IStroke;	
	
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
	public class CssStyleSheet extends StyleSheet
		implements ICssStyleSheet {
			
		/**
		* 	The delimiter used to delimit style names within a single string declaration.
		*/
		public static const STYLE_DELIMITER:String = " ";
		
		/**
		* 	The name of the style that defines constants for the
		* 	stylesheet.
		*/
		public static const CONSTANTS_STYLE_NAME:String = "constants";
		
		private var _id:String;
		private var _delimiter:String = "|";
		private var _extensionExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*([^)\s]+)\s*\)$/;
		private var _dependencies:ILoaderQueue;
		private var _cache:Dictionary;
		
		private var _bindings:IBindingCollection;
		private var _constants:Object;
		
		private static var extensions:Object = {
			"class": Class,
			"url": URLRequest,
			"img": ImageLoader,
			"sound": SoundLoader,
			"swf": MovieLoader,
			"ref": CssReference,
			"constant": Object
		};
		
		private var _processed:Boolean = false;
		
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
		*	Represents a reference to a style or style property
		* 	in the same document.
		*/
		public static const REF:String = "ref";
		
		/**
		*	Represents a reference to a css constant declaration.
		*/
		public static const CONSTANT:String = "constant";		
		
		/**
		*	The delimiter used in reference expressions to delimit
		* 	a property from the style name.
		*/
		public static const REFERENCE_PROPERTY_DELIMITER:String = ".";
		
		/**
		*	Represents a hexadecimal number notation.
		*/
		public static const HEX_NUMBER:String = "#";
		
		/**
		*	Creates a <code>CssStyleSheet</code> instance.
		*/
		public function CssStyleSheet()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get constants():Object
		{
			return _constants;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get bindings():IBindingCollection
		{
			return _bindings;
		}
		
		public function set bindings( bindings:IBindingCollection ):void
		{
			_bindings = bindings;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get delimiter():String
		{
			return _delimiter;
		}
		
		public function set delimiter( value:String ):void
		{
			_delimiter = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get dependencies():ILoaderQueue
		{
			return _dependencies;
		}
		
		/**
		*	@inheritDoc
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
		
		protected function getInstanceFromStyle( styleName:String, style:Object ):Object
		{
			if( style && ( style.instanceClass is Class ) )
			{
				var instance:Object = null;
				
				try
				{
					instance = new style.instanceClass();
				}catch( e:Error )
				{
					throw new Error( "Could not instantiate style instance with class '"
						+ style.instanceClass + "'." );
				}
				
				if( instance )
				{
					var merger:PropertiesMerge = new PropertiesMerge();
					merger.merge( instance, style, true, [ CssReference ] );
				}

				return instance;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getStyle( styleName:String ):Object
		{
			var style:Object = super.getStyle( styleName );
			
			//workaround for class expressions not always resolving correctly
			if( style && ( style.instanceClass is String ) )
			{
				style.instanceClass = parseExtension( style.instanceClass, styleName );
			}
			
			if( style && ( style.instanceClass is Class ) && _processed )
			{
				return getInstanceFromStyle( styleName, style );
			}
			
			//the default behaviour of returning an empty
			//object when the style does not exist is undesirable
			//so we test for existence of at least one property			
			for( var z:String in style )
			{
				return style;
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function parseCSS( text:String ):void
		{
			super.parseCSS( text );
			postProcessCss();
		}
		
		/**
		*	@inheritDoc
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
			var style:Object = getStyle( styleName );
			return style as BitmapFilter;
		}

		/**
		*	@inheritDoc	
		*/
		public function getStyles( styleName:String ):Array
		{
			//trace("*** CssStyleSheet::getStyles(), GETTING STYLES FOR: ", styleName );
			
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
				//trace("CssStyleSheet::getStyle(), GOT STYLE FOR STYLE NAME: ", id, styleName, style );
				output.push( style );
			}
			
			//trace("*** CssStyleSheet::getStyles(), RETURNING STYLES FOR: ", styleName, output );
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function style( target:IStyleAware, ...custom ):void
		{
			if( target )
			{
				custom.unshift( target );
				var styles:Array = getStyleObjects.apply( this, custom );
				if( styles.length > 0 )
				{
					applyStyles( target, styles );
				}
			}
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
				className = className.substr( className.indexOf( "::" ) + 2 );
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
		*	@private	
		*/
		private function applyStyles( target:Object, styles:Array ):void
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
					
					//trace("CssStyleSheet::applyPadding(), ASSIGNING PADDING: ", target.paddings.left );				
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
		public function assign( target:Object, source:Object, name:String, value:* ):Boolean
		{
			//trace("CssStyleSheet::assign()", target, source, name, value );
			
			if( target is ICssProperty )
			{
				
				var property:ICssProperty = ICssProperty( target );
				if( property.shouldSetCssProperty( name, value ) )
				{
					//delegate css property assignment
					property.setCssProperty( name, value );
					return false;
				}
			}
			return true;		
		}
		
		/**
		*	@private	
		*/
		private function applyStyle( target:Object, style:Object ):void
		{
			//trace("CssStyleSheet::applyStyle()", target, style );
			
			if( style && target )
			{
				
				if( target is IPaddingAware )
				{
					//trace("CssStyleSheet::applyStyle(), APPLYING PADDING: ", target, style );
					applyPadding( IPaddingAware( target ), style );
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
					
						//trace("CssStyleSheet::apply(), txt text: ", txt.text );
					
						if( txt.text )
						{
							txt.text = txt.text;
						}
						
						
						//txt.border = true;
						//txt.background = true;
						
						/*
						trace("CssStyleSheet::apply(), ",
							txt, txt.embedFonts, txt.defaultTextFormat, txt.defaultTextFormat.font, txt.width, txt.height, txt.visible, txt.defaultTextFormat.color );
						*/
					}
				}
			}			
		}
		
		private var _substitutor:Substitutor = null;
		private function getSubstitutor( source:String, target:Object = null ):Substitutor
		{
			if( !_substitutor )
			{
				_substitutor = new Substitutor();
				_substitutor.startDelimiter = "<";
				_substitutor.endDelimiter = ">";
			}
			
			_substitutor.source = source;
			_substitutor.target = target;
			
			return _substitutor;
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
			
			var constantsIndex:int = styles.indexOf( CONSTANTS_STYLE_NAME );

			//we have a constants style defined so it should be moved to the beginning
			//so that it is processed before any other styles
			if( constantsIndex > -1 )
			{
				//remove the item and prepend to the beginning of the style names to process
				styles.unshift.apply( styles, styles.splice( constantsIndex, 1 ) );
			}
			
			//trace("********************** CssStyleSheet::postProcessCss(), " );

			for( var i:int = 0;i < styles.length;i++ )
			{
				styleName = styles[ i ];
				style = getStyle( styleName );
				
				//trace("CssStyleSheet::postProcessCss(), ", styleName, style );
				for( z in style )
				{
					value = style[ z ];
					
					//TODO: investigate why we can't parse here due to a bug
					//with iterating the same property twice after it has been
					//converted to a class it is being re-assigned as a string
					//value = parser.parse( value, true, delimiter );

					//we've parsed the primitives
					//now deal with css specific parsing
					if( value is String )
					{
						var candidate:Boolean = getSubstitutor( value ).isCandidate();

						if( candidate )
						{
							value = parseBindingCandidate( value );
						}
						
						value = parser.parse( value, true, delimiter );
						//trace("CssStyleSheet::postProcessCss(), value/hex/expression: ", value, hexExpression.test( value ), _extensionExpression.test( value ) );
						
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
				
				//keep a reference to the constants style object
				if( styleName == CONSTANTS_STYLE_NAME )
				{
					_constants = style;
				}				
				
				//trace("********************** CssStyleSheet::postProcessCss(), setting style: ", styleName, style, style.instanceClass );
				
				setStyle( styleName, style );
			}
			
			//trace( "STARTING FINALIZATION" );
			
			finalize();

			_processed = true;
		}
		
		/**
		* 	Finalizes css references.
		*/
		private function finalize():void
		{
			var z:String = null;
			var value:*;
			var style:Object = null;
			var styleName:String = null;
			var styles:Array = styleNames;
			for( var i:int = 0;i < styles.length;i++ )
			{
				styleName = styles[ i ];
				style = getStyle( styleName );
				for( z in style )
				{
					value = style[ z ];
					if( value is CssReference )
					{
						resolveCssReference( styleName, style, z, value, CssReference( value ) );
					}
				}
			}
		}
		
		/**
		* 	Attempts to resolve a css reference.
		*/
		private function resolveCssReference(
			styleName:String,
			style:Object,
			name:String,
			value:String,
			reference:CssReference ):void
		{
			var candidate:String = reference.value;
			var found:Object;
			
			//trace("CssStyleSheet::finalize()", "RESOLVING CSS REFERENCE: ", reference );
			
			//we check the delimiter is beyond the first character
			if( candidate.lastIndexOf( REFERENCE_PROPERTY_DELIMITER ) > 0 )
			{
				if( candidate.indexOf( REFERENCE_PROPERTY_DELIMITER ) == 0 )
				{
					//remove the first character if it matches the reference delimiter
					candidate = candidate.substr( 1 );
				}
				
				var parts:Array = candidate.split( REFERENCE_PROPERTY_DELIMITER );
				if( !(parts.length == 2 ) )
				{
					throw new Error( "Found invalid css reference candidate '" + candidate + "'." );
				}
				
				candidate = parts[ 0 ];
				var property:String = parts[ 1 ];
				var candidateStyle:Object = getStyle( candidate );
				if( !candidateStyle )
				{
					throw new Error(
						"Could not locate style reference with value '" + candidate + "'." );					
				}
				
				found = candidateStyle[ property ];
			}else{
				
				//trace("CssStyleSheet::finalize() SEARCHING FOR STYLE candidate: ", candidate );
				
				found = getStyle( candidate );
				
				if( found && found.instanceClass )
				{
					found = getInstanceFromStyle( styleName, found );
				}
				
				
				//trace("CssStyleSheet::finalize() SEARCHING FOR STYLE found: ", found );				
			}
			
			if( found == null )
			{
				throw new Error(
					"Could not locate style reference with value '" + candidate + "'." );
			}
			
			//update the reference
			style[ name ] = found;
			
			//trace("CssStyleSheet::finalize()", " setting css reference ", styleName, name, found );
			
			//update the stored style
			setStyle( styleName, style );
		}

		private function parseBindingCandidate( value:String ):Object
		{
			var output:Object = value;
			
			if( this.bindings )
			{
				var substitutor:Substitutor =
					getSubstitutor( ( value as String ), this );
				substitutor.namespaces = this.bindings;
				output = substitutor.substitute();
			}
			
			return output;
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
				if( candidate.indexOf( z ) == 0 )
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
			styleProperty:String = null ):Object
		{
			//trace("CssStyleSheet::parseExtension()", candidate );
			
			if( !isValidExtension( candidate ) )
			{
				return null;
			}
			
			var extension:String = candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
			var output:Object = null;
			
			var value:String = candidate.replace( _extensionExpression, "$1" );
			value = new StringTrim().trim( value );
			
			//trace("CssStyleSheet::parseExtension()", candidate, extension, value );
			
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
					
					//trace("CssStyleSheet::parseExtension() SETTING CLASS REFERENCE!!!!!!!!!!!!!!!!!!!!!!!: ", output );
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
				case REF:
					output = new CssReference( value );
					break;
				case CONSTANT:
					if( this.constants == null )
					{
						throw new Error( "Cannot handle a constant reference expression with no declared constants." );
					}
					
					if( !this.constants.hasOwnProperty( value ) )
					{
						throw new Error( "The constant reference '" + value + "' has not been declared." );
					}
					
					//extract the constant from the constants style declaration
					output = this.constants[ value ];
					break;
				default:
					throw new Error(
						"Could not handle css expression with identifier '" + extension + "'." );
			}
			
			//trace("CssStyleSheet::parseExtension(), ", output );
			
			if( _dependencies && ( output is ILoader ) && styleProperty )
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
			var data:Object = null;
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
						data = loader.resource.data;
						
						//wrap bitmap data as bitmap display objects
						if( data is BitmapData )
						{
							data = new Bitmap( BitmapData( data ) );
						}
						
						style[ cached.styleProperty ] = data;
						setStyle( cached.styleName, style );
					}
				}
			}
			
			_cache = null;
			_dependencies = null;
		}
	}
}

/**
*	Used to store a reference to another css style or style
*	property. During the finalization phase these references
*	are resolved. This type is used to indicate which properties
*	need resolving.
*/
class CssReference extends Object {
	public var value:String;
	public function CssReference( value:String ):void
	{
		super();
		this.value = value;
	}
}