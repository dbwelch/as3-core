package org.w3c.dom.validation
{
	
	/**
	* 
	*/
	public interface CharacterDataEditValidator extends NodeEditValidator
	{
		/*
		
		
		Objects that implement the CharacterDataEditVAL interface have all properties and functions of the NodeEditVAL interface as well as the properties and functions defined below.
		Functions of objects that implement the CharacterDataEditVAL interface:
		
		isWhitespaceOnly()
		This function returns a Number.
		canSetData(arg)
		This function returns a Number.
		The arg parameter is a String.
		canAppendData(arg)
		This function returns a Number.
		The arg parameter is a String.
		canReplaceData(offset, count, arg)
		This function returns a Number.
		The offset parameter is a Number. 
		The count parameter is a Number. 
		The arg parameter is a String. 
		This function can raise an object that implements the DOMException interface.
		canInsertData(offset, arg)
		This function returns a Number.
		The offset parameter is a Number. 
		The arg parameter is a String. 
		This function can raise an object that implements the DOMException interface.
		canDeleteData(offset, count)
		This function returns a Number.
		The offset parameter is a Number. 
		The count parameter is a Number. 
		This function can raise an object that implements the DOMException interface.
		
		*/
	}
}