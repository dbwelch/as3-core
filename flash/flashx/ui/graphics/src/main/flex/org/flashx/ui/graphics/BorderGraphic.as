package org.flashx.ui.graphics
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	import org.flashx.ui.common.IBorder;
	
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
		implements IBorderGraphic
	{
		private var _border:IBorder;
		
		/**
		* 	Creates a <code>BorderGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		* 	@param fill The fill for the border.
		*	@param border The border edge definitions.
		*/
		public function BorderGraphic(
			width:Number = NaN,
			height:Number = NaN,
			fill:IFill = null,
 			border:IBorder = null )
		{
			super( width, height, stroke, fill );
			this.border = border;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get border():IBorder
		{
			return _border;
		}
		
		public function set border( value:IBorder ):void
		{
			_border = value;
			if( _border != null
			 	&& fill == null )
			{
				fill = new SolidFill(
					_border.color, _border.alpha );
			}
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
			if( this.border != null
				&& this.border.valid() )
			{	
				//trace("BorderGraphic::doDraw(), ", tx, ty, width, thickness );
				var thickness:Number = NaN;
				
				var hasTop:Boolean = ( this.border.top > 0 );
				var hasRight:Boolean = ( this.border.right > 0 );
				var hasBottom:Boolean = ( this.border.bottom > 0 );
				var hasLeft:Boolean = ( this.border.left > 0 );															
				
				//top
				if( hasTop )
				{
					thickness = this.border.top;
					graphics.drawRect(
						tx, ty,
						width, thickness );
				}

				//right
				if( hasRight )
				{
					thickness = this.border.right;					
					graphics.drawRect(
						tx + ( width - thickness ),
						ty + border.top,
						thickness,
						height - ( border.top + border.bottom ) );
				}
				
				//bottom				
				if( hasBottom )
				{
					thickness = this.border.bottom;
					graphics.drawRect(
						tx, ty + ( height - thickness ),
						width, thickness );
				}

				//left
				if( hasLeft )
				{
					thickness = this.border.left;
					
					//trace("BorderGraphic::doDraw()", "DRAWING BORDER LEFT WITH THICKNESS: ", thickness );
					
					graphics.drawRect(
						tx,
						ty + border.top,
						thickness,
						height - ( border.top + border.bottom ) );
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return BorderGraphic;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function clone():IComponentGraphic
		{
			var graphic:IBorderGraphic =
				IBorderGraphic( super.clone() );
			if( this.border != null )
			{
				graphic.border = IBorder( this.border.clone() );
			}
			return graphic;
		}
	}
}