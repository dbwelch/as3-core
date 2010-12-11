package com.ffsys.io.loaders.resources {
	
	import com.ffsys.io.core.IBytesTotal;
	
	/**
	*	Describes the contract for implementations that encapsulate
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
		*	Gets the data this resource encapsulates.
		*/
		function get data():Object;	
		
		/**
		*	Gets the <code>URI</code> the resource was loaded from.
		*/
		function get uri():String;
	}
}