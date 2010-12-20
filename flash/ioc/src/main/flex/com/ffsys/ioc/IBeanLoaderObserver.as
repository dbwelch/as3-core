package com.ffsys.ioc
{
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;		
	
	public interface IBeanLoaderObserver
	{
		/**
		* 	Determines what the load behaviour should be for file
		* 	dependencies declared on this bean.
		* 
		* 	When the implementation of this method returns <code>true</code>
		* 	the loader queue will be started as soon as possible after the
		* 	bean has been instantiated.
		* 
		* 	When the implementation of this method returns <code>false</code>
		* 	no further call back methods will be invoked until the <code>load</code>
		* 	method of the loader queue is invoked.
		* 
		* 	@param queue The loader queue of the file dependencies for
		* 	this bean.
		* 	@param descriptor The bean descriptor that instantiated this bean.
		* 	@param files The list of bean file dependencies.
		* 
		* 	@return A boolean indicating whether the loader
		* 	queue should start to load when after the bean has been
		* 	instantiated.
		*/
		function getFileLoadBehaviour(
			queue:ILoaderQueue,
			descriptor:IBeanDescriptor,
			files:Vector.<BeanFileDependency> ):Boolean;
		
		/**
		* 	Allows a bean loader observer to manipulate
		* 	or maintain a reference to the loader queue
		* 	prior to the load process starting.
		* 
		* 	@param queue The loader queue of the file dependencies for
		* 	this bean.
		* 	@param descriptor The bean descriptor that instantiated this bean.
		* 	@param files The list of bean file dependencies.
		* 
		* 	@return The loader queue handling the load operation.
		*/
		function doWithLoaderQueue(
			queue:ILoaderQueue,
			descriptor:IBeanDescriptor,
			files:Vector.<BeanFileDependency> ):ILoaderQueue;
		
		/**
		* 	Determines whether this bean should be responsible for
		* 	setting the corresponding bean property.
		* 
		* 	@param resource The loaded resource.
		* 	@param descriptor The bean descriptor that instantiated this bean.
		* 	@param dependency The bean file dependency being resolved.
		* 
		* 	@return A boolean indicating whether the <code>doWithResource</code> method
		* 	should be invoked.
		*/
		function shouldProcessResource(
			resource:IResource,
			descriptor:IBeanDescriptor,
			dependency:BeanFileDependency ):Boolean;
		
		/**
		* 	Invoked with the loaded resource if the <code>shouldProcessResource</code>
		* 	method returns <code>true</code>.
		* 
		* 	@param resource The loaded resource.
		* 	@param descriptor The bean descriptor that instantiated this bean.
		* 	@param dependency The bean file dependency being resolved.
		*/
		function doWithResource(
			resource:IResource,
			descriptor:IBeanDescriptor ):void;
		
		/**
		* 	Invoked when the loader queue is complete with the resource
		* 	list for all file dependencies.
		* 
		* 	@param resources The resource list.
		* 	@param descriptor The bean descriptor that instantiated this bean.
		*/
		function doWithResourceList(
			resources:IResourceList,
			descriptor:IBeanDescriptor ):void;
	}
}