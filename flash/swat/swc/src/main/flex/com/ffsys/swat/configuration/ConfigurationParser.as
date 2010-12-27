package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.DeserializationMode;

	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.BeanXmlParser;

	/**
	*	A parser implementation for the application configuration.
	*  
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ConfigurationParser extends BeanXmlParser
		implements IConfigurationParser {		

		/**
		*	Creates a <code>ConfigurationParser</code> instance.
		*	
		*	@param document The bean document.
		*/
		public function ConfigurationParser( document:IBeanDocument = null )
		{
			super( document );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			this.deserializer.mode =
				DeserializationMode.POST_PROPERTY_SET;
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:IConfiguration = null ):IConfiguration
		{
			return deserialize( x, target ) as IConfiguration;
		}
	}
}