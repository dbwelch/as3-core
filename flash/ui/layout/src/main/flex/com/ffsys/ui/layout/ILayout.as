package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

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
		*	
		*	@param child The display object that was added.
		*	@param parent The parent display object container.
		*	@param index The child index.
		*/
		function added(
			child:DisplayObject,
			parent:DisplayObjectContainer,
			index:int ):void;
		
		/**
		*	Invoked when a child is removed.
		*	
		*	@param child The display object that was removed.
		*	@param parent The parent display object container.
		*	@param index The child index.
		*/
		function removed(
			child:DisplayObject,
			parent:DisplayObjectContainer,
			index:int ):void;
		
		/**
		*	Perform a full layout update of the target display
		*	object container.
		*	
		*	@param container The container to update with this layout.
		*/
		function update( container:DisplayObjectContainer ):void;		
		
		/**
		*	A generic spacing value for the layout.	
		*/
		function get spacing():Number;
		function set spacing( spacing:Number ):void;
		
		/**
		*	A size for this layout.
		*/
		function get size():Number;
		function set size( size:Number ):void;
		
		/**
		*	Horizontal alignment associated with this layout.
		*/
		function get horizontalAlign():String;
		function set horizontalAlign( value:String ):void;
		
		/**
		*	Vertical alignment associated with this layout.
		*/
		function get verticalAlign():String;
		function set verticalAlign( value:String ):void;
		
		/**
		*	The horizontal spacing for the layout.
		*/
		function get horizontalSpacing():Number;
		function set horizontalSpacing(
			horizontalSpacing:Number ):void;
		
		/**
		*	The vertical spacing for the layout.
		*/
		function get verticalSpacing():Number;
		function set verticalSpacing(
			verticalSpacing:Number ):void;
			
		/**
		*	Determines whether the layout should collapse
		*	margins for the first and last child when laying
		*	out child display objects.
		*/
		function get collapsed():Boolean;
		function set collapsed( collapsed:Boolean ):void;
	}
}