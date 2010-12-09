package com.ffsys.effects.tween {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.effects.events.TweenEvent;
	import com.ffsys.effects.events.TweenCompleteEvent;
	import com.ffsys.effects.events.TweenEndEvent;
	import com.ffsys.effects.events.TweenFinishEvent;
	import com.ffsys.effects.events.TweenPauseEvent;
	import com.ffsys.effects.events.TweenResumeEvent;
	import com.ffsys.effects.events.TweenStartEvent;
	import com.ffsys.effects.events.TweenStopEvent;
	import com.ffsys.effects.events.TweenUpdateEvent;
	import com.ffsys.effects.events.TweenCollectionStartEvent;
	import com.ffsys.effects.events.TweenCollectionStopEvent;
	import com.ffsys.effects.events.TweenCollectionPauseEvent;
	import com.ffsys.effects.events.TweenCollectionResumeEvent;
	import com.ffsys.effects.events.TweenCollectionCompleteEvent;
	import com.ffsys.effects.events.TweenCollectionFinishEvent;
	
	/**
	*	Represents an Abstract super class for all
	*	ITweenCollection instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class AbstractTween extends EventDispatcher
		implements ITween {			
		
		protected var _parentDecorator:TweenParentDecorator;
		protected var _statusDecorator:TweenStatusDecorator;
		protected var _parameters:ITweenParameters;
		
		protected var _valueFormatter:ITweenValueFormatter;
		protected var _updater:ITweenUpdater;
		
		public function AbstractTween()
		{
			super();
			
			_parentDecorator = new TweenParentDecorator();
			_statusDecorator = new TweenStatusDecorator();
			
			_parameters = new TweenParameters();
			TweenParametersDecorator( _parameters ).tween = this;
		}
		
		/**
		* 	Initializes all target properties to their start
		* 	values.
		*/
		public function initialize():void
		{
			//
		}
		
		public function set formatter( val:ITweenValueFormatter ):void
		{
			_valueFormatter = val;
		}
		
		public function get formatter():ITweenValueFormatter
		{
			return _valueFormatter;
		}
		
		public function set updater( val:ITweenUpdater ):void
		{
			_updater = val;
		}
		
		public function get updater():ITweenUpdater
		{
			return _updater;
		}		
		
		public function get parameters():ITweenParameters
		{
			return _parameters;
		}
		
		public function set parameters( value:ITweenParameters ):void
		{
			_parameters = parameters;
			
			//TODO: remove this in a refactor pass
			if( _parameters && _parameters is TweenParameters )
			{
				TweenParameters( _parameters ).tween = this;
			}
		}
		
		/*
		*	ITweenParent implementation.
		*/
		public function set parent( val:ITween ):void
		{
			_parentDecorator.parent = val;
		}
		
		public function get parent():ITween
		{
			return _parentDecorator.parent;
		}
		
		/*
		*	ITweenReverse implementation.	
		*/
		public function reverse():Array
		{
			return new Array();
		}
		
		/*
		*	ITweenStatus implementation.
		*/
		public function set playing( val:Boolean ):void
		{
			setPlaying( val );
		}
		
		public function get playing():Boolean
		{
			return _statusDecorator.playing;
		}
		
		public function set complete( val:Boolean ):void
		{
			setComplete( val );
		}
		
		public function get complete():Boolean
		{
			return _statusDecorator.complete;
		}
		
		public function set paused( val:Boolean ):void
		{
			setPaused( val );
		}		
		
		public function get paused():Boolean
		{
			return _statusDecorator.paused;
		}
		
		/**
		*	@private
		*
		*	Used internally to set the value of the
		*	playing status variable.
		*
		*	@param val a Boolean to set the playing status to
		*/
		protected function setPlaying( val:Boolean ):void
		{
			_statusDecorator.playing = val;
		}
		
		/**
		*	@private
		*
		*	Used internally to set the value of the
		*	complete status variable.
		*
		*	@param val a Boolean to set the complete status to
		*/
		protected function setComplete( val:Boolean ):void
		{
			_statusDecorator.complete = val;
		}		
		
		/**
		*	@private
		*
		*	Used internally to set the value of the
		*	paused status variable.
		*
		*	@param val a Boolean to set the paused status to
		*/
		protected function setPaused( val:Boolean ):void
		{
			_statusDecorator.paused = val;
		}				
		
		/*
		*	ITweenParameters implementation.
		*/
		public function get values():Array
		{
			return _parameters.values;
		}
						
		public function set properties( val:Array ):void
		{
			_parameters.properties = val;
		}
		
		public function get properties():Array
		{
			return _parameters.properties;
		}
		
		public function set easing( val:Array ):void
		{
			_parameters.easing = val;
		}
		
		public function get easing():Array
		{
			return _parameters.easing;
		}
		
		public function set endValues( val:Array ):void
		{
			_parameters.endValues = val;
		}		
		
		public function get endValues():Array
		{
			return _parameters.endValues;
		}					
		
		public function set duration( val:Number ):void
		{
			_parameters.duration = val;
		}
		
		public function get duration():Number
		{
			return _parameters.duration;
		}
		
		public function set delay( val:Number ):void
		{
			_parameters.delay = val;
		}
		
		public function get delay():Number
		{
			return _parameters.delay;
		}	
		
		public function set startValues( val:Array ):void
		{
			_parameters.startValues = val;
		}
		
		public function get startValues():Array
		{
			return _parameters.startValues;
		}		
		
		public function set loops( val:int ):void
		{
			_parameters.loops = val;
		}
		
		public function get loops():int
		{
			return _parameters.loops;
		}
		
		public function set originalStartValues( val:Array ):void
		{
			_parameters.originalStartValues = val;
		}
		
		public function get originalStartValues():Array
		{
			return _parameters.originalStartValues;
		}
		
		public function set originalEndValues( val:Array ):void
		{
			_parameters.originalEndValues = val;
		}
		
		public function get originalEndValues():Array
		{
			return _parameters.originalEndValues;
		}
		
		public function getParameters():Object
		{
			return _parameters.getParameters();
		}
		
		public function applyValues( values:Array, target:Object = null ):void
		{
			_parameters.applyValues( values, target );
		}
		
		public function applyOriginalStartValues():void
		{
			_parameters.applyOriginalStartValues();
		}
		
		public function applyOriginalEndValues():void
		{
			_parameters.applyOriginalEndValues();
		}		
		
		public function applyStartValues():void
		{
			_parameters.applyStartValues();
		}
		
		public function applyEndValues():void
		{
			_parameters.applyEndValues();
		}
		
		/*
		*	ITweenSpeed implementation.
		*/
		public function set refreshRate( val:int ):void
		{
			_parameters.refreshRate = val;			
		}
		
		public function get refreshRate():int
		{
			return _parameters.refreshRate;
		}
		
		public function set frameRate( val:int ):void
		{
			_parameters.frameRate = val;
		}
		
		public function get frameRate():int
		{
			return _parameters.frameRate;
		}		
		
		/*
		*	ITweenTarget implementation.
		*/
		
		/**
		*	@private
		*
		*	Declared so that we adhere to the ITweenTarget interface
		*	but no functionality is implemented as you cannot set the
		*	target of an ITweenCollection instance.
		*
		*/		
		public function set target( val:Object ):void
		{
			//
		}
		
		public function get target():Object
		{
			return new Object();
		}
		
		/*
		*	ITweenControl implementation.
		*/
		public function start( trigger:Boolean = false ):void
		{
			dispatchEvent( new TweenStartEvent( this ) );
		}
		
		public function stop():void
		{
			dispatchEvent( new TweenStopEvent( this ) );
		}
		
		public function pause():void
		{
			dispatchEvent( new TweenPauseEvent( this ) );
		}
		
		public function resume():void
		{
			dispatchEvent( new TweenResumeEvent( this ) );
		}
		
		public function toggle():void
		{
			!paused ? pause() : resume();
		}
		
		public function finish( original:Boolean = false ):void
		{
			TweenManager.removeTween( this );
			dispatchEvent( new TweenFinishEvent( this ) );
		}		
		
		/**
		*	IDefaultEasing implementation.
		*/
		public function getDefaultEasing():Function
		{
			return TweenConstants.DEFAULT_EASING;
		}		
		
		/*
		*	ITweenClone implementation.
		*/
		public function clone():ITween
		{
			throw new Error(
				"AbstractTween cannot be cloned directly, the clone() " +
				"method must be overriden." );
		}
		
		protected function resetAllStatus():void
		{
 			setPlaying( false );
			setComplete( false );
			setPaused( false );	
		}
	}
}