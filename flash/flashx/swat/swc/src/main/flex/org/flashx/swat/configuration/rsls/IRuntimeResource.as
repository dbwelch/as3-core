package org.flashx.swat.configuration.rsls {
	
	import org.flashx.core.IStringIdentifier;
	import org.flashx.swat.core.IConfigurationAware;
	
	import org.flashx.swat.configuration.IPaths;	
	import org.flashx.swat.configuration.locale.IConfigurationLocale;	
	
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
		extends IStringIdentifier,
				IResourceDefinitionElement,
		 		IConfigurationAware {
		
		/**
		*	The URL to the runtime resource.
		*/
		function get url():String;
		function set url( url:String ):void;
		
		/**
		* 	Determines whether this resource is flagged as being
		* 	absolute.
		*/
		function get absolute():Boolean;
		function set absolute( absolute:Boolean ):void;
		
		/**
		* 	Gets a translated path to a resource based
		* 	on a path configuration.
		* 
		* 	@param paths A path implementation to use
		* 	when determining the translated path.
		* 	@param locale A locale context used to determine
		* 	the translated path.
		* 
		* 	@return The translated path to the resource.
		*/
		function getTranslatedPath(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):String;
	}
}