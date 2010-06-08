package com.ffsys.swat.view
{
	import com.ffsys.swat.core.SwatFlashVariables;
	
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
		function get flashvars():SwatFlashVariables;
		
		/**
		*	Sets the flash variables for the application.
		* 
		* 	@param flashvars The flash variables for the application.
		*/
		function set flashvars( flashvars:SwatFlashVariables ):void;
	}
}