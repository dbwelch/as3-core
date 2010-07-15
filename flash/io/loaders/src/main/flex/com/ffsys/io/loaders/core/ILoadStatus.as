package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for instances that provide
	*	methods for querying the status of a load operation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.12.2007
	*/
	public interface ILoadStatus {
		
		/**
		*	Indicates whether a load operation is currently
		*	in progress.
		*/
		function get loading():Boolean;
		
		/**
		*	Indicates that a resource was successfully
		*	loaded and an underlying <code>IResource</code>
		*	is available for the <code>ILoaderElement</code>
		*	instance.
		*/
		function get loaded():Boolean;
		
		/**
		*	Indicates whether a load operation is complete,
		*	this will be true even if the resource was not loaded
		*	successfully for example if an IO error or resource
		*	not found was encountered.
		*/
		function get complete():Boolean;
	}
}