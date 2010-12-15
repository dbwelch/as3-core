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
		implements IBeanPropertyParser
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
		
		public function set document( document:IBeanDocument ):void
		{
			_document = document;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parse(
			descriptor:IBeanDescriptor,
			beanName:String,
			propertyName:String,
			value:String ):Object
		{
			var output:Object = value;
			var extension:Object = null;
			var hexExpression:RegExp = /^#[0-9a-fA-F]{2,6}$/;
			var parser:PrimitiveParser = new PrimitiveParser();	
			
			var candidate:Boolean = getSubstitutor( value ).isCandidate();

			if( candidate )
			{
				output = parseBindingCandidate( descriptor, value );
			}
			
			if( output is String )
			{
				output = parser.parse( String( output ), true, document.delimiter );
				
				//still a string after primitive parsing
				if( output is String )
				{
					if( hexExpression.test( String( output ) ) )
					{
						output = parseHexNumber( descriptor, String( output ) );
					}else if( _extensionExpression.test( String( output ) ) )
					{
						extension = parseExtension( descriptor, String( output ), beanName, propertyName );
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
			//trace("************************* BeanTextElementParser::setBeanProperty()", bean, name, value );
			bean[ name ] = value;
		}
		
		/**
		* 	@private
		*/
		private function parseBindingCandidate( 
			descriptor:IBeanDescriptor,
			value:String ):Object
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
		private function parseHexNumber(
			descriptor:IBeanDescriptor,
			candidate:String ):Number
		{
			candidate = candidate.replace( /^#/, "0x" );
			var parsed:Number = Number( candidate );
			return parsed;
		}
		
		/**
		*	@private
		*/
		private function parseExtension(
			descriptor:IBeanDescriptor,
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
						throw new Error( "Could not locate bean class expression with class path '"
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
				case BeanConstants.MESSAGES_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, PropertiesLoader );
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
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 2, BeanConstants.POINT_EXPRESSION );
					var p:Point = Point( output );
					p.x = parameters[ 0 ];
					p.y = parameters[ 1 ];
					break;					
				case BeanConstants.RECTANGLE_EXPRESSION:
					output = new Rectangle();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 4, BeanConstants.RECTANGLE_EXPRESSION );
					var r:Rectangle = Rectangle( output );
					r.left = parameters[ 0 ];
					r.top = parameters[ 1 ];
					r.width = parameters[ 2 ];
					r.height = parameters[ 3 ];
					break;
				case BeanConstants.MATRIX_EXPRESSION:
					output = new Matrix();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 6, BeanConstants.MATRIX_EXPRESSION );
					var m:Matrix = Matrix( output );
					m.a = parameters[ 0 ];
					m.b = parameters[ 1 ];
					m.c = parameters[ 2 ];
					m.d = parameters[ 3 ];
					m.tx = parameters[ 4 ];
					m.ty = parameters[ 5 ];
					break;
				case BeanConstants.COLOR_TRANSFORM_EXPRESSION:
					output = new ColorTransform();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 8, BeanConstants.COLOR_TRANSFORM_EXPRESSION );
					var c:ColorTransform = ColorTransform( output );
					c.redMultiplier = parameters[ 0 ];
					c.greenMultiplier = parameters[ 1 ];
					c.blueMultiplier = parameters[ 2 ];
					c.alphaMultiplier = parameters[ 3 ];
					c.redOffset = parameters[ 4 ];
					c.greenOffset = parameters[ 5 ];
					c.blueOffset = parameters[ 6 ];
					c.alphaOffset = parameters[ 7 ];
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
		* 
		* 	Validates that an expression that expects number only parameters
		* 	is valid.
		* 
		* 	@param parameters The parsed parameters.
		* 	@param length The expected number of parameters.
		* 	@param expression The expression being evaluated.
		*/
		private function validateNumericParameterExpression(
			parameters:Array, length:int, expression:String ):void
		{
			if( parameters.length != length )
			{
				throw new Error( "Incorrect parameter count for a " + expression + " expression, expected " + length + "." );
			}
			
			for( var i:int = 0;i < parameters.length;i++ )
			{
				if( !( parameters[ i ] is Number ) )
				{
					throw new Error( "The expression value '" + parameters[ i ] + "' is not a number." );
				}
			}
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
			descriptor:IBeanDescriptor,
			beanName:String,
			beanProperty:String,
			value:String,			
			delimiter:String = "," ):Array
		{
			var output:Array = new Array();
			var parts:Array = toParts( value, delimiter );
			var part:String = null;			
			for( var i:int = 0;i < parts.length;i++ )
			{
				output.push( parse( descriptor, beanName, beanProperty, parts[ i ] ) );
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		private function getSubstitutor(
			source:String, target:Object = null ):Substitutor
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