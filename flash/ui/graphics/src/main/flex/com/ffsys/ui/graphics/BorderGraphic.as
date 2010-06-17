package com.ffsys.ui.graphics
{
	
	/**
	*	Represents a rectangular graphic border.
	* 
	* 	This graphic can never have a fill assigned to
	* 	it as it represents the border of an area.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class BorderGraphic extends RectangleGraphic
	{
		private var _sharp:Boolean = true;
		
		/**
		* 	Creates a <code>BorderGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*/
		public function BorderGraphic(
			width:Number = 25,
			height:Number = 25 )
		{
			super( width, height );
		}
		
		/**
		* 	Determines whether the border should be drawn
		* 	using a sharp method. The sharp method draws four
		* 	rectangular fills for each border line.
		* 
		* 	When sharp is false the border is drawn using a stroke.
		*/
		public function get sharp():Boolean
		{
			return _sharp;
		}
		
		public function set sharp( sharp:Boolean ):void
		{
			_sharp = sharp;
			this.stroke = !sharp;
		}
		
		/**
		* 	Overriden so that the fill is always null as
		* 	border graphics do not have a fill.
		*/
		override public function get fill():IGraphicFill
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( sharp && thickness > 0 )
			{
				//TODO: draw sharp borders
				
				//top
				graphics.drawRect( tx + thickness, ty, width - ( thickness * 2 ), thickness );
				
				//right
				graphics.drawRect( tx + ( width - thickness ), ty, thickness, height );
				
				//bottom
				graphics.drawRect( tx + thickness, ty - thickness, width - ( thickness * 2 ), thickness );
				
				//left
				graphics.drawRect( tx, ty, thickness, height );
			}else
			{
				graphics.drawRect( tx, ty, width, height );
			}
		}
	}
}