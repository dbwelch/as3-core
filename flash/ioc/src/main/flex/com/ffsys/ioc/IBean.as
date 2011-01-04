package com.ffsys.ioc
{
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Describes the contract for bean implementations that wish to be
	* 	notified during the bean construction lifecycle.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.01.2011
	*/
	public interface IBean extends IBeanFinalized
	{
		/**
		* 	Invoked after dependencies injected by
		* 	type have been resolved.
		* 
		* 	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		function afterInjection(
			descriptor:IBeanDescriptor ):void;
		
		/**
		* 	Invoked after bean properties have been set.
		* 
		* 	Method calls are handled prior to setting properties
		* 	so method calls have also been handled when this
		* 	method is invoked.
		* 
		* 	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		function afterProperties(
			descriptor:IBeanDescriptor ):void;
		
		/**
		* 	Invoked after any external file resources
		* 	declared by the bean have been handled.
		* 
		* 	This does not imply the resources have been
		* 	loaded simply that they have been resolved and
		* 	a loader queue encapsulating the resources is available.
		* 
		*	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		function afterResources(
			descriptor:IBeanDescriptor,
			queue:ILoaderQueue = null ):void;
	}
}