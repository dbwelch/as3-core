package org.w3c.dom.css
{

	public interface CSSCharsetRule extends CSSRule
	{
		/*
		
		Interface CSSCharsetRule (introduced in DOM Level 2)
		The CSSCharsetRule interface represents a @charset rule in a CSS style sheet. The value of the encoding attribute does not affect the encoding of text data in the DOM objects; this encoding is always UTF-16. After a stylesheet is loaded, the value of the encoding attribute is the value found in the @charset rule. If there was no @charset in the original document, then no CSSCharsetRule is created. The value of the encoding attribute may also be used as a hint for the encoding used on serialization of the style sheet.

		The value of the @charset rule (and therefore of the CSSCharsetRule) may not correspond to the encoding the document actually came in; character encoding information e.g. in an HTTP header, has priority (see CSS document representation) but this is not reflected in the CSSCharsetRule.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSCharsetRule : CSSRule {
		           attribute DOMString        encoding;
		                                        // raises(DOMException) on setting

		};

		Attributes
		encoding of type DOMString
		The encoding information used in this @charset rule.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the specified encoding value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this encoding rule is readonly.		
		
		*/
	}
}