package org.w3c.dom.css
{

	public interface CSSStyleDeclaration
	{
		/*
		
		Interface CSSStyleDeclaration (introduced in DOM Level 2)
		The CSSStyleDeclaration interface represents a single CSS declaration block. This interface may be used to determine the style properties currently set in a block or to set style properties explicitly within the block.

		While an implementation may not recognize all CSS properties within a CSS declaration block, it is expected to provide access to all specified properties in the style sheet through the CSSStyleDeclaration interface. Furthermore, implementations that support a specific level of CSS should correctly handle CSS shorthand properties for that level. For a further discussion of shorthand properties, see the CSS2Properties interface.

		This interface is also used to provide a read-only access to the computed values of an element. See also the ViewCSS interface.

		Note: The CSS Object Model doesn't provide an access to the specified or actual values of the CSS cascade.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSStyleDeclaration {
		           attribute DOMString        cssText;
		                                        // raises(DOMException) on setting

		  DOMString          getPropertyValue(in DOMString propertyName);
		  CSSValue           getPropertyCSSValue(in DOMString propertyName);
		  DOMString          removeProperty(in DOMString propertyName)
		                                        raises(DOMException);
		  DOMString          getPropertyPriority(in DOMString propertyName);
		  void               setProperty(in DOMString propertyName, 
		                                 in DOMString value, 
		                                 in DOMString priority)
		                                        raises(DOMException);
		  readonly attribute unsigned long    length;
		  DOMString          item(in unsigned long index);
		  readonly attribute CSSRule          parentRule;
		};

		Attributes
		cssText of type DOMString
		The parsable textual representation of the declaration block (excluding the surrounding curly braces). Setting this attribute will result in the parsing of the new value and resetting of all the properties in the declaration block including the removal or addition of properties.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the specified CSS string value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this declaration is readonly or a property is readonly.

		length of type unsigned long, readonly
		The number of properties that have been explicitly set in this declaration block. The range of valid indices is 0 to length-1 inclusive.
		parentRule of type CSSRule, readonly
		The CSS rule that contains this declaration block or null if this CSSStyleDeclaration is not attached to a CSSRule.
		Methods
		getPropertyCSSValue
		Used to retrieve the object representation of the value of a CSS property if it has been explicitly set within this declaration block. This method returns null if the property is a shorthand property. Shorthand property values can only be accessed and modified as strings, using the getPropertyValue and setProperty methods.
		Parameters
		propertyName of type DOMString
		The name of the CSS property. See the CSS property index.
		Return Value
		CSSValue

		Returns the value of the property if it has been explicitly set for this declaration block. Returns null if the property has not been set.

		No Exceptions
		getPropertyPriority
		Used to retrieve the priority of a CSS property (e.g. the "important" qualifier) if the property has been explicitly set in this declaration block.
		Parameters
		propertyName of type DOMString
		The name of the CSS property. See the CSS property index.
		Return Value
		DOMString

		A string representing the priority (e.g. "important") if one exists. The empty string if none exists.

		No Exceptions
		getPropertyValue
		Used to retrieve the value of a CSS property if it has been explicitly set within this declaration block.
		Parameters
		propertyName of type DOMString
		The name of the CSS property. See the CSS property index.
		Return Value
		DOMString

		Returns the value of the property if it has been explicitly set for this declaration block. Returns the empty string if the property has not been set.

		No Exceptions
		item
		Used to retrieve the properties that have been explicitly set in this declaration block. The order of the properties retrieved using this method does not have to be the order in which they were set. This method can be used to iterate over all properties in this declaration block.
		Parameters
		index of type unsigned long
		Index of the property name to retrieve.
		Return Value
		DOMString

		The name of the property at this ordinal position. The empty string if no property exists at this position.

		No Exceptions
		removeProperty
		Used to remove a CSS property if it has been explicitly set within this declaration block.
		Parameters
		propertyName of type DOMString
		The name of the CSS property. See the CSS property index.
		Return Value
		DOMString

		Returns the value of the property if it has been explicitly set for this declaration block. Returns the empty string if the property has not been set or the property name does not correspond to a known CSS property.

		Exceptions
		DOMException

		NO_MODIFICATION_ALLOWED_ERR: Raised if this declaration is readonly or the property is readonly.

		setProperty
		Used to set a property value and priority within this declaration block.
		Parameters
		propertyName of type DOMString
		The name of the CSS property. See the CSS property index.
		value of type DOMString
		The new value of the property.
		priority of type DOMString
		The new priority of the property (e.g. "important").
		Exceptions
		DOMException

		SYNTAX_ERR: Raised if the specified value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this declaration is readonly or the property is readonly.

		No Return Value
		
		*/
	}
}