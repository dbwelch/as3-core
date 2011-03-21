package org.flashx.swat.configuration {
	
	import flash.events.IEventDispatcher;
	
	import org.flashx.core.IDestroy;
	import org.flashx.core.IStringIdentifier;
	import org.flashx.ioc.IBeanAccess;

	import org.flashx.swat.configuration.locale.ILocaleManager;
	
	import org.flashx.swat.core.IComponentResource;
	import org.flashx.swat.core.IFlashVariablesAware;	
	import org.flashx.swat.core.IMessageAccess;
	import org.flashx.swat.core.IResourcesAware;
	import org.flashx.swat.core.IResourceAccess;
	import org.flashx.swat.core.ISettingAccess;
	import org.flashx.swat.core.IStyleAccess;
	
	import org.flashx.ui.css.IStyleManager;
	
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