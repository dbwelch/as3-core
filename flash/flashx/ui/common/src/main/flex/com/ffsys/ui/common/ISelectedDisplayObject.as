package com.ffsys.ui.common
{
	import flash.display.DisplayObject;
	
	/**
	*	Describes the contract for components that maintain
	* 	a selected display object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public interface ISelectedDisplayObject
	{
		/**
		* 	Gets the currently selected item.
		*/
		function get selectedItem():DisplayObject;
	
		/**
		* 	Sets the currently selected item.
		*/
		function set selectedItem( item:DisplayObject ):void;	
	}
}

