package com.ffsys.ui.core
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ffsys.ui.drag.IDragOperation;
	
	/**
	*	Represents a component that is configured to receive mouse events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class InteractiveComponent extends UIComponent
		implements IInteractiveComponent
	{
		private var _drag:IDragOperation;
		
		/**
		* 	Creates an <code>InteractiveComponent</code> instance.
		*/
		public function InteractiveComponent()
		{
			super();
			this.interactive = true;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get drag():IDragOperation
		{
			return _drag;
		}
		
		public function set drag( drag:IDragOperation ):void
		{
			removeEventListener( MouseEvent.MOUSE_DOWN, onDragMouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, onDragMouseUp );
			
			_drag = drag;

			if( drag )
			{
				addEventListener( MouseEvent.MOUSE_DOWN, onDragMouseDown );
				addEventListener( MouseEvent.MOUSE_UP, onDragMouseUp );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get interactive():Boolean
		{
			return enabled;
		}
		
		public function set interactive( interactive:Boolean ):void
		{
			buttonMode = interactive;
			useHandCursor = interactive;
			enabled = interactive;
			
			interactive ? addMouseListeners() : removeMouseListeners();
		}
		
		/**
		*	Adds mouse listeners to this component.	
		*/
		protected function addMouseListeners():void
		{
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			addEventListener( MouseEvent.CLICK, onMouseClick );
		}
		
		/**
		*	Removes mouse listeners from this component.
		*/
		protected function removeMouseListeners():void
		{			
			removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			removeEventListener( MouseEvent.CLICK, onMouseClick );
		}
		
		/**
		* 	Invoked when the mouse is pressed on this instance.
		* 
		* 	@param event The mouse event.
		*/
		private function onDragMouseDown(
			event:MouseEvent ):void
		{
			if( drag )
			{
				drag.start( this );
			}
		}
		
		/**
		* 	Invoked when the mouse is released on this instance.
		* 
		* 	@param event The mouse event.
		*/
		private function onDragMouseUp(
			event:MouseEvent ):void
		{
			if( drag )
			{
				drag.stop();
			}
		}
		
		/**
		* 	Invoked when the mouse is pressed on this instance.
		* 
		* 	@param event The mouse event.
		*/
		protected function onMouseDown(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	Invoked when the mouse is released on this instance.
		* 
		* 	@param event The mouse event.
		*/
		protected function onMouseUp(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	Invoked when the mouse is moved over this instance.
		* 
		* 	@param event The mouse event.
		*/
		protected function onMouseOver(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	Invoked when the mouse is moved out of this instance.
		* 
		* 	@param event The mouse event.
		*/
		protected function onMouseOut(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	Invoked when the mouse is clicked on this instance.
		* 
		* 	@param event The mouse event.
		*/
		protected function onMouseClick(
			event:MouseEvent ):void
		{
			//
		}
	}
}