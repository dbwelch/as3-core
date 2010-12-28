package com.ffsys.swat.core
{
	import com.ffsys.ui.css.IStyleManager;
	
	/**
	*	Describes the contract for implementations
	*	that are aware of the application style manager.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.12.2010
	*/
	public interface IStyleManagerAware
	{
		/**
		* 	The application style manager.
		*/
		function get styleManager():IStyleManager;
		function set styleManager( manager:IStyleManager ):void;
	}
}