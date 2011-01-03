package com.ffsys.ui.common
{
	import com.ffsys.ui.common.Edges;
	
	/**
	*	Encapsulates the data for a css border definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.01.2011
	*/
	public class Border extends Edges
		implements IBorder
	{
		private var _color:Number = NaN;
		private var _alpha:Number = NaN;
		
		/**
		* 	Creates a <code>Border</code> instance.
		* 
		* 	@param top The thickness of the top border.
		* 	@param right The thickness of the right border.
		* 	@param bottom The thickness of the bottom border.
		* 	@param left The thickness of the left border.
		* 	@param color A default colour.
		* 	@param alpha A default alpha.
		*/
		public function Border(
			top:Number = 0,
			right:Number = 0,
			bottom:Number = 0,
			left:Number = 0,
			color:Number = 0xFFFFFF,
			alpha:Number = 1 )
		{
			super( top, right, bottom, left );
			this.color = color;
			this.alpha = alpha;
		}
				
		/**
		* 	@inheritDoc
		*/
		public function get color():Number
		{
			return _color;
		}
		
		public function set color(value:Number):void
		{
			_color = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha( value:Number ):void
		{
			_alpha = value;
		}
	}
}