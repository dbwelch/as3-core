package org.w3c.dom.validation
{
	
	/**
	* 
	*/
	public interface DocumentEditValidator extends NodeEditValidator
	{
		
		/*
		
		Objects that implement the DocumentEditVAL interface have all properties and functions of the NodeEditVAL interface as well as the properties and functions defined below.
		Properties of objects that implement the DocumentEditVAL interface:
		
		continuousValidityChecking
		This property is a Boolean and can raise an object that implements the DOMException interface or the ExceptionVAL interface or the DOMException interface on setting.
		domConfig
		This read-only property is an object that implements the DOMConfiguration interface.
		
		Functions of objects that implement the DocumentEditVAL interface:
		
		getDefinedElements(namespaceURI)
		This function returns an object that implements the NameList interface.
		The namespaceURI parameter is a String.
		validateDocument()
		This function returns a Number.
		
		*/
	}

}

