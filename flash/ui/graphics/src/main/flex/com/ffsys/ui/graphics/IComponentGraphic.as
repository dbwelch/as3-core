package com.ffsys.ui.graphics
{
	import com.ffsys.ui.core.IComponentDraw;
	
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
		* 	A target width to use when drawing the shape graphic.
		*/
		function get targetWidth():Number;
		function set targetWidth( targetWidth:Number ):void;
		
		/**
		* 	A target height to use when drawing the shape graphic.
		*/		
		function get targetHeight():Number;
		function set targetHeight( targetHeight:Number ):void;
			
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
		*	Determines whether a stroke should be drawn.
		*/
		function get stroke():Boolean;
		function set stroke( stroke:Boolean ):void;
		
		/**
		* 	The thickness for the stroke.
		*/
		function get thickness():Number;
		function set thickness( thickness:Number ):void;
		
		/**
		* 	The color for the stroke.
		*/
		function get color():Number;
		function set color( color:Number ):void;
		
		/**
		* 	The opacity for the stroke.
		*/
		function get opacity():Number;
		function set opacity( opacity:Number ):void;
		
		/**
		*	The fill to use when creating this graphic.
		*/
		function get fill():IGraphicFill;
		function set fill( fill:IGraphicFill ):void;	
	}
}