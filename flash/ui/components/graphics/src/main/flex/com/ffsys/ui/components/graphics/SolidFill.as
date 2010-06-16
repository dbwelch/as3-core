package com.ffsys.ui.components.graphics
{
	import flash.display.Graphics;
	
	/**
	*	Repesents a solid fill.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class SolidFill extends Object
		implements IGraphicFill
	{
		private var _color:Number;
		private var _alpha:Number;
		
		/**
		* 	Creates an <code>SolidFill</code> instance.
		* 
		* 	@param color The color for the fill.
		* 	@param alpha The alpha for the fill.
		*/
		public function SolidFill(
			color:Number = 0x000000,
			alpha:Number = 1 )
		{
			super();
			this.color = color;
			this.alpha = alpha;
		}
		
		/**
		* 	The color for the fill.
		*/
		public function get color():Number
		{
			return _color;
		}
		
		public function set color( color:Number ):void
		{
			_color = color;
		}
		
		/**
		* 	The alpha for the fill.
		*/
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha( alpha:Number ):void
		{
			_alpha = alpha;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function apply( graphics:Graphics ):void
		{
			if( graphics )
			{
				graphics.beginFill( this.color, this.alpha );
			}
		}
	}
}