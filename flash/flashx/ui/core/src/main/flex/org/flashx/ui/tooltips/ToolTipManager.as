package org.flashx.ui.tooltips
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import org.flashx.ui.common.Orientation;
	import org.flashx.ui.core.UIComponent;
	
	/**
	*	Represents a layer for managing component tooltips.
	* 
	* 	This component is responsible for creating and managing
	* 	tooltips and positioning them while they are visible.
	*	
	*	The margins assigned to this component represent the
	*	distances between the mouse position and the tooltip
	*	renderer.
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
			this.margins.margin = 15;
			this.margins.bottom = 25;
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
			var p:Point = new Point( mouseX, mouseY );
			
			var display:DisplayObject = renderer as DisplayObject;
			
			var alignment:String = this.align;
			
			//try preferred alignment first
			p = getPositionFromAlignment( alignment );
			
			//off the top of the stage
			if( p.y < 0 )
			{
				alignment = Orientation.BOTTOM;
				//force the alignment to be bottom
				p = getPositionFromAlignment( alignment );
			}
			
			//determines whether the tooltip graphic requires redrawing
			var redraw:Boolean = false;
			
			//adjust pointer edges based on our alignment
			//to the mouse
			if( alignment && renderer && renderer.pointer )
			{
				var edge:String = renderer.pointer.edge;
				switch( alignment )
				{
					case Orientation.TOP:
						renderer.pointer.edge = Orientation.BOTTOM;
						break;
					case Orientation.BOTTOM:
						renderer.pointer.edge = Orientation.TOP;
						break;
					case Orientation.LEFT:
						renderer.pointer.edge = Orientation.RIGHT;
						break;
					case Orientation.RIGHT:
						renderer.pointer.edge = Orientation.LEFT;
						break;
				}
				
				//redraw if the pointer edge has changed
				redraw = ( renderer.pointer.edge != edge )
			}
			
			if( redraw )
			{
				renderer.graphic.redraw();
			}
			
			if( display )
			{
				display.x = p.x;
				display.y = p.y;
			}
		}
		
		/**
		*	@private	
		*/
		private function getPositionFromAlignment( alignment:String ):Point
		{
			var p:Point = new Point( mouseX, mouseY );
			
			var display:DisplayObject = renderer as DisplayObject;
			
			var w:Number = renderer.preferredWidth;
			var h:Number = renderer.preferredHeight;

			if( renderer.pointer )
			{
				if( alignment == Orientation.TOP
				 	|| alignment == Orientation.BOTTOM )
				{
					h += renderer.pointer.height;
				}else if( alignment == Orientation.LEFT
					|| alignment == Orientation.RIGHT )
				{
					w += renderer.pointer.height;
				}
			}
			
			switch( alignment )
			{
				case Orientation.TOP:
					p.x -= ( w * 0.5 );
					p.y -= ( h + margins.top );
					break;
				case Orientation.BOTTOM:
					p.x -= ( w * 0.5 );
					p.y += ( margins.bottom );
					break;
			}
			
			return p;
		}
	}
}