package com.ffsys.ioc
{
	import flash.geom.*;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.color.HslColor;
	import com.ffsys.color.RgbColor;
	
	import com.ffsys.io.loaders.types.*;
	
	import com.ffsys.utils.primitives.PrimitiveParser;
	import com.ffsys.utils.properties.PropertiesMerge;
	import com.ffsys.utils.properties.PrimitiveProperties;
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
		private var _mapping:Object;
		private var _delimiter:String = ",";
		
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
		* 	A delimiter to use when parsing mapped
		* 	property expressions to parameter values.
		* 
		* 	The default value is a comma.
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
		* 	The mapping between property names
		* 	and expressions.
		*/
		public function get mapping():Object
		{
			if( _mapping == null )
			{
				_mapping = new Object();
			}
			return _mapping;
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
		public function doWithProperty(
			descriptor:IBeanDescriptor,
			name:String,
			value:* ):Object
		{
			return { name: name, value: value };
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
			var parsed:Object = null;
			var hexExpression:RegExp = /^#[0-9a-fA-F]{2,6}$/;
			var parser:PrimitiveParser = new PrimitiveParser();
			var candidate:Boolean = getSubstitutor( value ).isCandidate();
			var propertyExpression:Boolean = this.mapping.hasOwnProperty( propertyName );
			
			if( candidate )
			{
				output = parseBindingCandidate( descriptor, value );
			}
			if( output is String )
			{	
				output = parser.parse( String( output ), true, document.delimiter );
				
				/*
				trace("BeanTextElementParser::parse() GOT PARSED PRIMITIVE TYPE: ",
					getQualifiedClassName( output ), String( output ), String( output ).indexOf( "," ) > -1 );
				
				if( output is Array )
				{
					trace("BeanTextElementParser::parse() GOT PRIMITIVE ARRAY VALUE: ", output );
				}
				*/
				
				//only if still a string after primitive parsing
				if( output is String )
				{
					var source:String = String( output );
					
					//escaped hex value to be treated as a hex string
					if( /^\\#/.test( source ) )
					{
						output = source.replace( /^\\/, "" );
					}else if( hexExpression.test( source ) )
					{
						output = parseHexNumber( descriptor, source );
					}else
					{					
						var isExpressionCandidate:Boolean = _extensionExpression.test( source );
					
						if( !isExpressionCandidate
							&& source.indexOf( delimiter ) > -1 )
						{
							//trace("BeanTextElementParser::parse() FOUND SIMPLE PARAMETER ARRAY EXPRESSION!!!!!");
						
							output = parser.parse( source, true, delimiter );
							
							/*
							trace("BeanTextElementParser::parse() GOT PARSED SIMPLE ARRAY EXPRESSION: ",
								output, getQualifiedClassName( output ) );
							*/
						}
						
						
						var parameters:Array = ( output is Array ) ? output as Array : null;
						
						//if( output is String )
						{
							if( propertyExpression )
							{
								//handle properties that are mapped to be handled
								//as an expression	
								parsed = handleExpression(
									this.mapping[ propertyName ],
									String( output ),
									descriptor,
									beanName,
									propertyName,
									parameters );
							
								/*
								trace("BeanTextElementParser::parse()",
									"FOUND MATCHING PROPERTY NAME EXPRESSION",
									propertyName, this.mapping[ propertyName ], parsed );
								*/
							
								if( parsed != null )
								{
									output = parsed;
								}						
							
							}else if( isExpressionCandidate )
							{
								parsed = handleExpression(
									getExpression( source ),
									getExpressionValue( source ),
									descriptor,
									beanName,
									propertyName,
									parameters );
								
								if( parsed != null )
								{
									output = parsed;
								}
							}
						}
					
					}
				}
			}
			
			output = finalizePropertyValue(
				output, descriptor, beanName, propertyName, value );
			
			return output;
		}
		
		/**
		* 	Finalizes a property value before it is returned
		* 	to be assigned.
		* 
		* 	This allows derived implementations to perform
		* 	interception after all standard parsing has completed
		* 	for a property.
		* 
		* 	The default implementation returns the parsed object
		* 	unmodified.
		* 
		* 	@param parsed The parsed value.
		* 	@param descriptor The bean descriptor.
		* 	@param beanName The name of the bean.
		* 	@param propertyName The name of the property.
		* 	@param value The raw string value before parsing.
		* 
		* 	@return The original parsed object or an alternative
		* 	object to assign to the property.
		*/
		protected function finalizePropertyValue(
			parsed:Object,
			descriptor:IBeanDescriptor,
			beanName:String,
			propertyName:String,
			value:String ):Object
		{
			return parsed;
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
		
		protected function getExpression( candidate:String ):String
		{
			return candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
		}
		
		protected function getExpressionValue( candidate:String ):String
		{
			var value:String = candidate.replace( _extensionExpression, "$1" );
			value = new StringTrim().trim( value );
			return value;
		}
		
		/**
		*	@private
		*/
		protected function handleExpression(
			expression:String,
			value:String,
			descriptor:IBeanDescriptor,
			beanName:String,
			beanProperty:String = null,
			parameters:Array = null ):Object
		{
			//var expression:String = candidate.replace( /^([a-zA-Z]+)[^a-zA-Z].*$/, "$1" );
			
			var output:Object = null;
			
			var p:Point = null;
			var r:Rectangle = null;
			var m:Matrix = null;
			var c:ColorTransform = null;
			var h:HslColor = null;
			
			//var parameters:Array = null;
			
			//trace("BeanTextElementParser::handleExpression()", expression, value, beanName, parameters );
			
			switch( expression )
			{
				case BeanExpressions.CLASS_EXPRESSION:
					try
					{
						output = Class( getDefinitionByName( value ) );
					}catch( e:Error )
					{
						throw new Error( "Could not locate bean class expression with class path '"
							+ value + "'." );
					}
					break;
				case BeanExpressions.URL_EXPRESSION:
					output = new URLRequest( value );
					break;
				case BeanExpressions.BITMAP_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, ImageLoader );
					break;
				case BeanExpressions.SOUND_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, SoundLoader );					
					break;
				case BeanExpressions.SWF_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, MovieLoader );
					break;
				case BeanExpressions.XML_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, XmlLoader );
					break;
				case BeanExpressions.TEXT_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, TextLoader );
					break;
				case BeanExpressions.FONT_EXPRESSION:
					output = new BeanFileDependency(
						beanName, beanProperty, value, FontLoader );
					break;
				case BeanExpressions.MESSAGES_EXPRESSION:
					output = new BeanFileDependency(
						beanName,
						beanProperty,
						value,
						PropertiesLoader );
					break;
				case BeanExpressions.SETTINGS_EXPRESSION:
					output = new BeanFileDependency(
						beanName,
						beanProperty,
						value,
						PropertiesLoader,
						{ properties: new PrimitiveProperties() } );
					break;
				case BeanExpressions.IMPORT_EXPRESSION:
					output = new BeanFileDependency(
						beanName,
						beanProperty,
						value,
						BeanLoader );
					break;
				case BeanExpressions.REF_EXPRESSION:
					output = new BeanReference( beanName, beanProperty, value );
					break;
				case BeanExpressions.CALL_EXPRESSION:
					output = new BeanMethodCall( beanName, beanProperty, value );
					break;
				case BeanExpressions.CONSTANT_EXPRESSION:
					output = new BeanConstant( beanName, beanProperty, value );
					break;
				case BeanExpressions.METHOD_EXPRESSION:
					output = new BeanMethod( beanName, beanProperty, value );
					break;
				case BeanExpressions.ARRAY_EXPRESSION:
					output = new BeanArray( beanName, beanProperty, value );
					break;
				case BeanExpressions.POINT_EXPRESSION:
					output = new Point();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 2, BeanExpressions.POINT_EXPRESSION );
					p = Point( output );
					p.x = parameters[ 0 ];
					p.y = parameters[ 1 ];
					break;					
				case BeanExpressions.RECTANGLE_EXPRESSION:
					output = new Rectangle();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 4, BeanExpressions.RECTANGLE_EXPRESSION );
					r = Rectangle( output );
					r.left = parameters[ 0 ];
					r.top = parameters[ 1 ];
					r.width = parameters[ 2 ];
					r.height = parameters[ 3 ];
					break;
				case BeanExpressions.MATRIX_EXPRESSION:
					output = new Matrix();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 6, BeanExpressions.MATRIX_EXPRESSION );
					m = Matrix( output );
					m.a = parameters[ 0 ];
					m.b = parameters[ 1 ];
					m.c = parameters[ 2 ];
					m.d = parameters[ 3 ];
					m.tx = parameters[ 4 ];
					m.ty = parameters[ 5 ];
					break;
				case BeanExpressions.COLOR_TRANSFORM_EXPRESSION:
					output = new ColorTransform();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 8, BeanExpressions.COLOR_TRANSFORM_EXPRESSION );
					c = ColorTransform( output );
					c.redMultiplier = parameters[ 0 ];
					c.greenMultiplier = parameters[ 1 ];
					c.blueMultiplier = parameters[ 2 ];
					c.alphaMultiplier = parameters[ 3 ];
					c.redOffset = parameters[ 4 ];
					c.greenOffset = parameters[ 5 ];
					c.blueOffset = parameters[ 6 ];
					c.alphaOffset = parameters[ 7 ];
					break;
				case BeanExpressions.RGB_COLOR_TRANSFORM_EXPRESSION:
					output = new RgbColor();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 3, BeanExpressions.RGB_COLOR_TRANSFORM_EXPRESSION );
					var rgb:RgbColor = RgbColor( output );
					rgb.rgb( parameters[ 0 ], parameters[ 1 ], parameters[ 2 ] );
					break;
				case BeanExpressions.HSL_COLOR_TRANSFORM_EXPRESSION:
					output = new HslColor();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 3, BeanExpressions.HSL_COLOR_TRANSFORM_EXPRESSION );
					h = HslColor( output );
					h.hsl( parameters[ 0 ], parameters[ 1 ], parameters[ 2 ] );
					break;
				case BeanExpressions.TINT_COLOR_TRANSFORM_EXPRESSION:
					output = new HslColor();
					parameters = parseParts( descriptor, beanName, beanProperty, value );
					validateNumericParameterExpression( parameters, 2, BeanExpressions.TINT_COLOR_TRANSFORM_EXPRESSION );
					h = HslColor( output );
					h.tint( parameters[ 0 ], parameters[ 1 ] );
					break;
				default:
				
					/*
					trace("BeanTextElementParser::handleExpression() DEALING WITH UNKNOWN EXPRESSION property/parameters/is array: ", beanProperty, parameters, parameters is Array );
					*/
					
					if( parameters == null )
					{
						parameters = parseParts( descriptor, beanName, beanProperty, value );
					}
					
					/*
					if( !( value is Array ) )
					{
						parameters = parseParts( descriptor, beanName, beanProperty, value );
					}else{
						parameters = ( value as Array );
					}
					*/
					
					var unknown:UnknownExpression = new UnknownExpression(
						beanName,
						beanProperty,
						value,
						expression,
						parameters );
					
					output = doWithUnknownExpression( unknown );
			}
			return output;
		}
		
		/**
		* 	Invoked when an unknown expression is encountered.
		* 
		* 	The default implementation throws an error. Derived
		* 	implementations may modify this behaviour to support
		* 	more expressions.
		* 
		* 	@param target The unknown expression instance.
		* 
		* 	@return An object that should be assigned to the parsed
		* 	bean descriptor.
		* 
		* 	@throws Error An error indicating the expression is unknown.
		*/
		protected function doWithUnknownExpression(
			target:UnknownExpression ):Object
		{
			throw new Error(
				"Unknown bean expression '" + target.expression + "'." );
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
		protected function validateNumericParameterExpression(
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
		protected function toParts( value:String, delimiter:String = "," ):Array
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
		*	@private	
		*/
		protected function parseHexNumber(
			descriptor:IBeanDescriptor,
			candidate:String ):Number
		{
			candidate = candidate.replace( /^#/, "0x" );
			var parsed:Number = Number( candidate );
			return parsed;
		}
		
		/**
		* 	@private
		*/
		protected function parseParts(
			descriptor:IBeanDescriptor,
			beanName:String,
			beanProperty:String,
			value:String,
			delimiter:String = "," ):Array
		{
			if( value.indexOf( delimiter ) == -1 )
			{
				//we don't pass the propertyName back when parsing a single
				//parameter value
				return [ parse( descriptor, beanName, null, value ) ];
			}
			
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
		protected function getSubstitutor(
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