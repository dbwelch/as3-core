package org.flashx.swat.as3.view {
	
	import org.flashx.ioc.support.xml.IBeanXmlParser;
	import org.flashx.swat.core.DefaultController;
	import org.flashx.ui.runtime.RuntimeParser;
	
	/**
	*	Abstract controller for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.12.2010
	*/
	public class AbstractApplicationController extends DefaultController {
		
		private var _parser:IBeanXmlParser;
		
		/**
		*	Creates a <code>AbstractApplicationController</code> instance.
		*/
		public function AbstractApplicationController()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getViewParser():IBeanXmlParser
		{
			if( _parser == null )
			{
				_parser = new RuntimeParser();
			}
			
			return _parser;
		}
	}
}