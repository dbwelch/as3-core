package org.flashx.io.xml {
	
	/**
	*	Describes the contract for instances
	*	that can be notified that the
	*	deserialization pass on them is complete.
	*	
	*	Useful for testing all required values
	*	have been specified.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.09.2007
	*/
	public interface IDeserializeComplete {
		function deserialized():void;
	}
}