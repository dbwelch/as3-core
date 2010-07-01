package com.ffsys.ui.drag {
	
	import flash.geom.Rectangle;
	import com.ffsys.ui.core.IInteractiveComponent;
	
	/**
	*	Represents a drag operation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public class DragOperation extends Object
		implements IDragOperation {
			
		private var _bounds:Rectangle;
		private var _locked:Boolean;
		private var _source:IInteractiveComponent;
		
		/**
		*	Creates a <code>DragOperation</code> instance.
		*/
		public function DragOperation()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get source():IInteractiveComponent
		{
			return _source;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function set bounds( bounds:Rectangle ):void
		{
			_bounds = bounds;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get locked():Boolean
		{
			return _locked;
		}
		
		public function set locked( locked:Boolean ):void
		{
			_locked = locked;
		}
		
		/**
		*	@inheritDoc
		*/
		public function start( source:IInteractiveComponent ):void
		{
			_source = source;
			source.startDrag( locked, bounds );
		}
		
		/**
		*	@inheritDoc
		*/
		public function stop():void
		{
			source.stopDrag();
			
			_source = null;
		}
	}
}