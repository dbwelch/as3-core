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
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
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
		protected var _parametersDecorator:ITweenParameters;
		
		protected var _valueFormatter:ITweenValueFormatter;
		protected var _updater:ITweenUpdater;		
		
		public function AbstractTween()
		{
			super();
			
			_parentDecorator = new TweenParentDecorator();
			_statusDecorator = new TweenStatusDecorator();
			_parametersDecorator = new TweenParametersDecorator();
			TweenParametersDecorator( _parametersDecorator ).tween = this;
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
			return _parametersDecorator;
		}
		
		public function set parameters( value:ITweenParameters ):void
		{
			_parametersDecorator = parameters;
			
			//TODO: remove this in a refactor pass
			if( _parametersDecorator && _parametersDecorator is TweenParameters )
			{
				TweenParameters( _parametersDecorator ).tween = this;
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
			return _parametersDecorator.values;
		}
						
		public function set properties( val:Array ):void
		{
			_parametersDecorator.properties = val;
		}
		
		public function get properties():Array
		{
			return _parametersDecorator.properties;
		}
		
		public function set easing( val:Array ):void
		{
			_parametersDecorator.easing = val;
		}
		
		public function get easing():Array
		{
			return _parametersDecorator.easing;
		}
		
		public function set endValues( val:Array ):void
		{
			_parametersDecorator.endValues = val;
		}		
		
		public function get endValues():Array
		{
			return _parametersDecorator.endValues;
		}					
		
		public function set duration( val:Number ):void
		{
			_parametersDecorator.duration = val;
		}
		
		public function get duration():Number
		{
			return _parametersDecorator.duration;
		}
		
		public function set delay( val:Number ):void
		{
			_parametersDecorator.delay = val;
		}
		
		public function get delay():Number
		{
			return _parametersDecorator.delay;
		}	
		
		public function set startValues( val:Array ):void
		{
			_parametersDecorator.startValues = val;
		}
		
		public function get startValues():Array
		{
			return _parametersDecorator.startValues;
		}		
		
		public function set loops( val:int ):void
		{
			_parametersDecorator.loops = val;
		}
		
		public function get loops():int
		{
			return _parametersDecorator.loops;
		}
		
		public function set originalStartValues( val:Array ):void
		{
			_parametersDecorator.originalStartValues = val;
		}
		
		public function get originalStartValues():Array
		{
			return _parametersDecorator.originalStartValues;
		}
		
		public function set originalEndValues( val:Array ):void
		{
			_parametersDecorator.originalEndValues = val;
		}
		
		public function get originalEndValues():Array
		{
			return _parametersDecorator.originalEndValues;
		}
		
		public function getParameters():Object
		{
			return _parametersDecorator.getParameters();
		}
		
		public function applyValues( values:Array, target:Object = null ):void
		{
			_parametersDecorator.applyValues( values, target );
		}
		
		public function applyOriginalStartValues():void
		{
			_parametersDecorator.applyOriginalStartValues();
		}
		
		public function applyOriginalEndValues():void
		{
			_parametersDecorator.applyOriginalEndValues();
		}		
		
		public function applyStartValues():void
		{
			_parametersDecorator.applyStartValues();
		}
		
		public function applyEndValues():void
		{
			_parametersDecorator.applyEndValues();
		}
		
		/*
		*	ITweenSpeed implementation.
		*/
		public function set refreshRate( val:int ):void
		{
			_parametersDecorator.refreshRate = val;			
		}
		
		public function get refreshRate():int
		{
			return _parametersDecorator.refreshRate;
		}
		
		public function set frameRate( val:int ):void
		{
			_parametersDecorator.frameRate = val;
		}
		
		public function get frameRate():int
		{
			return _parametersDecorator.frameRate;
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
	
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = _parametersDecorator.getParameters();
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			output.push( parameters );
			return output;
		}

		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			//add a detail Object if necessary
			//output.detail = new Object();
			
			//pass in the default methods, properties and composites
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		override public function toString():String
		{
			return getObjectString();
		}	
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
