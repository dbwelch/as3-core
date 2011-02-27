package org.w3c.dom.css
{

	public interface CSSImportRule extends CSSRule
	{
		/*
		
		Interface CSSImportRule (introduced in DOM Level 2)
		The CSSImportRule interface represents a @import rule within a CSS style sheet. The @import rule is used to import style rules from other style sheets.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSImportRule : CSSRule {
		  readonly attribute DOMString        href;
		  readonly attribute stylesheets::MediaList  media;
		  readonly attribute CSSStyleSheet    styleSheet;
		};

		Attributes
		href of type DOMString, readonly
		The location of the style sheet to be imported. The attribute will not contain the "url(...)" specifier around the URI.
		media of type stylesheets::MediaList, readonly
		A list of media types for which this style sheet may be used.
		styleSheet of type CSSStyleSheet, readonly
		The style sheet referred to by this rule, if it has been loaded. The value of this attribute is null if the style sheet has not yet been loaded or if it will not be loaded (e.g. if the style sheet is for a media type not supported by the user agent).		
		
		*/
	}
}