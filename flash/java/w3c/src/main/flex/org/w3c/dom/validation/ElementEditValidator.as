package org.w3c.dom.validation
{
	
	/**
	* 
	*/
	public interface ElementEditValidator extends NodeEditValidator
	{
		
		/*
		
		ElementEditVAL.VAL_EMPTY_CONTENTTYPE
		The value of the constant ElementEditVAL.VAL_EMPTY_CONTENTTYPE is 1.
		ElementEditVAL.VAL_ANY_CONTENTTYPE
		The value of the constant ElementEditVAL.VAL_ANY_CONTENTTYPE is 2.
		ElementEditVAL.VAL_MIXED_CONTENTTYPE
		The value of the constant ElementEditVAL.VAL_MIXED_CONTENTTYPE is 3.
		ElementEditVAL.VAL_ELEMENTS_CONTENTTYPE
		The value of the constant ElementEditVAL.VAL_ELEMENTS_CONTENTTYPE is 4.
		ElementEditVAL.VAL_SIMPLE_CONTENTTYPE
		The value of the constant ElementEditVAL.VAL_SIMPLE_CONTENTTYPE is 5.		
		
		*/
		
		/*
		
		Objects that implement the ElementEditVAL interface:
		Objects that implement the ElementEditVAL interface have all properties and functions of the NodeEditVAL interface as well as the properties and functions defined below.
		
		Properties of objects that implement the ElementEditVAL interface:
		
		allowedChildren
		This read-only property is an object that implements the NameList interface.
		allowedFirstChildren
		This read-only property is an object that implements the NameList interface.
		allowedParents
		This read-only property is an object that implements the NameList interface.
		allowedNextSiblings
		This read-only property is an object that implements the NameList interface.
		allowedPreviousSiblings
		This read-only property is an object that implements the NameList interface.
		allowedAttributes
		This read-only property is an object that implements the NameList interface.
		requiredAttributes
		This read-only property is an object that implements the NameList interface.
		contentType
		This read-only property is a Number.
		
		
		
		
		Functions of objects that implement the ElementEditVAL interface:
		
		canSetTextContent(possibleTextContent)
		This function returns a Number.
		The possibleTextContent parameter is a String.
		canSetAttribute(attrname, attrval)
		This function returns a Number.
		The attrname parameter is a String. 
		The attrval parameter is a String.
		canSetAttributeNode(attrNode)
		This function returns a Number.
		The attrNode parameter is an object that implements the Attr interface.
		canSetAttributeNS(namespaceURI, qualifiedName, value)
		This function returns a Number.
		The namespaceURI parameter is a String. 
		The qualifiedName parameter is a String. 
		The value parameter is a String.
		canRemoveAttribute(attrname)
		This function returns a Number.
		The attrname parameter is a String.
		canRemoveAttributeNS(namespaceURI, localName)
		This function returns a Number.
		The namespaceURI parameter is a String. 
		The localName parameter is a String.
		canRemoveAttributeNode(attrNode)
		This function returns a Number.
		The attrNode parameter is an object that implements the Node interface.
		isElementDefined(name)
		This function returns a Number.
		The name parameter is a String.
		isElementDefinedNS(namespaceURI, name)
		This function returns a Number.
		The namespaceURI parameter is a String. 
		The name parameter is a String.
		
		*/
	}

}

