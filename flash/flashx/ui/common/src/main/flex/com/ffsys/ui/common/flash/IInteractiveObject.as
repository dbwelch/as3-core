package com.ffsys.ui.common.flash
{
	//import flash.display.NativeMenu;

	/**
	*	Defines the contract for interactive display objects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public interface IInteractiveObject extends IDisplayObject
	{
		
		/*
		function get contextMenu():NativeMenu;
		function set contextMenu(value:NativeMenu):void;
		*/
		
		function get doubleClickEnabled():Boolean;
		function set doubleClickEnabled(value:Boolean):void;

		function get focusRect():Object;
		function set focusRect(value:Object):void;

		function get mouseEnabled():Boolean;
		function set mouseEnabled(value:Boolean):void;

		function get tabEnabled():Boolean;
		function set tabEnabled(value:Boolean):void;

		function get tabIndex():int;
		function set tabIndex(value:int):void;
		
	}
}