package org.flashx.io.loaders.core {
	
	/**
	*	Describes the contract for a loader queue that can
	*	prioritize it's underlying elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public interface IPriorityQueue {
		
		/**
		* 	Prioritizes a loader element in the queue.
		* 
		* 	@param loader The loader element to prioritize.
		* 	@param priority The priority for the loader element.
		* 
		* 	@return A boolean indicating whether any change in priority
		* 	took place.
		*/
		function prioritize( loader:ILoaderElement, priority:int ):Boolean;
		
		/**
		* 	Prioritizes a loader element by identifier.
		* 
		* 	@param id The identifier for the loader element.
		* 	@param priority The priority for the loader element.
		* 
		* 	@return A boolean indicating whether any change in priority
		* 	took place.
		*/
		function prioritizeById( id:String, priority:int ):Boolean;
	}
}