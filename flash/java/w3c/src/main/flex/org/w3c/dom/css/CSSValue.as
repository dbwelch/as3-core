package org.w3c.dom.css
{
	/**
	* 	The CSSValue interface represents a simple or a complex value.
	* 
	* 	A CSSValue object only occurs in a context of a CSS property.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSValue
	{
		/**
		* 	A string representation of the current value.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the specified CSS
		* 	string value has a syntax error (according to the attached
		* 	property) or is unparsable.
		*	@throws DOMException.INVALID_MODIFICATION_ERR: Raised if the
		* 	specified CSS string value represents a different type of
		* 	values than the values allowed by the CSS property.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if
		* 	this value is readonly.
		*/
		function get cssText():String;
		function set cssText( text:String ):void;
		
		/**
		* 	A code defining the type of the value.
		*/
		function get cssValueType():uint;
	}
}