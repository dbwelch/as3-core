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
		*	The <code>ILoaderQueue</code> implementation
		*	associated with this instance.
		*/
		function set queue( val:ILoaderQueue ):void;
		function get queue():ILoaderQueue;
		
		/**
		*	Arbitrary custom data associated with
		*	this instance.	
		*/
		function set customData( val:Object ):void;
		function get customData():Object;
		
		/**
		*	An <code>IResource</code> implementation
		*	associated with this instance.
		*/
		function set resource( val:IResource ):void;
		function get resource():IResource;
	
		/**
		*	The <code>URLRequest</code> used to load
		*	the resource.
		*/
		function set request( val:URLRequest ):void;
		function get request():URLRequest;
		
		/**
		*	The uniform resource indicator used to
		*	load the resource.
		*/
		function set uri( val:String ):void;
		function get uri():String;
		
		/**
		*	The <code>ILoadOptions</code> implementation
		*	associated with this instance.
		*/
		function set options( val:ILoadOptions ):void;
		function get options():ILoadOptions;
	}
}