package com.ffsys.ui.layout {
	
	import flash.events.EventDispatcher;
	
	/**
	*	Encapsulates the four edges of a rectangle.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Edges extends EventDispatcher
		implements IEdges {
		
		protected var _left:Number = 0;
		protected var _top:Number = 0;
		protected var _right:Number = 0;
		protected var _bottom:Number = 0;
		
		/**
		*	Creates an <code>Edges</code> instance.	
		*	
		*	@param left A value for the left edge.
		*	@param top A value for the top edge.
		*	@param right A value for the right edge.
		*	@param bottom A value for the bottom edge.
		*/
		public function Edges(
			left:Number = 0,
			top:Number = 0,
			right:Number = 0,
			bottom:Number = 0 )
		{
			super();
			this.left = left;
			this.top = top;
			this.right = right;
			this.bottom = bottom;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get left():Number
		{
			return _left;
		}
		
		public function set left( left:Number ):void
		{
			_left = left;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get top():Number
		{
			return _top;
		}
		
		public function set top( top:Number ):void
		{
			_top = top;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get right():Number
		{
			return _right;
		}
		
		public function set right( right:Number ):void
		{
			_right = right;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bottom():Number
		{
			return _bottom;
		}
		
		public function set bottom( bottom:Number ):void
		{
			_bottom = bottom;
		}
	}
}