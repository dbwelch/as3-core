package com.ffsys.swat.configuration {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.ioc.IBeanAccess;
	import com.ffsys.swat.core.IFlashVariablesAware;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	
	import com.ffsys.swat.core.IResourcesAware;
	import com.ffsys.swat.core.IResourceAccess;
	import com.ffsys.swat.core.IStyleAccess;
	
	
	/**
	*	Describes the contract for objects that
	*	encapsulate configuration information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IConfigurationElement
		extends IDestroy,
				IFlashVariablesAware,
				IResourcesAware,
				IResourceAccess,
				IMessageAccess,
				IStyleAccess,
				IBeanAccess,
				IEventDispatcher {
		
		/**
		*	The locale manager.
		*/
		function get locales():ILocaleManager;
		function set locales( locales:ILocaleManager ):void;			
		
		/**
		* 	The path settings for this configuration.
		*/
		function get paths():IPaths;
		function set paths( paths:IPaths ):void;
	}
}