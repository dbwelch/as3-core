package org.w3c.dom.css
{
	
	/**
	* 	The RGBColor interface is used to represent any RGB color value.
	* 
	* 	This interface reflects the values in the underlying style property.
	* 	Hence, modifications made to the CSSPrimitiveValue objects modify
	* 	the style property.
	* 
	* 	A specified RGB color is not clipped (even if the number is
	* 	outside the range 0-255 or 0%-100%). A computed RGB color is
	* 	clipped depending on the device.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface RGBColor
	{
		/**
		* 	The red channel for the colour.
		* 
		* 	This attribute is used for the red value of the RGB color.
		*/
		function get red():CSSPrimitiveValue;
		
		/**
		* 	The green channel for the colour.
		* 
		* 	This attribute is used for the green value of the RGB color.
		*/
		function get green():CSSPrimitiveValue;
		
		/**
		* 	The blue channel for the colour.
		* 
		* 	This attribute is used for the blue value of the RGB color.
		*/
		function get blue():CSSPrimitiveValue;
	}
}