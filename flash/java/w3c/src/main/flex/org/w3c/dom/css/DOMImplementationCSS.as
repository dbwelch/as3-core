package org.w3c.dom.css
{

	public interface DOMImplementationCSS
	{
		/*
		
		Interface DOMImplementationCSS (introduced in DOM Level 2)
		This interface allows the DOM user to create a CSSStyleSheet outside the context of a document. There is no way to associate the new CSSStyleSheet with a document in DOM Level 2.


		IDL Definition
		// Introduced in DOM   Level 2:
		interface DOMImplementationCSS : DOMImplementation {
		  CSSStyleSheet      createCSSStyleSheet(in DOMString title, 
		                                         in DOMString media)
		                                        raises(DOMException);
		};

		Methods
		createCSSStyleSheet
		Creates a new CSSStyleSheet.
		Parameters
		title of type DOMString
		The advisory title. See also the Style Sheet Interfaces section.
		media of type DOMString
		The comma-separated list of media associated with the new style sheet. See also the Style Sheet Interfaces section.
		Return Value
		CSSStyleSheet

		A new CSS style sheet.

		Exceptions
		DOMException

		SYNTAX_ERR: Raised if the specified media string value has a syntax error and is unparsable.

		
		
		*/
	}
}