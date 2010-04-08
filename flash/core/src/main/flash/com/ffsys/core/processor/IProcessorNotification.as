package com.ffsys.core.processor {
	
	/**
	*	Describes the contract for instances
	*	that can receive a notification after
	*	a processing pass has completed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.10.2007
	*/
	public interface IProcessorNotification {
		
		/**
		*	Informs the <code>currentTarget</code>
		*	that processing is complete.
		*/
		function processed( processor:IProcessor ):void;
	}
}