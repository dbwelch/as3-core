package com.ffsys.ui.graphics
{	
	/**
	*	Describes the contract for component graphics.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponentGraphic extends IComponentDraw
	{
		/**
		* 	A preferred width to use when drawing the graphic.
		*/
		function get preferredWidth():Number;
		function set preferredWidth( preferredWidth:Number ):void;
		
		/**
		* 	A preferred height to use when drawing the graphic.
		*/		
		function get preferredHeight():Number;
		function set preferredHeight( preferredHeight:Number ):void;
			
		/**
		* 	The x translation when drawing the shape.
		*/
		function get tx():Number;
		function set tx( tx:Number ):void;

		/**
		* 	The y translation when drawing the shape.
		*/
		function get ty():Number;
		function set ty( ty:Number ):void;
		
		/**
		*	The stroke for the graphic.
		*/
		function get stroke():IStroke;
		function set stroke( stroke:IStroke ):void;
		
		/**
		*	The fill for the graphic.
		*/
		function get fill():IFill;
		function set fill( fill:IFill ):void;	
	}
}