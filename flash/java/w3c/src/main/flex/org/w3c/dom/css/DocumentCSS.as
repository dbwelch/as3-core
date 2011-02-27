package org.w3c.dom.css
{
	
	/**
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface DocumentCSS extends DocumentStyle
	{
		/*
		
		Interface DocumentCSS (introduced in DOM Level 2)
		This interface represents a document with a CSS view.

		The getOverrideStyle method provides a mechanism through which a DOM author could effect immediate change to the style of an element without modifying the explicitly linked style sheets of a document or the inline style of elements in the style sheets. This style sheet comes after the author style sheet in the cascade algorithm and is called override style sheet. The override style sheet takes precedence over author style sheets. An "!important" declaration still takes precedence over a normal declaration. Override, author, and user style sheets all may contain "!important" declarations. User "!important" rules take precedence over both override and author "!important" rules, and override "!important" rules take precedence over author "!important" rules.

		The expectation is that an instance of the DocumentCSS interface can be obtained by using binding-specific casting methods on an instance of the Document interface.


		IDL Definition
		// Introduced in DOM Level 2:
		interface DocumentCSS : stylesheets::DocumentStyle {
		  CSSStyleDeclaration getOverrideStyle(in Element elt, 
		                                       in DOMString pseudoElt);
		};

		Methods
		getOverrideStyle
		This method is used to retrieve the override style declaration for a specified element and a specified pseudo-element.
		Parameters
		elt of type Element
		The element whose style is to be modified. This parameter cannot be null.
		pseudoElt of type DOMString
		The pseudo-element or null if none.
		Return Value
		CSSStyleDeclaration

		The override style declaration.

		No Exceptions
		
		*/
	}

}

