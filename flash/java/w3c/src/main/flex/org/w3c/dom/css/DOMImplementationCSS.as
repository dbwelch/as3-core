package org.w3c.dom.css
{
	/**
	* 	This interface allows the DOM user to create a CSSStyleSheet
	* 	outside the context of a document.
	* 
	* 	There is no way to associate the new CSSStyleSheet with a
	* 	document in DOM Level 2.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface DOMImplementationCSS
	{	
		/**
		* 	Creates a CSS style sheet.
		* 	
		* 	@param title The advisory title. See also the
		* 	Style Sheet Interfaces section.
		* 	@param media The comma-separated list of media
		* 	associated with the new style sheet. See also the
		* 	Style Sheet Interfaces section.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the specified media
		* 	string value has a syntax error and is unparsable.
		* 
		* 	@return A new CSS style sheet.
		*/
		function createCSSStyleSheet(
			title:String, media:String ):CSSStyleSheet;
	}
}