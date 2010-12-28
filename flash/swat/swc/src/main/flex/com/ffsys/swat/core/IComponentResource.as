package com.ffsys.swat.core
{
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.ioc.IBeanDocument;	
	
	/**
	* 	Describes the contract for component resources.
	* 
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	public interface IComponentResource
	{
		/**
		* 	An identifier for this component.
		*/
		function get id():String;
		function set id( value:String ):void;
		
		/**
		* 	The list of resources for this component.
		*/
		function get resources():IResourceList;
		function set resources( value:IResourceList ):void;
		
		/**
		* 	The target object the component represents.
		*/
		function get target():Object;
		function set target( value:Object ):void;
		
		/**
		* 	The bean document for this component.
		*/
		function get document():IBeanDocument;
		function set document( value:IBeanDocument ):void;
	}
}