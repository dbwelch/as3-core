package com.ffsys.swat.view
{
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	
	/**
	*	Describes the contract for the application view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IApplication extends IApplicationView
	{
		/**
		*	Gets the flash variables for the application.
		* 
		* 	@return The flash variables for the application.
		*/
		function get flashvars():IFlashVariables;
		
		/**
		*	Sets the flash variables for the application.
		* 
		* 	@param flashvars The flash variables for the application.
		*/
		function set flashvars( flashvars:IFlashVariables ):void;
		
		function get preloader():IRuntimeAssetPreloader;
		function set preloader( preloader:IRuntimeAssetPreloader ):void;
	}
}