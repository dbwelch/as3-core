package org.w3c.dom.css
{
	/**
	* 	The CSSStyleRule interface represents
	* 	a single rule set in a CSS style sheet.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSStyleRule extends CSSRule
	{
		/**
		* 	The declaration-block of this rule set.
		*/
		function get style():CSSStyleDeclaration;
		
		/**
		* 	The textual representation of the selector
		* 	for the rule set. The implementation may have
		* 	stripped out insignificant whitespace while parsing the selector.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the specified
		* 	CSS string value has a syntax error and is unparsable.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if
		* 	this rule is readonly.
		*/
		function get selectorText():String;
		function set selectorText( text:String ):void;
	}
}