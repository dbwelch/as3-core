package org.flashx.core {
	
	/**
	*	Describes the contract for instances that encapsulate
	*	the flash variables passed into the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.06.2010
	*/
	public interface IFlashVariables {
		
		/**
		* 	Gets an object containing the raw flash variable
		* 	parameters passed into the movie.
		* 
		* 	@return The raw flash variable parameters.
		*/
		function get parameters():Object;
	}
}