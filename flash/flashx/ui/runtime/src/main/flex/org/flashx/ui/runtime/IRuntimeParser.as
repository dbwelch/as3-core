package org.flashx.ui.runtime
{
	import org.flashx.ioc.support.xml.IBeanXmlParser;
	
	import org.flashx.ui.dom.*;	
	
	/**
	*	Describes the contract for parser implementations that
	* 	parse a runtime view xml document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.10.2010
	*/
	public interface IRuntimeParser extends IBeanXmlParser
	{
		/**
		*	The runtime document to parse the view data into.
		*/
		function get runtime():IDomDocument;
		function set runtime( value:IDomDocument ):void;
		
		/**
		* 	Adds the specified bindings to the runtime document.
		* 
		* 	@param document The runtime document to add the bindings to.
		* 	@param bindings The bindings to expose when parsing the document.
		*/
		
		/*
		function addDocumentBindings(
			document:IDocument, ...bindings ):void;
		*/
	}
}