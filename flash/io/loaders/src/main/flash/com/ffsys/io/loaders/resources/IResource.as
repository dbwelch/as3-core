package com.ffsys.io.loaders.resources {
	
	import com.ffsys.io.core.IBytesTotal;
	
	/**
	*	Describes the contract for Objects that encapsulate
	*	loaded resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface IResource
		extends IResourceElement,
				IBytesTotal {
		
		/**
		*	Should return the underlying resource typed as an Object.
		*
		*	@return the loaded resource as an Object
		*/
		function get data():Object;	
		
		/**
		*	Gets the String URI the resource was loaded from.
		*
		*	@return the String URI the resource was loaded from
		*/
		function get uri():String;
	}
	
}
