package org.w3c.dom.css
{
	/**
	* 	The Rect interface is used to represent any rect value.
	* 	
	* 	This interface reflects the values in the underlying
	* 	style property. Hence, modifications made to the CSSPrimitiveValue
	* 	objects modify the style property.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface Rect
	{
		/**
		* 	The top of the rectangle.
		* 
		* 	This attribute is used for the top of the rect.
		*/
		function get top():CSSPrimitiveValue;
		
		/**
		* 	The right of the rectangle.
		* 
		* 	This attribute is used for the right of the rect.
		*/
		function get right():CSSPrimitiveValue;
		
		/**
		* 	The bottom of the rectangle.
		* 
		* 	This attribute is used for the bottom of the rect.
		*/
		function get bottom():CSSPrimitiveValue;
		
		/**
		* 	The left of the rectangle.
		* 
		* 	This attribute is used for the left of the rect.
		*/
		function get left():CSSPrimitiveValue;
	}
}