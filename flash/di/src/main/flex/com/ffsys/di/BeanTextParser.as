package com.ffsys.di
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
			
				_beanSheet = new StyleSheet();
				_beanSheet.parseCSS( text );
			
				var bean:Object = null;
				var names:Array = _beanSheet.styleNames;
				var name:String = null;
				var descriptor:IBeanDescriptor = null;
				for( var i:int = 0;i < names.length;i++ )
				{
					name = names[ i ];
					bean = _beanSheet.getStyle( name );
					processBean( name, bean );
					//transfer the anonymous object to a bean descriptor
					descriptor = new BeanDescriptor( bean );
					//always assign the style name as the bean identifier
					descriptor.id = name;	
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
			var parser:BeanTextElementParser = new BeanTextElementParser( this.document );
			var z:String = null;
			var value:*;
			for( z in bean )
			{
				value = bean[ z ];
				if( value is String )
				{
					value = parser.parse( String( value ), beanName, z );
				}
				parser.setBeanProperty( bean, z, value );
			}
		}	
	}
}