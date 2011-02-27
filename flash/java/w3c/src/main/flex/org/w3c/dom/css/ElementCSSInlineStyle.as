package org.w3c.dom.css
{

	public interface ElementCSSInlineStyle
	{
		/*
		
		Interface ElementCSSInlineStyle (introduced in DOM Level 2)
		Inline style information attached to elements is exposed through the style attribute. This represents the contents of the STYLE attribute for HTML elements (or elements in other schemas or DTDs which use the STYLE attribute in the same way). The expectation is that an instance of the ElementCSSInlineStyle interface can be obtained by using binding-specific casting methods on an instance of the Element interface when the element supports inline CSS style informations.


		IDL Definition
		// Introduced in DOM Level 2:
		interface ElementCSSInlineStyle {
		  readonly attribute CSSStyleDeclaration  style;
		};

		Attributes
		style of type CSSStyleDeclaration, readonly
		The style attribute.		
		
		*/
	}
}