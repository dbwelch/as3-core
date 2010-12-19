package com.ffsys.swat.core {
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.IConfiguration;
	
	/**
	*	Describes the contract for implementations that respond
	* 	to module load events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IModuleLoadListener {
		
		/**
		* 	Invoked with resource related events.
		* 
		* 	@param event The load event.
		*/
		function resource( event:RslEvent ):void;
		
		/**
		*	Invoked when all runtime resources have been loaded.
		* 
		* 	@param event The load event.
		*/
		function complete( event:RslEvent ):void;
	}
}