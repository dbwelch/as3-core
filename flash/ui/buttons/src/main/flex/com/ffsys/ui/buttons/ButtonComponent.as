package com.ffsys.ui.buttons
{
	import flash.events.MouseEvent;
	import com.ffsys.ui.core.SkinAwareComponent;
	import com.ffsys.ui.states.State;
	
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
		*	
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function ButtonComponent(
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
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
			if( this.skin && this.skin.hasState( State.DOWN ) )
			{
				this.state = State.DOWN;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseUp(
			event:MouseEvent ):void
		{
			if( this.skin && this.skin.hasState( State.MAIN ) )
			{
				this.state = State.MAIN;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseOver(
			event:MouseEvent ):void
		{
			if( this.skin && this.skin.hasState( State.OVER ) )
			{
				this.state = State.OVER;
			}			
			
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
			if( this.skin && this.skin.hasState( State.MAIN ) )
			{
				this.state = State.MAIN;
			}			
			
			if( tooltip != null )
			{
				utils.layer.tooltips.hide();
			}
		}		
	}
}