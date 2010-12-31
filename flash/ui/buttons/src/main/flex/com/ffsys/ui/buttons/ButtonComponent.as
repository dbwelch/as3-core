package com.ffsys.ui.buttons
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.core.State;
	
	/**
	*	Abstract super class for all buttons.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class ButtonComponent extends InteractiveComponent
		implements IButton
	{
		private var _loop:String;
		private var _selectable:Boolean;
		private var _selected:Boolean;
		private var _currentState:State;
		
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
			this.mouseChildren = false;
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
		
		protected function updateCurrentState( state:State ):void
		{
			if( state != null )
			{
				_currentState = state;
				//no need to take selection into account
				if( !this.selectable )
				{
					updateState( state );
					return;
				}
				
				if( this.selected )
				{
					if( state.primary == State.MAIN_ID )
					{
						updateState( new State( State.SELECTED_ID ) );
					}else
					{
						//concatenate the selection state and the mouse related
						//state
						var states:Array = state.getStateElements();
						var modified:State = new State();
						modified.setStateElements( State.SELECTED_ID, states );
						updateState( modified );
					}
				}else{
					//use the normal state no selected state applies
					updateState( state );
				}
			}
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
			if( selectable )
			{
				updateCurrentState(
					_currentState != null ?
						_currentState.clone() : new State( State.MAIN_ID ) );
			}
		}
		
		/**
		*	@private
		*/
		private function dispatchLoopEvent( event:Event ):void
		{
			if( loop != null )
			{
				var evt:MouseEvent = new MouseEvent(
					loop, true, false, mouseX, mouseY );
				dispatchEvent( evt );
				looping( evt );
			}
		}
		
		/**
		*	Invoked while this button component is operating in a
		*	continuous loop.
		*/
		protected function looping( event:MouseEvent ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseDown(
			event:MouseEvent ):void
		{
			updateCurrentState( new State( State.DOWN_ID ) );
			
			if( loop && loop == ButtonLoopMode.DOWN )
			{
				//trace("ButtonComponent::dispatchLoopEvent()", "STARTING BUTTON DOWN LOOP" );
				
				//we need to remove this listener while looping
				removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				startLoop( loop, event );
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
				//add back our mouse down listener
				addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stopLoop( loop, event );
			}
			
			super.onMouseUp( event );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function onMouseClick(
			event:MouseEvent ):void
		{
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
				updateCurrentState( new State( State.OVER_ID ) );
			
				if( loop && loop == ButtonLoopMode.OVER )
				{
					//remove our listener
					removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
					startLoop( loop, event );
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
			updateCurrentState( new State( State.MAIN_ID ) );
			
			if( loop && loop == ButtonLoopMode.OVER )
			{
				//add our listener back
				addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				stopLoop( loop, event );
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
				//add back our mouse down listener
				addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stopLoop( loop, event );
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
		
		/**
		*	@private	
		*/
		private function startLoop( mode:String, event:MouseEvent ):void
		{
			removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
			if( loop && mode == loop )
			{
				addEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
				loopStarted( event );
			}
		}
		
		/**
		*	@private	
		*/
		private function stopLoop( mode:String, event:MouseEvent ):void
		{
			if( !mode || ( loop && loop == mode ) )
			{
				removeEventListener( Event.ENTER_FRAME, dispatchLoopEvent );
				loopStopped( event );
			}
		}
		
		/**
		*	Invoked when button looping starts.	
		*/
		protected function loopStarted( event:MouseEvent ):void
		{
			//
		}
		
		/**
		*	Invoked when button looping stops.	
		*/
		protected function loopStopped( event:MouseEvent ):void
		{
			//
		}
	}
}