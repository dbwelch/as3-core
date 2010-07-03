package com.ffsys.ui.graphics
{
	
	/**
	*	Represents a rectangular component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class RectangleGraphic extends ComponentGraphic
	{
		private var _pointer:IPointer;
		
		/**
		* 	Creates a <code>RectangleGraphic</code> instance.
		* 
		* 	@param width The width of the rectangle.
		* 	@param height The height of the rectangle.
		*/
		public function RectangleGraphic(
			width:Number = 25,
			height:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( width, height, stroke, fill );
		}
		
		public function get pointer():IPointer
		{
			return _pointer;
		}
		
		public function set pointer( value:IPointer ):void
		{
			_pointer = value;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			if( pointer == null )
			{
				graphics.drawRect( tx, ty, width, height );
			}else{
				//TODO: implement pointer drawing
			}
		}
	}
}