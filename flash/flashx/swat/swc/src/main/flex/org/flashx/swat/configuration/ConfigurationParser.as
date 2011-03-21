package org.flashx.swat.configuration {
	
	import org.flashx.io.xml.DeserializationMode;

	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.support.xml.BeanXmlParser;

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
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			this.interpreter = new ConfigurationInterpreter( this.document );
		}
		
		override public function deserialize( x:XML, target:Object = null ):Object
		{

			
			trace("ConfigurationParser::deserialize() GOT XML: ", target, x.toXMLString() );	
			
			if( x && x.name().localName != "configuration" )
			{	
				var nested:XMLList = x..configuration;
				for each( var node:XML in nested )
				{
					x = node;
					break;
				}
					
				trace("ConfigurationParser::deserialize() RETRIEVED NESTED XML: ", x );
				
						
			}
			
			
			trace("ConfigurationParser::deserialize() AFTER: ", target, x.toXMLString() );
			
			return super.deserialize( x, target );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:IConfiguration = null ):IConfiguration
		{
			x = XML( x..configuration[ 0 ] );
			
			trace("ConfigurationParser::parse()", target, x.toXMLString() );
			
			return deserialize( x, target ) as IConfiguration;
		}
	}
}