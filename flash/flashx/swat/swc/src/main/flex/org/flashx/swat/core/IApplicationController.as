package org.flashx.swat.core
{
	import flash.display.DisplayObject;
	
	import org.flashx.core.IDestroy;
	import org.flashx.ioc.IBeanAccess;
	import org.flashx.swat.core.IMessageAccess;
	import org.flashx.swat.core.IStyleAccess;
	import org.flashx.ui.css.IStyleManager;
	
	/**
	*	Describes the contract for application controllers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.12.2010
	*/
	public interface IApplicationController
		extends IDestroy,
				IBeanAccess,
				IMessageAccess,
				IStyleAccess,
				IConfigurationAware
	{

		/**
		* 	Gets the application style manager.
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
		* 	Gets a view component.
		* 
		* 	@param id The identifier for the component.
		* 	@param bindings Bindings to expose when parsing
		* 	the view document.
		* 
		* 	@return The display object created when the view xml
		* 	document was parsed.
		*/
		function getView( id:String, ...bindings ):DisplayObject;
	}
}