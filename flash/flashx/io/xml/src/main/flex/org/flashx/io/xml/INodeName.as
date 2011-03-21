package org.flashx.io.xml {
	
	/**
	*	Describes the contract for instances that
	*	provide their element name when being
	*	serialized to XML.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.05.2007
	*/
	public interface INodeName {
		
		/**
		*	Should get the <code>String</code> value to
		*	use for the XML element name when this instance
		*	is being serialized to XML.
		*	
		*	@return A <code>String</code> element name.
		*/
		function getNodeName():String;
	}
}