package org.w3c.dom.css
{

	public interface CSSPageRule extends CSSRule
	{
		/*
		
		Interface CSSPageRule (introduced in DOM Level 2)
		The CSSPageRule interface represents a @page rule within a CSS style sheet. The @page rule is used to specify the dimensions, orientation, margins, etc. of a page box for paged media.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSPageRule : CSSRule {
		           attribute DOMString        selectorText;
		                                        // raises(DOMException) on setting

		  readonly attribute CSSStyleDeclaration  style;
		};

		Attributes
		selectorText of type DOMString
		The parsable textual representation of the page selector for the rule.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the specified CSS string value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this rule is readonly.

		style of type CSSStyleDeclaration, readonly
		The declaration-block of this rule.
		
		*/
	}
}