package org.w3c.dom.css
{

	public interface CSSStyleRule
	{
		
		/*
		
		Interface CSSStyleRule (introduced in DOM Level 2)
		The CSSStyleRule interface represents a single rule set in a CSS style sheet.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSStyleRule : CSSRule {
		           attribute DOMString        selectorText;
		                                        // raises(DOMException) on setting

		  readonly attribute CSSStyleDeclaration  style;
		};

		Attributes
		selectorText of type DOMString
		The textual representation of the selector for the rule set. The implementation may have stripped out insignificant whitespace while parsing the selector.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the specified CSS string value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this rule is readonly.

		style of type CSSStyleDeclaration, readonly
		The declaration-block of this rule set.
		
		*/
	}
}