package org.w3c.dom.css
{
	/**
	* 	The LinkStyle interface provides a mechanism by
	* 	which a style sheet can be retrieved from the
	* 	node responsible for linking it into a document.
	* 
	* 	An instance of the LinkStyle interface can be
	* 	obtained using binding-specific casting methods
	* 	on an instance of a linking node (HTMLLinkElement,
	* 	HTMLStyleElement or ProcessingInstruction in DOM Level 2).
	* 
	* 	@see http://www.w3.org/TR/DOM-Level-2-Style/stylesheets.html
	*/
	public interface LinkStyle
	{
		/**
		* 	The style sheet.
		*/
		function get sheet():StyleSheet;
	}
}