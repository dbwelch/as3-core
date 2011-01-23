package com.ffsys.ioc
{	
	import flash.text.StyleSheet;
	
	/**
	*	Responsible for parsing text that declares beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanTextParser extends BeanParser
	{
		private var _beanSheet:StyleSheet;
		
		/**
		* 	Creates a <code>BeanTextParser</code> instance.
		* 
		* 	@param document A bean document to parse into.
		*/
		public function BeanTextParser( document:IBeanDocument = null )
		{
			super( document );
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
				
				//TODO: refactor to a custom parser so that order can be maintained
				_beanSheet = new StyleSheet();
				_beanSheet.parseCSS( text );
				
				var parser:IBeanPropertyParser =
					IBeanPropertyParser(
						this.document.getBean( BeanNames.BEAN_ELEMENT_PARSER ) );
						
				var bean:Object = null;
				var names:Array = _beanSheet.styleNames;
				names.sort();
				var name:String = null;
				var descriptor:IBeanDescriptor = null;
				for( var i:int = 0;i < names.length;i++ )
				{
					name = names[ i ];
					bean = _beanSheet.getStyle( name );
					//transfer the anonymous object to a bean descriptor
					descriptor = new BeanDescriptor();
					
					//parse bean expressions and primitives
					bean = processBean( parser, descriptor, name, bean );
					
					//always assign the style name as the bean identifier
					descriptor.id = name;
					
					//transfer the anonymous object properties
					//to create the bean descriptor
					descriptor.transfer( bean );
					
					//add the bean to the document
					this.document.addBeanDescriptor( descriptor );
				}
				return this.document;
			}
			return null;
		}
		
		/**
		* 	@private
		*/
		private function processBean(
			parser:IBeanPropertyParser,
			descriptor:IBeanDescriptor,
			beanName:String,
			bean:Object ):Object
		{
			if( parser == null )
			{
				throw new Error( "Cannot process a bean with a null element parser." );
			}
			
			var z:String = null;
			var value:*;
			var output:Object = new Object();
			var result:Object = null;
			for( z in bean )
			{
				value = bean[ z ];
				if( value is String )
				{
					value = parser.parse( descriptor, beanName, z, String( value ) );
				}
				
				result = parser.doWithProperty( descriptor, z, value );
				
				//parser.setBeanProperty( bean, z, value );
				
				output[ result.name ] = result.value;
			}
			return output;
		}
	}
}