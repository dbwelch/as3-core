package com.ffsys.ui.buttons
{
	import flash.events.Event;
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
		implements IButton
	{
		private var _loop:String;
		private var _selectable:Boolean;
		private var _selected:Boolean;
		
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
		*	@inheritDoc
		*/
		public function get loop():String
		{
			return _loop;
		}
		
		public function set loop( value:String ):void
		{
			if( value
			 	&& ( value != ButtonLoopMode.OVER && value != ButtonLoopMode.DOWN ) )
			{
				throw new Error(
					"Invalid button loop mode '" + value + "'." );
			}
			
			_loop = value;
		}
		
		/**
		*	@inheritDoc
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
		*	@inheritDoc
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
		*	@private
		*/
		private function dispatchLoopEvent( event:Event ):void
		{
			if( loop != null )
			{
				var evt:MouseEvent = new MouseEvent( loop );
				dispatchEvent( evt );
			}
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
			
			if( loop && loop == ButtonLoopMode.DOWN )
			{
				addEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			}
			
			super.onMouseDown( event );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseUp(
			event:MouseEvent ):void
		{
			if( loop && loop == ButtonLoopMode.DOWN )
			{
				removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			}
			
			super.onMouseUp( event );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseClick(
			event:MouseEvent ):void
		{
			if( selectable )
			{
				_selected = !_selected;
			}			
			
			/*
			if( this.skin
				&& this.skin.hasState( State.DOWN )
				&& this.skin.hasState( State.OVER ) )
			{
				this.state = State.OVER;
			}
			*/
			
			if( loop && loop == ButtonLoopMode.DOWN )
			{
				removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			}
			
			super.onMouseClick( event );			
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseOver(
			event:MouseEvent ):void
		{
			//trace("ButtonComponent::onMouseOver(), ", this );
			
			if( !event.buttonDown )
			{
				if( this.skin && this.skin.hasState( State.OVER ) )
				{
					this.state = State.OVER;
				}
			
				if( loop && loop == ButtonLoopMode.OVER )
				{
					addEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
				}
			}
			
			super.onMouseOver( event );
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
			
			if( loop && loop == ButtonLoopMode.OVER )
			{
				removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			}			
			
			super.onMouseOut( event );
		}
		
		/**
		* 	@inheritDoc
		*/		
		override protected function onStageMouseUp( event:MouseEvent ):void
		{
			super.onStageMouseUp( event );
			
			if( loop && loop == ButtonLoopMode.DOWN )
			{
				removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function destroy():void
		{
			_loop = null;
			removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			super.destroy();
		}
	}
}