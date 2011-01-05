package com.ffsys.ui.common
{
	import flash.geom.Rectangle;
	
	/**
	*	Represents the dimensions of a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Dimensions extends Rectangle
		implements IDimensions
	{
		/**
		* 	Creates a <code>Dimensions</code> instance.
		* 
		* 	@param left The left offset.
		* 	@param top The top offset.
		* 	@param width A width value.
		* 	@param height A height value.
		*/
		public function Dimensions(
			left:Number = 0,
			top:Number = 0,
			width:Number = 0,
			height:Number = 0 )
		{
			super( left, top, width, height );
		}
		
		public function setPercentDimensions(
			parent:IDimensions,
			width:Number,
			height:Number ):void
		{
			
		}
	}
}