package com.ffsys.swat.configuration.rsls {
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for implementations that
	*	represent a runtime resource.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public interface IRuntimeResource
		extends IStringIdentifier {
		
		/**
		*	The URL to the runtime resource.
		*/
		function get url():String;
		function set url( url:String ):void;
		
		/**
		* 	@inheritDoc
		*/
		function get parent():IResourceCollection;
		function set parent( parent:IResourceCollection ):void;
		
		/**
		* 	Determines whether this resource is flagged as being
		* 	absolute.
		*/
		function get absolute():Boolean;
		function set absolute( absolute:Boolean ):void;
		
		/**
		* 	Gets the path to load the asset from based
		* 	on the parent object hierarchy settings.
		*/
		function getTranslatedPath():String;
	}
}