package com.ffsys.io.loaders.core {
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for instances that
	*	encapsulate <code>ILoader</code> parameters.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public interface ILoaderParameters
		extends IStringIdentifier {
		
		/**
		*	An <code>IResource</code> implementation
		*	associated with this instance.
		*/
		function set resource( val:IResource ):void;
		function get resource():IResource;
	}
}