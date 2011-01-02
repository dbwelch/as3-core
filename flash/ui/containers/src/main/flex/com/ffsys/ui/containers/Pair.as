package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.layout.HorizontalLayout;
	import com.ffsys.ui.layout.VerticalLayout;
	
	/**
	*	Lays out a pair of child components
	*	in either a vertical of horizontal
	*	manner.
	*	
	*	By default the child components are
	*	laid out horizontally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class Pair extends Container {
		
		private var _vertical:Boolean = false;
		private var _first:IComponent = null;
		private var _second:IComponent = null;
		
		/**
		*	Creates a <code>Pair</code> instance.
		*	
		*	@param vertical Whether the child components
		*	should be laid out vertically.
		*	@param size A fixed size for the pair layout.
		*	@param first The first component.
		*	@param second The second component.
		*/
		public function Pair(
			vertical:Boolean = false,
			size:Number = NaN,
			first:IComponent = null,
			second:IComponent = null )
		{
			super();
			this.first = first;
			this.second = second;
			this.vertical = vertical;
		}
		
		public function get first():IComponent
		{
			return _first;
		}
		
		public function set first( first:IComponent ):void
		{
			_first = first;
		}
		
		public function get second():IComponent
		{
			return _second;
		}
		
		public function set second( second:IComponent ):void
		{
			_second = second;
		}
		
		/**
		*	Determines whether child components should
		*	be laid out vertically.	
		*/
		public function get vertical():Boolean
		{
			return _vertical;
		}
		
		public function set vertical( vertical:Boolean ):void
		{
			_vertical = vertical;
			this.layout = this.vertical
				? new VerticalLayout() : new HorizontalLayout();
		}
	}
}