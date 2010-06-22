package com.ffsys.ui.containers
{
	import flash.display.DisplayObject;
	
	/**
	*	Describes the contract for containers that allow
	* 	child display objects to be selected.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public interface ISelectableContainer
	{
		/**
		* 	Gets the currently selected item.
		*/
		function get selectedItem():DisplayObject;
		
		/**
		* 	Sets the currently selected item.	
		*/
		function set selectedItem( item:DisplayObject ):void;
		
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
