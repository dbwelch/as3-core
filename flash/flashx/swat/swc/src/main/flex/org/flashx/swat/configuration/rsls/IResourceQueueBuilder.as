package org.flashx.swat.configuration.rsls
{
	import org.flashx.ioc.IBeanManager;
	import org.flashx.ui.css.IStyleManager;
	import org.flashx.io.loaders.core.ILoaderQueue;
	
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
		* 	@param beanManager The bean manager being
		* 	used for the load operation.
		* 	@param styleManager The style manager being
		* 	used for the load operation.
		* 
		* 	@return A loader queue for the phase.
		*/
		function getQueueByPhase(
			phase:String,
			beanManager:IBeanManager,
			styleManager:IStyleManager ):ILoaderQueue;
	}
}