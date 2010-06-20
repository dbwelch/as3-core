package com.ffsys.ui.graphics
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
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
		*	@param sharp Whether sharp corners should be drawm.
		*/
		public function BorderGraphic(
			width:Number = 25,
			height:Number = 25,
			sharp:Boolean = true )
		{
			super( width, height );
			this.stroke = new Stroke();
			this.fill = new Fill( stroke.color, stroke.alpha );
			this.sharp = sharp;
		}
		
		/**
		* 	Determines whether the border should be drawn
		* 	using a sharp method.
		*/
		public function get sharp():Boolean
		{
			return _sharp;
		}
		
		public function set sharp( sharp:Boolean ):void
		{
			_sharp = sharp;
		}
		
		/**
		*	Prevents any stroke being applied for the border
		*	as borders are always based on the fill.
		*/		
		override protected function applyStroke(
			width:Number, height:Number ):void
		{
			//
		}

		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( sharp && stroke && stroke.thickness > 0 )
			{
				//top
				graphics.drawRect( 
					tx, ty,
					width, stroke.thickness );

				//right
				graphics.drawRect(
					tx + ( width - stroke.thickness ),
					ty + stroke.thickness,
					stroke.thickness,
					height - ( stroke.thickness * 2 ) );

				//bottom
				graphics.drawRect(
					tx, ty + ( height - stroke.thickness ),
					width, stroke.thickness );

				//left
				graphics.drawRect( tx, ty + stroke.thickness,
					stroke.thickness, height - ( stroke.thickness * 2 ) );
			}else
			{
				graphics.drawRect( tx, ty, width, height );
			}
		}
	}
}