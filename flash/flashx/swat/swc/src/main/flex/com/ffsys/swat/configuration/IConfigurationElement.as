package com.ffsys.swat.configuration {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IStringIdentifier;
	import com.ffsys.ioc.IBeanAccess;

	import com.ffsys.swat.configuration.locale.ILocaleManager;
	
	import com.ffsys.swat.core.IComponentResource;
	import com.ffsys.swat.core.IFlashVariablesAware;	
	import com.ffsys.swat.core.IMessageAccess;
	import com.ffsys.swat.core.IResourcesAware;
	import com.ffsys.swat.core.IResourceAccess;
	import com.ffsys.swat.core.ISettingAccess;
	import com.ffsys.swat.core.IStyleAccess;
	
	import com.ffsys.ui.css.IStyleManager;
	
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
				ISettingAccess,
				IStyleAccess,
				IBeanAccess,
				IEventDispatcher {
		
		/**
		* 	Gets the style manager used to laod css documents.
		*/
		function get styleManager():IStyleManager;
		
		/**
		* 	Gets a component by identifier.
		* 
		* 	@param id The identifier for the component.
		* 
		* 	@return The component if it could be found
		* 	otherwise <code>null</code>.
		*/
		function getComponent( id:String ):Object;
				
		/**
		* 	Gets a component resource by identifier.
		* 
		* 	@param id The identifier for the component.
		* 
		* 	@return The component resource.
		*/	
		function getComponentById( id:String ):IComponentResource;
		
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