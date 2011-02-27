package org.w3c.dom.css
{
	import org.w3c.dom.Element;
	import org.w3c.dom.views.AbstractView;
	
	/**
	* 	This interface represents a CSS view.
	* 
	* 	The getComputedStyle method provides a read only
	* 	access to the computed values of an element.
	* 
	* 	The expectation is that an instance of the
	* 	ViewCSS interface can be obtained by using
	* 	binding-specific casting methods on an instance
	* 	of the AbstractView interface.
	* 
	* 	Since a computed style is related to an Element node,
	* 	if this element is removed from the document, the
	* 	associated CSSStyleDeclaration and CSSValue related to
	* 	this declaration are no longer valid.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface ViewCSS extends AbstractView
	{	
		/**
		* 	Retrieves the computed style for an element.
		* 	
		*	@param element The element whose style is to be computed.
		* 	This parameter cannot be null.
		* 	@param pseudo The pseudo-element or null if none.
		* 	
		* 	@return The computed style. The CSSStyleDeclaration is
		* 	read-only and contains only absolute values.
		*/
		function getComputedStyle( element:Element, pseudo:String ):CSSStyleDeclaration;
	}
}