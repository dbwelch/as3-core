package com.ffsys.swat.configuration.rsls
{
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Describes the contract for implementations
	*	that manage building loader queues from a set of
	* 	encapsulated resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface IResourceQueueBuilder
	{
		/**
		* 	Gets a queue for the specified load phase.
		* 
		* 	@param phase The load phase.
		* 
		* 	@return A loader queue for the phase.
		*/
		function getQueueByPhase( phase:String ):ILoaderQueue;
	}
}