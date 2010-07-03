package com.ffsys.ui.tooltips
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.ffsys.ui.common.Orientation;
	import com.ffsys.ui.core.UIComponent;
	
	/**
	*	Represents a layer for managing component tooltips.
	* 
	* 	This component is responsible for creating and managing
	* 	tooltips and positioning them while they are visible.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class ToolTipManager extends UIComponent
		implements IToolTipManager
	{
		private var _timer:Timer;
		private var _renderer:IToolTipRenderer;
		private var _align:String = Orientation.TOP;
		private var _delay:Number;
		
		/**
		* 	Creates a <code>ToolTipManager</code> instance.
		*/
		public function ToolTipManager()
		{
			super();
			this.margins.margin = 10;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay( delay:Number ):void
		{
			_delay = delay;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get renderer():IToolTipRenderer
		{
			return _renderer;
		}
		
		public function set renderer( renderer:IToolTipRenderer ):void
		{
			_renderer = renderer;
		}
		
		/**
		* 	The preferred alignment of the tooltip relative
		* 	to the mouse cursor.
		*/
		public function get align():String
		{
			return _align;
		}
		
		public function set align( align:String ):void
		{
			_align = align;
		}
		
		/**
		*	@private	
		*/
		protected var text:String;
		
		/**
		* 	@inheritDoc
		*/
		public function show( text:String ):void
		{
			if( renderer == null )
			{
				throw new Error( "Cannot show a tooltip with a null renderer." );
			}
			
			if( text == null )
			{
				throw new Error( "Cannot show a tooltip with null text." );
			}
			
			this.text = text;
			
			if( _timer )
			{
				_timer.removeEventListener(
					TimerEvent.TIMER_COMPLETE, showTooltip );
				_timer.stop();
				_timer = null;
			}
			
			if( !isNaN( delay ) )
			{
				_timer = new Timer( delay, 1 );
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, showTooltip );
				_timer.start();
			}else{
				showTooltip();
			}
		}
		
		/**
		*	@private
		*	
		*	Handles displaying the tool	
		*/
		private function showTooltip( event:TimerEvent = null ):void
		{
			if( _timer )
			{
				_timer.removeEventListener(
					TimerEvent.TIMER_COMPLETE, showTooltip );
			}
			
			if( contains( DisplayObject( renderer ) ) )
			{
				renderer.update( text );
			}else
			{
				renderer.text = text;
				renderer.manager = this;
				addChild( DisplayObject( renderer ) );
				renderer.show( text );
				//position immediately
				position();
			}
			
			removeEventListener( Event.ENTER_FRAME, position );
			addEventListener( Event.ENTER_FRAME, position );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hide():void
		{
			if( _timer )
			{
				_timer.removeEventListener(
					TimerEvent.TIMER_COMPLETE, showTooltip );
				_timer.stop();
				_timer = null;
			}
			
			if( renderer && contains( DisplayObject( renderer ) ) )
			{
				renderer.hide();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hidden():void
		{
			removeEventListener( Event.ENTER_FRAME, position );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shown():void
		{
			//
		}
		
		/**
		* 	@private
		* 
		* 	Handles positioning the tooltip.
		*/
		private function position( event:Event = null ):void
		{
			//TODO: implement and add alignment option to determine how the tooltip
			//is aligned to the mouse
			
			var x:Number = mouseX;
			var y:Number = mouseY;
			
			var display:DisplayObject = renderer as DisplayObject;
			
			var w:Number = renderer.width;
			var h:Number = renderer.height;
			
			switch( align )
			{
				case Orientation.TOP:
					x -= ( w * 0.5 );
					y -= ( h + margins.top );
					break;
			}
			
			if( display )
			{
				display.x = x;
				display.y = y;
			}
		}
	}
}