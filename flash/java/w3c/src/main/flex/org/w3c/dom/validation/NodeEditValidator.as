package org.w3c.dom.validation
{
	
	/**
	* 	
	*/
	public interface NodeEditValidator
	{
		
		/*
		
		NodeEditVAL.VAL_WF
		The value of the constant NodeEditVAL.VAL_WF is 1.
		NodeEditVAL.VAL_NS_WF
		The value of the constant NodeEditVAL.VAL_NS_WF is 2.
		NodeEditVAL.VAL_INCOMPLETE
		The value of the constant NodeEditVAL.VAL_INCOMPLETE is 3.
		NodeEditVAL.VAL_SCHEMA
		The value of the constant NodeEditVAL.VAL_SCHEMA is 4.
		NodeEditVAL.VAL_TRUE
		The value of the constant NodeEditVAL.VAL_TRUE is 5.
		NodeEditVAL.VAL_FALSE
		The value of the constant NodeEditVAL.VAL_FALSE is 6.
		NodeEditVAL.VAL_UNKNOWN
		The value of the constant NodeEditVAL.VAL_UNKNOWN is 7.
		
		*/
		
		/*
		
		Properties of objects that implement the NodeEditVAL interface:
		
		defaultValue
		This read-only property is a String.
		enumeratedValues
		This read-only property is an object that implements the DOMStringList interface.
		
		Functions of objects that implement the NodeEditVAL interface:
		canInsertBefore(newChild, refChild)
		This function returns a Number.
		The newChild parameter is an object that implements the Node interface. 
		The refChild parameter is an object that implements the Node interface.
		canRemoveChild(oldChild)
		This function returns a Number.
		The oldChild parameter is an object that implements the Node interface.
		canReplaceChild(newChild, oldChild)
		This function returns a Number.
		The newChild parameter is an object that implements the Node interface. 
		The oldChild parameter is an object that implements the Node interface.
		canAppendChild(newChild)
		This function returns a Number.
		The newChild parameter is an object that implements the Node interface.
		nodeValidity(valType)
		This function returns a Number.
		The valType parameter is a Number.
		
		*/
	}

}

