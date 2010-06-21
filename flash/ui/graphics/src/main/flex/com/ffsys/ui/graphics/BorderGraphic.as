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
		* 	@param stroke The stroke for the border.
		*	@param sharp Whether sharp corners should be drawm.
		*/
		public function BorderGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null,
			sharp:Boolean = true )
		{
			super( width, height, stroke, fill );
			this.sharp = sharp;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set stroke( stroke:IStroke ):void
		{
			super.stroke = stroke;
			
			trace("BorderGraphic::stroke(), ", stroke );
			
			if( sharp && this.stroke && !this.fill )
			{
				this.fill = new SolidFill(
					this.stroke.color,
					this.stroke.alpha );
			}
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
			width:Number, height:Number ):Boolean
		{
			return false;
		}

		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( sharp && stroke )
			{
				var thickness:Number = stroke.thickness;
				
				//handle hairline strokes
				if( thickness == 0 )
				{
					thickness = 0.5;
				}
				
				trace("BorderGraphic::doDraw(), ", tx, ty, width, thickness );
				
				//top
				graphics.drawRect( 
					tx, ty,
					width, thickness );

				//right
				graphics.drawRect(
					tx + ( width - thickness ),
					ty + thickness,
					thickness,
					height - ( thickness * 2 ) );
				//bottom
				graphics.drawRect(
					tx, ty + ( height - thickness ),
					width, thickness );

				//left
				graphics.drawRect( tx, ty + thickness,
					thickness, height - ( thickness * 2 ) );
			}else
			{
				graphics.drawRect( tx, ty, width, height );
			}
		}
	}
}