package com.ffsys.ui.common {
	
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
		*	@param top A value for the top edge.
		*	@param right A value for the right edge.
		*	@param bottom A value for the bottom edge.
		*	@param left A value for the left edge.
		*/
		public function Edges(
			top:Number = 0,
			right:Number = 0,
			bottom:Number = 0,
			left:Number = 0 )
		{
			super();
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get width():Number
		{
			return left + right;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get height():Number
		{
			return top + bottom;
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
		
		/**
		* 	@inheritDoc
		*/
		public function equal():Boolean
		{
			return ( left == top == right == bottom );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function valid():Boolean
		{
			return ( left > 0 || top > 0 || right > 0 || bottom > 0 );
		}
		
		/**
		* 	Gets the class used to creates a clone of this
		* 	implementation.
		* 
		* 	@return The class of this implementation.
		*/
		public function getCloneClass():Class
		{
			return Edges;
		}
		
		/**
		* 	Gets an instance of the clone class.
		* 
		* 	@return A new instance of the clone class.
		*/
		public function getCloneInstance():Object
		{
			var clazz:Class = getCloneClass();
			return new clazz();
		}
		
		/**
		* 	Creates a clone of this implementation.
		* 
		* 	@return The cloned version of this implementation.
		*/
		public function clone():IEdges
		{
			var cloned:IEdges = IEdges( getCloneInstance() );
			cloned.top = top;
			cloned.right = right;
			cloned.bottom = bottom;
			cloned.left = left;
			return cloned;
		}
	}
}