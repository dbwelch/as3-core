package com.ffsys.ui.runtime {
	
	import com.ffsys.io.xml.DeserializationMode;
	
	import com.ffsys.ioc.IBeanDocument;	
	import com.ffsys.ioc.support.xml.BeanXmlParser;
	
	/**
	*	Responsible for parsing the runtime view definition document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeParser extends BeanXmlParser {
		
		/**
		*	Creates a <code>RuntimeParser</code> instance.
		* 
		* 	@param document The components bean document.
		*/
		public function RuntimeParser( document:IBeanDocument = null )
		{
			trace("RuntimeParser::init()", document );
			super( document );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			trace("RuntimeParser::initialize()", this.document );
			this.interpreter = new RuntimeInterpreter( this.document );
		}
	}
}