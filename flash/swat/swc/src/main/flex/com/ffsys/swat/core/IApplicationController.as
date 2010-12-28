package com.ffsys.swat.core
{
	import com.ffsys.core.IDestroy;
	import com.ffsys.ioc.IBeanAccess;
	import com.ffsys.swat.core.IMessageAccess;
	import com.ffsys.swat.core.IStyleAccess;
	import com.ffsys.ui.css.IStyleManager;
	
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
	}
}