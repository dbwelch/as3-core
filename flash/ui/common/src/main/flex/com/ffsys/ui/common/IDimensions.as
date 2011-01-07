package com.ffsys.ui.common
{
	import flash.geom.Rectangle;
	
	/**
	*	Describes the contract for implementations
	* 	that represent a set of dimensions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public interface IDimensions
	{				
		/**
		* 	Determines whether this implementation has no explicitly
		* 	set width.
		* 
		* 	@return A boolean indicating whether the width
		* 	of this implementation is flexible.
		*/
		function isFlexibleWidth():Boolean;
		
		/**
		* 	Determines whether this implementation has no explicitly
		* 	set height.
		* 
		* 	@return A boolean indicating whether the height
		* 	of this implementation is flexible.
		*/
		function isFlexibleHeight():Boolean;
		
		/**
		* 	A maximum width for these dimensions.
		*/
		function get maxWidth():Number;
		function set maxWidth( value:Number ):void;
		
		/**
		* 	A maximum height for these dimensions.
		*/
		function get maxHeight():Number;
		function set maxHeight( value:Number ):void;
		
		/**
		* 	A minimum width for these dimensions.
		*/
		function get minWidth():Number;
		function set minWidth( value:Number ):void;
		
		/**
		* 	A minimum height for these dimensions.
		*/
		function get minHeight():Number;
		function set minHeight( value:Number ):void;
	}
}