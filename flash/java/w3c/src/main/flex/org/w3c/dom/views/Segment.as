package org.w3c.dom.views
{

	public interface Segment
	{
		/*
		
		Objects that implement the Segment interface:
		Objects that implement the Segment interface have all properties and functions of the Match interface as well as the properties and functions defined below.
		Properties of objects that implement the Segment interface:
		criteria
		This property is an object that implements the Match interface.
		order
		This property is a String.
		Functions of objects that implement the Segment interface:
		addItem(add)
		This function has no return value. 
		The add parameter is an object that implements the Item interface.
		createMatchString(test, name, value)
		This function returns an object that implements the MatchString interface.
		The test parameter is a Number. 
		The name parameter is a String. 
		The value parameter is a String.
		createMatchInteger(test, name, value)
		This function returns an object that implements the MatchInteger interface.
		The test parameter is a Number. 
		The name parameter is a String. 
		The value parameter is a Number.
		createMatchBoolean(test, name, value)
		This function returns an object that implements the MatchBoolean interface.
		The test parameter is a Number. 
		The name parameter is a String. 
		The value parameter is a Boolean.
		createMatchContent(test, name, offset, nodeArg)
		This function returns an object that implements the MatchContent interface.
		The test parameter is a Number. 
		The name parameter is a String. 
		The offset parameter is a Number. 
		The nodeArg parameter is an object that implements the Node interface.
		createMatchSet(test)
		This function returns an object that implements the MatchSet interface.
		The test parameter is a Number.
		createStringItem(name)
		This function returns an object that implements the StringItem interface.
		The name parameter is a String.
		createIntegerItem(name)
		This function returns an object that implements the IntegerItem interface.
		The name parameter is a String.
		createBooleanItem(name)
		This function returns an object that implements the BooleanItem interface.
		The name parameter is a String.
		createContentItem(name)
		This function returns an object that implements the ContentItem interface.
		The name parameter is a String.
		getItem(index)
		This function has no return value. 
		The index parameter is a Number.
		getNext()
		This function returns a Boolean.		
		
		*/
	}

}

