package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;

	/**
	*	Describes the contract for all instances
	*	that handle the layout for child components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface ILayout
	{
		/**
		*	Invoked when a child is added.
		*/
		function added( child:DisplayObject ):void;
		
		/**
		*	Invoked when a child is removed.
		*/
		function removed( child:DisplayObject ):void;
	}
}