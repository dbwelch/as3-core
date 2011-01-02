package com.ffsys.ui.common
{
	/**
	*	Describes the contract for components that maintain
	* 	a selected index.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public interface ISelectedIndex 
	{
	
		/**
		* 	Gets the currently selected index.
		*/
		function get selectedIndex():int;
	
		/**
		* 	Sets the currently selected index.
		*/
		function set selectedIndex( index:int ):void;
	
	}
}