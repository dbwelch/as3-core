package com.ffsys.io.xml {
	
	/**
	*	Describes the contract for classes that need
	*	to set the node name for child elements when
	*	serializing an <code>Array</code> to XML.
	*
	*	Defaults to Serializer.ARRAY_CHILD_NAME.
	*	
	*	@see com.ffsys.io.xml.Serializer
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.05.2007
	*/
	public interface IChildNodeName {
		
		/**
		*	Should return a <code>String</code> value
		*	to use for the node name(s) created when
		*	serializing this instance to XML.
		*	
		*	@return A <code>String</code> child node name.
		*/
		function getChildNodeName():String;
	}
}