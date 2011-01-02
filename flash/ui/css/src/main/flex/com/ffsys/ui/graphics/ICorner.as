package com.ffsys.ui.graphics {
	
	/**
	*	Describes the contract for instances that
	*	represent the corner of a graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public interface ICorner {
		
		/**
		*	The width of the corner.
		*/
		function get width():Number;
		function set width( value:Number ):void;
		
		/**
		*	The height of the corner.
		*/
		function get height():Number;
		function set height( value:Number ):void;
		
		/**
		* 	Updates the width and height of this corner.
		*/
		function update(
			width:Number = 5,
			height:Number = NaN ):void;
		
		/**
		*	Resets this corner to zero values.	
		*/
		function reset():void;
		
		/**
		*	Determines whether this corner is empty
		*	and therefore no drawing is required.
		*/
		function isEmpty():Boolean;
	}
}