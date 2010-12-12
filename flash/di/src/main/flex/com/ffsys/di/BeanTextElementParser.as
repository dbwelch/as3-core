package com.ffsys.di
{
	import flash.geom.*;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.io.loaders.types.*;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	import com.ffsys.utils.properties.PropertiesMerge;
	import com.ffsys.utils.string.StringTrim;
	
	import com.ffsys.utils.substitution.*;
	
	/**
	*	Responsible for parsing an individual bean property within
	* 	a text document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanTextElementParser extends Object
	{
		private var _document:IBeanDocument;
		private var _substitutor:Substitutor = null;
		private var _extensionExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*(.+)\s*\)$/;
		
		/**
		* 	Creates a <code>BeanTextElementParser</code> instance.
		* 
		* 	@param document A bean document to parse into.
		*/
		public function BeanTextElementParser(
			document:IBeanDocument = null )
		{
			super();
			this.document = document;
		}
		
		/**
		* 	The document the bean text is being parsed into.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document(document:IBeanDocument):void
		{
			_document = document;
		}
		
		/**
		* 	Parses a bean text property.
		* 
		* 	@param value The parsed value.
		* 	@param bean The name of the bean.
		* 	@param propertyName The name of the bean property.
		* 
		* 	@return The parsed object.
		*/
		public function parse(
			value:String,
			beanName:String,
			propertyName:String ):Object
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
				output = parser.parse( String( output ), true, document.delimiter );
				
				//still a string after primitive parsing
				if( output is String )
				{
					if( hexExpression.test( String( output ) ) )
					{
						output = parseHexNumber( String( output ) );
					}else if( _extensionExpression.test( String( output ) ) )
					{
						extension = parseExtension( String( output ), beanName, propertyName );
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
		public function setBeanProperty( bean:Object, name:String, value:Object ):void
		{
			//trace("************************* BeanTextElementParser::setBeanProperty()", name, value);
			bean[ name ] = value;
		}		
		
		/**
		* 	@private
		*/
		private function parseBindingCandidate( value:String ):Object
		{
			var output:Object = value;
			if( document && document.bindings )
			{
				var substitutor:Substitutor =
					getSubstitutor( ( value as String ), this );
				substitutor.namespaces = document.bindings;
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
		*	@private
		*/
		private function parseExtension(
			candidate:String,
			beanName:String,
			beanProperty:String = null ):Object
		{
			var extension:String = candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
			var output:Object = null;
			
			var value:String = candidate.replace( _extensionExpression, "$1" );
			value = new StringTrim().trim( value );
			var parameters:Array = null;
			
			switch( extension )
			{
				case BeanConstants.CLASS_EXPRESSION:
					try
					{
						output = Class( getDefinitionByName( value ) );
					}catch( e:Error )
					{
						throw new Error( "Could not locate bean bean class reference with class path '"
							+ value + "'." );
					}
					break;
				case BeanConstants.URL_EXPRESSION:
					output = new URLRequest( value );
					break;
				case BeanConstants.BITMAP_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, ImageLoader );
					break;
				case BeanConstants.SOUND_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, SoundLoader );					
					break;
				case BeanConstants.SWF_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, MovieLoader );
					break;
				case BeanConstants.XML_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, XmlLoader );
					break;
				case BeanConstants.TEXT_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, TextLoader );
					break;
				case BeanConstants.FONT_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, FontLoader );
					break;
				case BeanConstants.REF_EXPRESSION:
					output = new BeanReference( beanName, beanProperty, value );
					break;
				case BeanConstants.CONSTANT_EXPRESSION:
					output = new BeanConstant( beanName, beanProperty, value );
					break;
				case BeanConstants.METHOD_PROPERTY:
					output = new BeanMethod( beanName, beanProperty, value );
					break;
				case BeanConstants.ARRAY_EXPRESSION:
					output = new BeanArray( beanName, beanProperty, value );
					break;
				case BeanConstants.POINT_EXPRESSION:
					output = new Point();
					parameters = parseParts( value, beanName, beanProperty );
					if( parameters.length > 2 )
					{
						throw new Error( "Too many parameters for a point expression." );
					}
					
					if( parameters.length > 0 )
					{
						var p:Point = Point( output );
						p.x = parameters[ 0 ];	
						if( parameters.length > 1 )
						{
							p.y = parameters[ 1 ];
						}
					}
					break;					
				case BeanConstants.RECTANGLE_EXPRESSION:
					output = new Rectangle();
					parameters = parseParts( value, beanName, beanProperty );
					
					if( parameters.length != 4 )
					{
						throw new Error( "Incorrect parameter count for a rectangle expression, must be: left, top, width, height." );
					}

					var r:Rectangle = Rectangle( output );
					r.left = parameters[ 0 ];
					r.top = parameters[ 1 ];
					r.width = parameters[ 2 ];
					r.height = parameters[ 3 ];
					break;
				default:
					throw new Error(
						"Could not handle bean expression with identifier '" + extension + "'." );
			}
			
			if( document && ( output is BeanFileDependency ) )
			{
				document.files.push(
					BeanFileDependency( output ) );
			}
			
			return output;
		}
		
		/**
		* 	@private
		*/
		private function toParts( value:String, delimiter:String = "," ):Array
		{
			var parts:Array = value.split( "," );
			var part:String = null;
			for( var i:int = 0;i < parts.length;i++ )
			{
				part = String( parts[ i ] );
				part = part.replace(/^\s+/,"");
				part = part.replace(/\s+$/,"");
				parts[ i ] = part;
			}			
			return parts;
		}
		
		/**
		* 	@private
		*/
		private function parseParts(
			value:String,
			beanName:String,
			beanProperty:String,
			delimiter:String = "," ):Array
		{
			var output:Array = new Array();
			var parts:Array = toParts( value, delimiter );
			var part:String = null;			
			for( var i:int = 0;i < parts.length;i++ )
			{
				output.push( parse( parts[ i ], beanName, beanProperty ) );
			}
			return output;
		}
		
		/**
		* 	@private
		*/
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
	}
}