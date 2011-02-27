package org.w3c.dom.css
{
	/**
	* 	The CSSPageRule interface represents a &#64;page rule
	* 	within a CSS style sheet.
	* 
	* 	The &#64;page rule is used to specify the dimensions,
	* 	orientation, margins, etc. of a page box for paged media.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSPageRule extends CSSRule
	{
		/**
		* 	The declaration-block of this rule.
		*/
		function get style():CSSStyleDeclaration;
		
		/**
		* 	The parsable textual representation of the page
		* 	selector for the rule.
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