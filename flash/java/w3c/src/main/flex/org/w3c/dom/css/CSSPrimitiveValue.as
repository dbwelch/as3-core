package org.w3c.dom.css
{
	/**
	* 	The CSSPrimitiveValue interface represents a single CSS value.
	* 
	* 	This interface may be used to determine the value of a specific
	* 	style property currently set in a block or to set a specific style
	* 	property explicitly within the block. An instance of this
	* 	interface might be obtained from the getPropertyCSSValue method
	* 	of the CSSStyleDeclaration interface. A CSSPrimitiveValue object
	* 	only occurs in a context of a CSS property.
	* 
	* 	Conversions are allowed between absolute values (from millimeters
	* 	to centimeters, from degrees to radians, and so on) but not between
	* 	relative values. (For example, a pixel value cannot be converted
	* 	to a centimeter value.) Percentage values can't be converted since
	* 	they are relative to the parent value (or another property value).
	* 
	* 	There is one exception for color percentage values: since a color
	* 	percentage value is relative to the range 0-255, a color percentage
	* 	value can be converted to a number; (see also the RGBColor interface).
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSPrimitiveValue extends CSSValue
	{
		/**
		*	The type of the value as defined by the constants
		* 	in UnitType.
		*/
		function get primitiveType():uint;
		
		/**
		* 	This method is used to get a float value in a specified unit.
		* 
		* 	If this CSS value doesn't contain a float value or can't be
		* 	converted into the specified unit, a DOMException is raised.
		* 
		* 	@param unitType A unit code to get the float value.
		* 	The unit code can only be a float unit type (i.e. CSS_NUMBER,
		* 	CSS_PERCENTAGE, CSS_EMS, CSS_EXS, CSS_PX, CSS_CM, CSS_MM,
		* 	CSS_IN, CSS_PT, CSS_PC, CSS_DEG, CSS_RAD, CSS_GRAD, CSS_MS,
		* 	CSS_S, CSS_HZ, CSS_KHZ, CSS_DIMENSION).
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the CSS value
		* 	doesn't contain a float value or if the float value can't be
		* 	converted into the specified unit.
		* 
		* 	@return The float value in the specified unit.
		*/
		function getFloatValue( unitType:uint ):Number;
		
		/**
		* 	A method to set the float value with a specified unit.
		* 
		* 	If the property attached with this value can not accept
		* 	the specified unit or the float value, the value will be
		* 	unchanged and a DOMException will be raised.
		* 
		* 	@param unitType A unit code. The unit code can only be a
		* 	float unit type (i.e. CSS_NUMBER, CSS_PERCENTAGE, CSS_EMS,
		* 	CSS_EXS, CSS_PX, CSS_CM, CSS_MM, CSS_IN, CSS_PT, CSS_PC,
		* 	CSS_DEG, CSS_RAD, CSS_GRAD, CSS_MS, CSS_S, CSS_HZ, CSS_KHZ,
		* 	CSS_DIMENSION).
		* 	@param floatValue The new float value.
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the attached property
		* 	doesn't support the float value or the unit type.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if
		* 	this property is readonly.
		*/
		function setFloatValue( unitType:uint, floatValue:Number ):void;
		
		/**
		* 	This method is used to get the string value.
		* 
		* 	If the CSS value doesn't contain a string value, a DOMException is raised.
		* 
		* 	Note: Some properties (like 'font-family' or 'voice-family')
		* 	convert a whitespace separated list of idents to a string.
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the CSS value
		* 	doesn't contain a string value.
		* 
		* 	@return The string value in the current unit.
		* 	The current primitiveType can only be a string unit type
		* 	(i.e. CSS_STRING, CSS_URI, CSS_IDENT and CSS_ATTR). 
		*/
		function getStringValue():String;
		
		/**
		* 	A method to set the string value with the specified unit.
		* 
		* 	If the property attached to this value can't accept the
		* 	specified unit or the string value, the value will be
		* 	unchanged and a DOMException will be raised.
		* 
		* 	@param stringType A string type code.
		* 	The string code can only be a string unit type (i.e.
		* 	CSS_STRING, CSS_URI, CSS_IDENT, and CSS_ATTR).
		* 	@param stringValue The new string value.
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the CSS value doesn't
		* 	contain a string value or if the string value can't be
		* 	converted into the specified unit.
		* 	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if this 
		* 	property is readonly.
		*/
		function setStringValue( stringType:uint, stringValue:String ):void;
		
		/**
		* 	This method is used to get the Counter value.
		* 
		* 	If this CSS value doesn't contain a counter value,
		* 	a DOMException is raised. Modification to the corresponding
		* 	style property can be achieved using the Counter interface.
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the CSS
		* 	value doesn't contain a Counter value (e.g. this is not CSS_COUNTER).
		* 
		* 	@return The Counter value.
		*/
		function getCounterValue():Counter;
		
		/**
		* 	This method is used to get the Rect value. If this CSS value
		* 	doesn't contain a rect value, a DOMException is raised. Modification
		* 	to the corresponding style property can be achieved using the Rect interface.
		* 
		* 	@throws INVALID_ACCESS_ERR: Raised if the CSS value doesn't
		* 	contain a Rect value. (e.g. this is not CSS_RECT).
		* 
		* 	@return The Rect value.
		*/
		function getRectValue():Rect;
		
		/**
		* 	This method is used to get the RGB color.
		* 
		* 	If this CSS value doesn't contain a RGB color value,
		* 	a DOMException is raised. Modification to the corresponding
		* 	style property can be achieved using the RGBColor interface.
		* 
		* 	@throws DOMException.INVALID_ACCESS_ERR: Raised if the attached
		* 	property can't return a RGB color value (e.g. this is not CSS_RGBCOLOR).
		* 
		* 	@return The RGB color value.
		*/
		function getRGBColorValue():RGBColor;
	}
}