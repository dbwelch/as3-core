package com.ffsys.ui.graphics
{	
	import com.ffsys.ui.common.IShape;
	
	/**
	*	Describes the contract for component graphics.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponentGraphic
		extends IShape,
				IComponentDraw
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
		
		/**
		*	This forces a render of the main drawing routine.
		*	
		*	Note that this simply forces the main drawing routine
		*	to run and does not start or end any stroke or fills.
		*	
		*	This allows for stroke and fill instances to invoke the
		*	main drawing routine when necessary.
		*	
		*	@param width The width to draw the shape at.
		*	@param height The height to draw the shape at.
		*/
		function render( width:Number, height:Number ):void;
	}
}