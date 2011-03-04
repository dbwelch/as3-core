package com.ffsys.ui.suite.core
{
	import com.ffsys.ioc.support.xml.IBeanXmlParser;
	import com.ffsys.swat.core.DefaultController;	
	import com.ffsys.ui.runtime.*;
	
	import com.ffsys.io.xml.IParser;

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