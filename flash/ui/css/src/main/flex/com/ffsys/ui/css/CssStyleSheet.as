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
		
		/**
		* 	The name of the style property that indicates a style
		* 	should be treated as a singleton instance.
		*/
		public static const SINGLETON_PROPERTY:String = "singleton";
		
		/**
		* 	The name of the property used to determine whether a style
		* 	represents a custom class to instantiate when retrieving the style.
		*/
		public static const INSTANCE_CLASS_PROPERTY:String = "instanceClass";
		
		/**
		* 	The name of the property used to determine whether a style
		* 	represents a static class reference.
		*/
		public static const STATIC_CLASS_PROPERTY:String = "staticClass";
		
		/**
		* 	The name of the property used to determine that this style
		* 	is a function reference.
		*/
		public static const METHOD_PROPERTY:String = "method";				
		
		private var _id:String;
		private var _delimiter:String = "|";
		private var _extensionExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*(.+)\s*\)$/;
		private var _dependencies:ILoaderQueue;
		private var _cache:Dictionary;
		
		private var _bindings:IBindingCollection;
		private var _constants:Object;
		private var _singletons:Object = new Object();
		private var _processed:Boolean = false;
		
		private static var extensions:Object = {
			"class": Class,
			"url": URLRequest,
			"img": ImageLoader,
			"sound": SoundLoader,
			"swf": MovieLoader,
			"ref": CssReference,
			"constant": Object,
			"method": Function,
			"array": Array
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
		*	Represents a reference to a style or style property
		* 	in the same document.
		*/
		public static const REF:String = "ref";
		
		/**
		*	Represents a reference to a css constant declaration.
		*/
		public static const CONSTANT:String = "constant";
		
		/**
		*	Represents a reference to a method definition.
		*/
		public static const METHOD:String = "method";
		
		/**
		*	Represents an array collection expression.
		*/
		public static const ARRAY:String = "array";
		
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
			return getStyle( CONSTANTS_STYLE_NAME );
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
		
		public function hasStyle( styleName:String ):Boolean
		{
			var names:Array = this.styleNames;
			return names.indexOf( styleName ) > -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getInstance( styleName:String, style:Object ):Object
		{
			var clazz:Class = null;
			
			try
			{
				clazz = style.instanceClass;
			}catch( e:Error )
			{
				//if the above fails we likely already have a complex object
				//we are definitely not dealing with a dynamic object
				//so return the existing complex object
				return style;
			}
			
			if( style && clazz )
			{
				var instance:Object = null;
				
				try
				{
					instance = new clazz();
				}catch( e:Error )
				{
					throw new Error(
						"Could not instantiate style instance with class '" + style.instanceClass + "'." );
					
					//throw e;
				}
				
				if( instance )
				{
					if( isMethodReference( style ) )
					{
						return getMethod( style, instance ) as Function;
					}

					var merger:PropertiesMerge = new PropertiesMerge();
					merger.merge( instance, style, true, [ CssReference, CssArray ] );
				}

				return instance;
			}
			
			return null;
		}
		
		/**
		* 	@private
		*/
		private function resolve( style:Object ):void
		{
			var z:String = null;
			var o:Object = null;
			var resolver:ICssResolver = null;
			var loop:Boolean = false;
			var resolved:Object = null;
			for( z in style )
			{
				o = style[ z ];
				if( o is ICssResolver && !( o is CssMethod ) )
				{
					resolver = ICssResolver( o );
					resolved = resolver.resolve( this, style );
			
					loop = ( resolved is ICssResolver ) && ( resolved != resolver )
					while( loop )
					{
						resolved = ICssResolver( resolved ).resolve( this, style );
						loop = ( resolved is ICssResolver ) && ( resolved != resolver );
					}
					
					setStyleProperty( style, z, resolved );
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function resolveConstants( style:Object ):void
		{
			if( style )
			{
				var z:String = null;
				for( z in style )
				{
					if( style[ z ] is CssConstant )
					{
						style[ z ] = CssConstant( style[ z ] ).resolve( this, style );
					}
				}
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getStyle( styleName:String ):Object
		{
			var style:Object = null;
			
			if( styleName != null )
			{
				style = super.getStyle( styleName );
				
				if( _processed )
				{
					//we must resolve constants before instantiation in case
					//an instance class is a constant reference
					resolveConstants( style );
				}
				
				var isInstance:Boolean = ( style && ( style[ INSTANCE_CLASS_PROPERTY ] is Class ) );
				var isStatic:Boolean = ( style && ( style[ STATIC_CLASS_PROPERTY ] is Class ) );
				
				if( style && _processed )
				{
					//resolve references
					resolve( style );
				}	
				
				//during processing we don't resolve instances so return early
				if( !_processed )
				{
					return style;
				}
			
				if( style && style.hasOwnProperty( SINGLETON_PROPERTY ) )
				{
					if( style[ SINGLETON_PROPERTY ] === true )
					{
						if( !isInstance )
						{
							throw new Error( "Cannot access a singleton with no instance class." );
						}
					
						var exists:Boolean = _singletons.hasOwnProperty( styleName )
							&& _singletons[ styleName ] != null;
					
						//create the singleton for the first time
						if( !exists )
						{
							_singletons[ styleName ] = getInstance( styleName, style );
						}
					
						return _singletons[ styleName ];
					}
				}
			
				if( isStatic )
				{
					var clazz:Class = style[ STATIC_CLASS_PROPERTY ];
				
					//TODO: check setting static properties using a properties merge
				
					if( isMethodReference( style ) )
					{
						return getMethod( style, clazz ) as Function;
					}
				
					return clazz;
				}else if( isInstance )
				{
					return getInstance( styleName, style );
				}
			
				//the default behaviour of returning an empty
				//object when the style does not exist is undesirable
				//so we test for existence of at least one property			
				for( var z:String in style )
				{
					return style;
				}
				
				//return style;
			}
			
			return null;
		}
		
		private function isMethodReference( style:Object ):Boolean
		{
			return style && style[ METHOD_PROPERTY ] && ( style[ METHOD_PROPERTY ] is CssMethod );
		}
		
		/**
		* 	@private
		*/
		private function getMethod( style:Object, target:Object ):Function
		{
			//handle method references
			if( isMethodReference( style ) )
			{
				return CssMethod( style[ METHOD_PROPERTY ] ).resolve( this, target ) as Function;
			}
			
			return null;	
		}
		
		/**
		*	@inheritDoc
		*/
		override public function parseCSS( text:String ):void
		{
			_processed = false;
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
			if( style && target )
			{
				
				if( target is IPaddingAware )
				{
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
					
						if( txt.text )
						{
							txt.text = txt.text;
						}
						
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
			var value:*;
			var styles:Array = styleNames;
			var constantsIndex:int = styles.indexOf( CONSTANTS_STYLE_NAME );

			//we have a constants style defined so it should be moved to the beginning
			//so that it is processed before any other styles
			if( constantsIndex > -1 )
			{
				//remove the item and prepend to the beginning of the style names to process
				styles.unshift.apply( styles, styles.splice( constantsIndex, 1 ) );
			}

			for( var i:int = 0;i < styles.length;i++ )
			{
				styleName = styles[ i ];
				style = getStyle( styleName );
			
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
						value = parseElement( String( value ), styleName, z );
					}
					
					setStyleProperty( style, z, value );
				}
				
				//keep a reference to the constants style object
				if( styleName == CONSTANTS_STYLE_NAME )
				{
					_constants = style;
				}

				setStyle( styleName, style );
			}
			
			_processed = true;
		}
		
		private function setStyleProperty( style:Object, name:String, value:Object ):void
		{
			trace("************************* CssStyleSheet::setStyleProperty()", name, value);
			style[ name ] = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parseElement( value:String, styleName:String, propertyName:String ):Object
		{
			var output:Object = value;
			var extension:Object = null;
			var hexExpression:RegExp = /^#[0-9a-fA-F]{2,6}$/;
			var parser:PrimitiveParser = new PrimitiveParser();				
		
			var candidate:Boolean = getSubstitutor( value ).isCandidate();

			if( candidate )
			{
				output = parseBindingCandidate( value );
			}
			
			if( output is String )
			{
				output = parser.parse( String( output ), true, delimiter );
				
				//still a string after primitive parsing
				if( output is String )
				{
					if( hexExpression.test( String( output ) ) )
					{
						output = parseHexNumber( String( output ) );
					}else if( _extensionExpression.test( String( output ) ) )
					{
						extension = parseExtension( String( output ), styleName, propertyName );
						if( extension != null )
						{
							output = extension;
						}
					}
				
				}
			
			}
			
			return output;			
		}
		
		/**
		* 	@private
		*/
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
			if( !isValidExtension( candidate ) )
			{
				return null;
			}
			
			var extension:String = candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
			var output:Object = null;
			
			var value:String = candidate.replace( _extensionExpression, "$1" );
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
				case REF:
					output = new CssReference( styleName, styleProperty, value );
					break;
				case CONSTANT:
					output = new CssConstant( styleName, styleProperty, value );
					break;
				case METHOD:
					output = new CssMethod( styleName, styleProperty, value );
					break;
				case ARRAY:
					output = new CssArray( styleName, styleProperty, value );
					break;
				default:
					throw new Error(
						"Could not handle css expression with identifier '" + extension + "'." );
			}
			
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
						
						//style[ cached.styleProperty ] = data;
						
						setStyleProperty( style, cached.styleProperty, data );
						setStyle( cached.styleName, style );
					}
				}
			}
			
			_cache = null;
			_dependencies = null;
		}
	}
}

interface ICssResolver {
	
	import com.ffsys.ui.css.ICssStyleSheet;
	
	/**
	* 	Attempts to resolve this reference in the context
	* 	of the specified stylesheet.
	* 
	* 	@param stylesheet The stylesheet context for to resolve
	* 	this reference in.
	* 	@param style The style object.
	* 
	* 	@return The object this reference refers to or null if no corresponding
	* 	reference value was found.
	*/
	function resolve( stylesheet:ICssStyleSheet, style:Object ):Object;
}

class CssResolver extends Object {
	
	import com.ffsys.ui.css.ICssStyleSheet;	

	protected function find( target:Object, style:Object, stylesheet:ICssStyleSheet ):Object
	{	
		var loop:Boolean = false;
		loop = ( target is ICssResolver )
		while( loop )
		{
			target = ICssResolver( target ).resolve( stylesheet, style );
			loop = ( target is ICssResolver );
		}
		
		return target;
	}
	
}

class CssArray extends CssResolver
	implements ICssResolver {
	
	import com.ffsys.ui.css.CssStyleSheet;
	import com.ffsys.ui.css.ICssStyleSheet;	
	
	import flash.utils.getQualifiedClassName;
	
	/**
	* 	The name of the style that holds this method.
	*/
	public var styleName:String;
	
	/**
	* 	The name of the style property that holdes this method.
	*/
	public var name:String;
	
	/**
	* 	The refrerence value extracted when this method was parsed.
	*/
	public var value:String;
	
	/**
	* 	Creates a <code>CssArray</code> instance.
	* 
	* 	@param styleName The name of the style.
	* 	@param name The name of the style property.
	* 	@param value The constant value.
	*/
	public function CssArray(
		styleName:String,
		name:String,
		value:String ):void
	{
		super();
		this.styleName = styleName;
		this.name = name;
		this.value = value;		
	}
	
	/**
	* 	This method differs from other implementations in that it expects
	* 	the <code>style</code> parameter to be the object that contains
	* 	the method reference.
	* 
	* 	@inheritDoc
	*/
	public function resolve( stylesheet:ICssStyleSheet, style:Object ):Object
	{
		if( stylesheet != null )
		{	
			var parts:Array = this.value.split( "," );
			var part:String = null;
			var parsed:Object = null;
			
			trace("CssArray::resolve()", this.value, parts );
			
			for( var i:int = 0;i < parts.length;i++ )
			{
				part = String( parts[ i ] );
				
				part = part.replace(/^\s+/,"");
				part = part.replace(/\s+$/,"");
	
				//overwrite the array entry with the parsed value
				parsed = stylesheet.parseElement( part, styleName, this.name );
				
				trace("CssStyleSheet::resolve() RESOLVED: ", parsed, getQualifiedClassName( parsed ) );
				
				if( parsed is ICssResolver )
				{
					parsed = find( parsed, style, stylesheet );
				}
				
				//update the array element
				parts[ i ] = parsed;
			}
			return parts;
		}	
		
		return null;
	}
}

class CssMethod extends Object
	implements ICssResolver {
	
	import com.ffsys.ui.css.CssStyleSheet;
	import com.ffsys.ui.css.ICssStyleSheet;	
	
	/**
	* 	The name of the style that holds this method.
	*/
	public var styleName:String;
	
	/**
	* 	The name of the style property that holdes this method.
	*/
	public var name:String;
	
	/**
	* 	The refrerence value extracted when this method was parsed.
	*/
	public var value:String;
	
	/**
	* 	Creates a <code>CssMethod</code> instance.
	* 
	* 	@param styleName The name of the style.
	* 	@param name The name of the style property.
	* 	@param value The constant value.
	*/
	public function CssMethod(
		styleName:String,
		name:String,
		value:String ):void
	{
		super();
		this.styleName = styleName;
		this.name = name;
		this.value = value;		
	}
	
	/**
	* 	This method differs from other implementations in that it expects
	* 	the <code>style</code> parameter to be the object that contains
	* 	the method reference.
	* 
	* 	@inheritDoc
	*/
	public function resolve( stylesheet:ICssStyleSheet, style:Object ):Object
	{
		if( stylesheet != null )
		{
			var method:Object = null;
			
			try
			{
				method = style[ this.value ];
			}catch( e:Error )
			{
				throw new Error( "Could not locate method reference with identifier '" + this.value + "'." );
			}
			
			if( method && !( method is Function ) )
			{
				throw new Error( "The method reference '" + this.value + "' does not correspond to a function." );
			}
			
			return method as Function;
		}
		return null;
	}
}

class CssConstant extends CssResolver
	implements ICssResolver {
	
	import com.ffsys.ui.css.CssStyleSheet;
	import com.ffsys.ui.css.ICssStyleSheet;	
	
	/**
	* 	The name of the style that holds this constant.
	*/
	public var styleName:String;
	
	/**
	* 	The name of the style property that holdes this constant.
	*/
	public var name:String;
	
	/**
	* 	The refrerence value extracted when this constant was parsed.
	*/
	public var value:String;
	
	/**
	* 	Creates a <code>CssReference</code> instance.
	* 
	* 	@param styleName The name of the style.
	* 	@param name The name of the style property.
	* 	@param value The constant value.
	*/
	public function CssConstant(
		styleName:String,
		name:String,
		value:String ):void
	{
		super();
		this.styleName = styleName;
		this.name = name;
		this.value = value;		
	}
	
	/**
	* 	@private
	*/
	private function toCamelCase():String
	{
		//convert to camel case
		var re:RegExp = /^([^\-]*)\-([a-z]{1})(.*)$/;
		var matches:Object = re.exec( this.value );
		var camel:String = this.value;
		
		if( matches )
		{
			camel = "";
			var part:String = null;
			var i:int = 1;
  			for( ;i < matches.length;i++ )
			{
				part = matches[ i ];
				if( i % 2 == 0 )
				{
					part = part.toUpperCase();
				}
				camel += part;
			}
		}
		
		return camel;	
	}
	
	/**
	* 	@inheritDoc
	*/
	public function resolve( stylesheet:ICssStyleSheet, style:Object ):Object
	{
		if( stylesheet != null )
		{
			var constants:Object = stylesheet.constants;
			
			if( constants == null )
			{
				throw new Error( "Cannot handle a constant reference expression with no declared constants." );
			}
			
			//convert to camel case
			var re:RegExp = /^([^\-]*)\-([a-z]{1})(.*)$/;
			var matches:Object = re.exec( this.value );
			var camel:String = toCamelCase();

			if( !constants.hasOwnProperty( camel ) )
			{
				throw new Error( "The constant reference '" + camel + "' has not been declared." );
			}
		
			//extract the constant from the constants style declaration
			return constants[ camel ];
		}
		return null;
	}
}

/**
*	Used to store a reference to another css style or style
*	property. During the finalization phase these references
*	are resolved. This type is used to indicate which properties
*	need resolving.
*/
class CssReference extends CssResolver
	implements ICssResolver {
	
	import com.ffsys.ui.css.CssStyleSheet;
	import com.ffsys.ui.css.ICssStyleSheet;	
	
	/**
	* 	The name of the style that holds this reference.
	*/
	public var styleName:String;
	
	/**
	* 	The name of the style property that this reference applies to.
	*/
	public var name:String;
	
	/**
	* 	The refrerence value extracted when this reference was parsed.
	*/
	public var value:String;
	
	/**
	* 	Creates a <code>CssReference</code> instance.
	* 
	* 	@param styleName The name of the style.
	* 	@param name The name of the style property.
	* 	@param value The reference value.
	*/
	public function CssReference(
		styleName:String,
		name:String,
		value:String ):void
	{
		super();	
		this.styleName = styleName;
		this.name = name;
		this.value = value;
	}
	
	/**
	* 	@inheritDoc
	*/
	public function resolve( stylesheet:ICssStyleSheet, style:Object ):Object
	{
		if( stylesheet )
		{
			var candidate:String = this.value;
			var found:Object;

			//we check the delimiter is beyond the first character
			if( candidate.lastIndexOf( CssStyleSheet.REFERENCE_PROPERTY_DELIMITER ) > 0 )
			{
				if( candidate.indexOf( CssStyleSheet.REFERENCE_PROPERTY_DELIMITER ) == 0 )
				{
					//remove the first character if it matches the reference delimiter
					candidate = candidate.substr( 1 );
				}
			
				var parts:Array = candidate.split( CssStyleSheet.REFERENCE_PROPERTY_DELIMITER );
				if( !(parts.length == 2 ) )
				{
					throw new Error( "Found invalid css reference candidate '" + candidate + "'." );
				}
			
				candidate = parts[ 0 ];
				var property:String = parts[ 1 ];
				var candidateStyle:Object = stylesheet.getStyle( candidate );
				if( !candidateStyle )
				{
					throw new Error(
						"Could not locate style reference with value '" + candidate + "'." );					
				}
			
				found = candidateStyle[ property ];
			}else{
				found = stylesheet.getStyle( candidate );
				
				/*
				if( found is ICssResolver && found != this )
				{
					found = find( found, style, stylesheet );
				}
				*/			
			}
		
			if( found == null )
			{
				throw new Error(
					"Could not locate style reference with value '" + candidate + "'." );
			}
			
			return found;
		}
		
		return style;
	}
}