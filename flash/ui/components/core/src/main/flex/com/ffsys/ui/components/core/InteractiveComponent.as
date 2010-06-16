package com.ffsys.ui.components.core
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
	{
		
		/**
		* 	Creates an <code>InteractiveComponent</code> instance.
		*/
		public function InteractiveComponent()
		{
			super();
			this.interactive = true;
		}
		
		/**
		* 	Extends the enabled functionality to switch the hand cursor
		* 	and button mode on when interactive is <code>true</code>.
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
		}
		
		/**
		*	@inheritDoc 	
		*/
		override protected function added( event:Event ):void
		{
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			
			super.added( event );
		}
		
		/**
		*	@inheritDoc 	
		*/
		override protected function removed( event:Event ):void
		{
			removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			
			super.removed( event );
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
	}
}