package org.flashx.ui.suite.core
{
	import org.flashx.ioc.support.xml.IBeanXmlParser;
	import org.flashx.swat.core.DefaultController;	
	import org.flashx.ui.runtime.*;
	
	import org.flashx.io.xml.IParser;

	public class AbstractApplicationController extends DefaultController
	{
		/**
		* 	Creates an <code>AbstractApplicationController</code> instance.
		*/
		public function AbstractApplicationController()
		{
			super();
		}
		
		/**
		* 	The parser to use for view components.
		*/
		override protected function getViewParser():IBeanXmlParser
		{
			var parser:IRuntimeParser = new RuntimeParser();
			
			//TODO: re-implement
			//ensure the document can parse embedded css correctly
			//parser.runtime.stylesheet = this.stylesheet;
			return parser;
		}
	}
}