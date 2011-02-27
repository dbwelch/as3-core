package org.w3c.dom.css
{
	/**
	* 	The CSSFontFaceRule interface represents a &#64;font-face rule
	* 	in a CSS style sheet.
	* 
	* 	The &#64;font-face rule is used to hold a set of font descriptions.	
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSFontFaceRule extends CSSRule
	{
		/**
		* 	The declaration-block of this rule.
		*/
		function get style():CSSStyleDeclaration;
	}
}