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
		private var _selectable:Boolean;
		private var _selected:Boolean;
		private var _mouseDown:Boolean;
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
		*	Determines whether this button is selectable.
		*	
		*	When a button is selected it behaves as a toggle button.
		*	Changing between a main and selected state depending upon
		*	it's selected value.
		*/
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		public function set selectable( selectable:Boolean ):void
		{
			_selectable = selectable;
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
		*	If this button is selectable this value
		*		
		*/
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected( selected:Boolean ):void
		{
			_selected = selected;
			
			if( selectable
				&& this.selected
				&& this.skin
			 	&& this.skin.hasState( State.SELECTED ) )
			{
				state = State.SELECTED;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseDown(
			event:MouseEvent ):void
		{
			_mouseDown = true;
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
			
			if( selectable )
			{
				_selected = !_selected;
			}
			
			//revert from down state to over
			if( _mouseDown
				&& this.skin
				&& this.skin.hasState( State.DOWN )
				&& this.skin.hasState( State.OVER ) )
			{
				this.state = State.OVER;
			}
			
			_mouseDown = false;
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
			var state:String = null;
			
			if( this.skin )
			{
				if( this.skin.hasState( State.MAIN ) )
				{
					state = State.MAIN;
				}
				
				if( selectable
					&& selected
				 	&& this.skin.hasState( State.SELECTED ) )
				{
					state = State.SELECTED;
				}
			}
			
			this.state = state;
			
			if( tooltip != null )
			{
				utils.layer.tooltips.hide();
			}
		}
	}
}