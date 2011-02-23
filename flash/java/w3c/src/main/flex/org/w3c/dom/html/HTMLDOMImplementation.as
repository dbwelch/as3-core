package org.w3c.dom.html
{
	import org.w3c.dom.DOMImplementation;
	
	
	/**
	* 
	*/
	public interface HTMLDOMImplementation extends DOMImplementation
	{
		
		/**
		*  	Creates an <code>HTMLDocument</code> object with the minimal tree made 
		* 	of the following elements: <code>html</code>, <code>head</code>, 
		*	<code>title</code>, and <code>body</code> .
		* 
		* 	@param title  The title of the document to be set as the content of the 
		*   <code>title</code> element, through a child <code>Text</code> node.
		* 
		* 	@return  A new <code>HTMLDocument</code> object.
		*/
	    function createHTMLDocument( title:String ):HTMLDocument;
	}
}