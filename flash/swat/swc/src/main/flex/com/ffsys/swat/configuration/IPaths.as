package com.ffsys.swat.configuration
{
	import com.ffsys.swat.configuration.rsls.IRuntimeResource;

	/**
	*	Determines the contract for objects that represent
	* 	global path settings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.10.2010
	*/
	public interface IPaths
	{
		/**
		* 	The parent configuration.
		*/
		function get parent():IConfiguration;
		function set parent( parent:IConfiguration ):void;
		
		/**
		* 	A global setting that determines that all runtime
		* 	resources should be loaded using absolute paths.
		*/
		function get absolute():Boolean;
		function set absolute( absolute:Boolean ):void;
		
		/**
		* 	The base path used when creating paths.
		*/
		function get base():String;
		function set base( base:String ):void;
		
		/**
		* 	The prefix used when creating paths.
		*/
		function get prefix():String;
		function set prefix( prefix:String ):void;
		
		/**
		* 	A path to concatenate to the base and prefix
		* 	when loading resources common to all locales.
		*/
		function get common():String;
		function set common( common:String ):void;
		
		/**
		* 	A path to concatenate to the base and prefix
		* 	when loading resources for a specific locale.
		*/
		function get locales():String;
		function set locales( locales:String ):void;	
		
		/**
		* 	Gets the translated path to a resource.
		* 
		* 	@param resource The resource to calculate the path for.
		* 
		* 	@return The translated path.
		*/
		function getTranslatedPath( resource:IRuntimeResource ):String;
	}
}