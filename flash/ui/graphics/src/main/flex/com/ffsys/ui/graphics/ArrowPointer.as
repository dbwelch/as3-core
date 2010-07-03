package com.ffsys.ui.graphics {
	
	import com.ffsys.ui.common.Orientation;
	
	/**
	*	Represents a pointer associated with another component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.07.2010
	*/
	public class ArrowPointer extends ArrowGraphic
		implements IPointer {
			
		private var _offset:Number;
		private var _edge:String = Orientation.BOTTOM;
		
		/**
		*	Creates an <code>ArrowPointer</code> instance.
		*	
		*	@param width The width of the arrow.
		*	@param height The height of the arrow.
		*	@param stroke A stroke for the graphic.
		*	@param fill A fill for the graphic.
		*/
		public function ArrowPointer(
			width:Number = 9,
			height:Number = 6,
			stroke:IStroke = null,
			fill:IFill = null,
			orientation:String = Orientation.RIGHT )
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get offset():Number
		{
			return _offset;
		}
		
		public function set offset( value:Number ):void
		{
			_offset = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get edge():String
		{
			return _edge;
		}
		
		public function set edge( value:String ):void
		{
			_edge = value;
		}
	}
}