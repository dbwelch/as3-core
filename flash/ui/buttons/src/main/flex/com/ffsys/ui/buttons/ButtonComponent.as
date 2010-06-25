package com.ffsys.ui.buttons
{
	import flash.events.MouseEvent;
	import com.ffsys.ui.core.SkinAwareComponent;
	
	/**
	*	Abstract super class for all buttons.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class ButtonComponent extends SkinAwareComponent
	{
		private var _tooltip:String;
		
		/**
		* 	Creates an ButtonComponent instance.
		*/
		public function ButtonComponent()
		{
			super();
		}
		
		/**
		*	A tooltip this button should show on rollover.
		*/
		public function get tooltip():String
		{
			return _tooltip;
		}
		
		public function set tooltip( tooltip:String ):void
		{
			_tooltip = tooltip;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseDown(
			event:MouseEvent ):void
		{
			//
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
			if( tooltip != null )
			{
				utils.layer.tooltips.show( tooltip );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseOut(
			event:MouseEvent ):void
		{
			if( tooltip != null )
			{
				utils.layer.tooltips.hide();
			}
		}
	}
}