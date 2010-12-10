package com.ffsys.di
{
	import flash.net.URLRequest;	
	import flash.text.StyleSheet;
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
	
	import com.ffsys.utils.substitution.*;	
	
	public class BeanTextParser extends BeanMediaParser
	{
		private var _beanSheet:StyleSheet;
		
		/*
		private var _substitutor:Substitutor = null;
		private var _extensionExpression:RegExp = /^[a-zA-Z0-9]+\s*\(\s*(.+)\s*\)$/;
		*/
		
		private var _cache:Dictionary;
		private var _dependencies:ILoaderQueue;
		
		/**
		* 	Creates a <code>BeanTextParser</code> instance.
		* 
		* 	@param document A bean document to parse into.
		*/
		public function BeanTextParser( document:IBeanDocument = null )
		{
			super( document );
			this.delimiter = "|";
		}
		
		/**
		*	@inheritDoc
		*/
		public function get dependencies():ILoaderQueue
		{
			return _dependencies;
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function parse( text:String ):IBeanDocument
		{
			if( text != null )
			{
				if( !this.document )
				{
					this.document = new BeanDocument();
				}
			
				_beanSheet = new StyleSheet();
				_beanSheet.parseCSS( text );
			
				var bean:Object = null;
				var beanNames:Array = _beanSheet.styleNames;
				var name:String = null;
				var descriptor:IBeanDescriptor = null;
				
				for( var i:int = 0;i < beanNames.length;i++ )
				{
					name = beanNames[ i ];
					bean = _beanSheet.getStyle( name );
					processBean( name, bean );
					descriptor = new BeanDescriptor( bean );
					if( descriptor.id == null )
					{
						descriptor.id = name;
					}
					this.document.addBeanDescriptor( descriptor );
				}
			
				return this.document;
			}
			
			return null;
		}
		
		/**
		* 	@private
		*/
		private function processBean( beanName:String, bean:Object ):void
		{
			var parser:BeanTextElementParser = new BeanTextElementParser(
				this.document, this.delimiter );
			var z:String = null;
			var value:*;
			for( z in bean )
			{
				value = bean[ z ];

				if( value is String )
				{
					//
					//value = parseElement( String( value ), beanName, z );
					
					value = parser.parse( String( value ), beanName, z );
				}
				
				parser.setBeanProperty( bean, z, value );
			}
		}
		
		/*
		private function setBeanProperty( bean:Object, name:String, value:Object ):void
		{
			trace("************************* TextBeanDocument::setBeanProperty()", name, value);
			bean[ name ] = value;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		public function parseElement(
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
				output = parser.parse( String( output ), true, delimiter );
				
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
		*/
		
		/**
		* 	@private
		*/
		
		/*
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
		*/
		
		/**
		*	@private	
		*/
		/*
		private function parseHexNumber( candidate:String ):Number
		{
			candidate = candidate.replace( /^#/, "0x" );
			var parsed:Number = Number( candidate );
			return parsed;
		}
		*/
		
		/**
		*	Determines whether an extension is valid.
		*	
		*	@param candidate The string candidate.
		*	
		*	@return Whether the extension candidate represents a
		*	valid extension.
		*/
		
		/*
		private function isValidExtension( candidate:String ):Boolean
		{
			for( var z:String in expressions )
			{
				if( candidate.indexOf( z ) == 0 )
				{
					return true;
				}
			}
			return false;
		}
		*/
		
		/**
		*	@private
		*/
		
		/*
		private function parseExtension(
			candidate:String,
			beanName:String,
			beanProperty:String = null ):Object
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
				case BeanConstants.CLASS:
					try
					{
						output = Class( getDefinitionByName( value ) );
					}catch( e:Error )
					{
						throw new Error( "Could not locate bean css class reference with class path '"
							+ value + "'." );
					}
					break;
				case BeanConstants.URL:
					output = new URLRequest( value );
					break;			
				case BeanConstants.BITMAP:
					output = new ImageLoader( new URLRequest( value ) );
					break;
				case BeanConstants.SOUND:
					output = new SoundLoader( new URLRequest( value ) );
					break;
				case BeanConstants.SWF:
					output = new MovieLoader( new URLRequest( value ) );
					break;
				case BeanConstants.REF:
					output = new BeanReference( beanName, beanProperty, value );
					break;
				case BeanConstants.CONSTANT:
					output = new BeanConstant( beanName, beanProperty, value );
					break;
				case BeanConstants.METHOD:
					output = new BeanMethod( beanName, beanProperty, value );
					break;
				case BeanConstants.ARRAY:
					output = new BeanArray( beanName, beanProperty, value );
					break;
				default:
					throw new Error(
						"Could not handle css expression with identifier '" + extension + "'." );
			}
			
			if( _dependencies && ( output is ILoader ) && beanProperty )
			{
				_dependencies.addLoader( ILoader( output ) );
				_cache[ output ] = { beanName: beanName, beanProperty: beanProperty };
			}
			
			return output;
		}
		*/
		
		/**
		* 	@private
		*/
		
		/*
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
		*/	
	}
}