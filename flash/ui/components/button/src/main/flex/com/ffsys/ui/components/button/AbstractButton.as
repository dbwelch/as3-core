package com.ffsys.ui.components.button
{
	import flash.events.MouseEvent;
	import com.ffsys.ui.components.core.InteractiveComponent;
	
	/**
	*	Abstract super class for all buttons.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractButton extends InteractiveComponent
	{
		/**
		* 	Creates an AbstractButton instance.
		*/
		public function AbstractButton()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseDown(
			event:MouseEvent ):void
		{
			trace( "AbstractButton::onMouseDown()", this.interactive );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseUp(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseOver(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseOut(
			event:MouseEvent ):void
		{
			//
		}
	}
}