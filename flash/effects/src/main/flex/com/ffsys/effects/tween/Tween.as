package com.ffsys.effects.tween {

	import flash.errors.IllegalOperationError;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	
	import com.ffsys.effects.events.TweenEvent;
	import com.ffsys.effects.events.TweenCompleteEvent;
	import com.ffsys.effects.events.TweenEndEvent;
	import com.ffsys.effects.events.TweenPauseEvent;
	import com.ffsys.effects.events.TweenResumeEvent;
	import com.ffsys.effects.events.TweenStartEvent;
	import com.ffsys.effects.events.TweenStopEvent;
	import com.ffsys.effects.events.TweenUpdateEvent;
	import com.ffsys.effects.events.TweenFinishEvent;
	
	public class Tween extends AbstractTween
		implements 	ITweenTrigger,
					ITweenDelta,
					ITweenValueFormatter,
					ITweenUpdater {
		
		/**
		*	The target Object whose properties we are tweening.
		*/
		private var _target:Object;
		
		private var _triggerTarget:ITween;
		private var _triggerType:String;
		
		private var _deltas:Array;
		
		/**
		*	Used to store the direction that an ITween instance
		*	is going in when looping.
		*/
		private var _direction:int;
		
		/**
		*	Stores the index of the current loop
		*	if this ITween is looping.
		*/
		private var _currentLoop:int;
		
		//timing variables
		private var _now:Number;
		private var _startTime:Number;
		private var _delayTimer:Timer;
		private var _startInt:Number;
		
		public function Tween(
			target:Object = null,
			parameters:ITweenParameters = null )
		{
			super();
			
			this.formatter = this;
			this.updater = this;
			
			//update our parameters decorator to point to the TweenParameters
			//argument
			//_parameters = parameters;
			
			_currentLoop = 0;
		
			this.direction = TweenConstants.OUTBOUND;
			this.parameters = parameters;
			this.target = target;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function initialize():void
		{
  			if( startValues && target && properties )
			{
				if( startValues.length != properties.length )
				{
					throw new Error(
						"Cannot initialize tween properties to their start values"
						+ " when the array lengths do not match." );
				}
				
				var property:String = null;
				for( var i:int = 0;i < properties.length;i++ )
				{
					property = properties[ i ];
					if( target.hasOwnProperty( property ) )
					{
						target[ property ] = startValues[ i ];
					}
				}
			}
		}
		
		/*
		*	ITweenReverse implementation.	
		*/
		override public function reverse():Array
		{
			var endTemp:Array = endValues.slice();
			var startTemp:Array = startValues.slice();
			
			trace( "Reverse : " + this );
			
			setEndValues( startTemp, false );
			setStartValues( endTemp );
			
			return startTemp;
		}
		
		/*
		*	ITweenTarget implementation.
		*/
		override public function set target( val:Object ):void
		{
			_target = val;
			
			if( _target )
			{
				//don't calculate the deltas here so we don't calculate them twice
				setEndValues( this.endValues, false );
			
				//calculate the deltas here
				setStartValues( this.startValues );
			}
		}
		
		override public function get target():Object
		{
			return _target;
		}
		
		/*
		*	ITweenParameters implementation.
		*/
		override public function set properties( properties:Array ):void
		{
			var i:int = 0;
			var l:int = properties.length;
			var prop:String;
			
			for( ;i < l;i++ )
			{
				prop = properties[ i ];
				if( target && !Object( target ).hasOwnProperty( prop ) )
				{
					throw new IllegalOperationError(
						"Tween property '" + prop +
						"' not found on Object: " + target.toString() );
				}
			}
		
			super.properties = properties;
		}
		
		/*
		*	ITweenDelta implementation.
		*/
		public function set deltas( val:Array ):void
		{
			_deltas = val;
		}
		
		public function get deltas():Array
		{
			return _deltas;
		}
		
		private var _elapsed:Number;
		
		private function setElapsed():void
		{
			_elapsed = _now - _startTime;
		}
		
		public function get elapsed():Number
		{
			return _elapsed;
		}
		
		private function tween( event:Event = null ):void
		{
			var prop:String;
			
			var i:int = 0;
			var l:int = properties.length;
			
			var values:Array = new Array();
			var durationMilliseconds:Number = this.duration * 1000;
			var durationComplete:Boolean = false;
			
			var easingMethod:Function;
			
			//trace( "Start time : " + _startTime );
			//trace( "Now : " + _now );
			
			for( ;i < l;i++)
			{
			
				setElapsed();
				prop = properties[ i ];
				easingMethod = easing[ i ];
				
				/*
				trace( "tween prop : " + prop );
				trace( "tween elapsed : " + elapsed );
				trace( "tween duration : " + durationMilliseconds );
				trace( "tween easingMethod : " + easingMethod );
				*/
				
				if( _elapsed >= durationMilliseconds )
				{
					//target[ prop ] = endValues[ i ];
					
					if( i == ( l - 1 ) )
					{
						
						dispatchEvent( new TweenEndEvent( this ) );
						
						stop();
						
						if( loops )
						{
							toggleDirection();
							
							if( direction == TweenConstants.OUTBOUND )
							{
								_currentLoop++;
							}
							
							if( _currentLoop < loops )
							{
								continueTo( null, delay );
							}else{
								reset();
								
								//trace( "Looped tween complete : " + this );
								
								durationComplete = true;
								
								//dispatchCompleteEvent();
								//return;
							}
							
						}else{
							//trace( "Tween complete : " + this );
							
							durationComplete = true;
						}
					}
				}else{
					
					//trace( "Tween : " + this );
					//trace( "Tween : " + target[ prop ] );
					
					values.push(
						this.formatter.formatTweenValue(
							easingMethod.call(
								null,
								_elapsed,
								startValues[ i ],
								deltas[ i ],
								//endValues[ i ],
								durationMilliseconds )
						)
					);
				}
			}
			
			if( durationComplete )
			{
				applyEndValues();
				dispatchCompleteEvent();
			}else{
				
				if(
					this.updater.shouldApplyTweenValues(
						properties,
						values
					)
				)
				{
				
					//now set the property values
					applyValues( values );
				
				}
			}
			
			//trace( "Elapsed : " + _elapsed );
			
			_now = getTimer();
		}
		
		/*
		*	ITweenValueFormatter implementation.
		*/
		
		public function formatTweenValue( value:Number ):Number
		{
			return value;
		}
		
		/*
		*	ITweenUpdater implementation.
		*/
		
		public function shouldApplyTweenValues( properties:Array, values:Array ):Boolean
		{
			return true;
		}
		
		public function shouldApplyTweenValue( property:String, value:Object ):Boolean
		{
			return true;
		}
		
		public function applyTweenValue( target:Object, property:String, value:Object ):void
		{
			target[ property ] = value;
		}		
		
		internal function dispatchCompleteEvent():void
		{
			clear();
			
			this.paused = false;
 			this.playing = false;
			this.complete = true;
			
			TweenManager.removeTween( this );
			
			//trace( "Tween dispatchCompleteEvent" );
			
			dispatchEvent( new TweenCompleteEvent( this ) );
		}
		
		/*
		*	ITweenControl implementation.
		*/
		override public function start( trigger:Boolean = false ):void
		{
			if( playing || _delayTimer )
			{
				return;
			}
			
  			if( paused )
			{
				resume();
				return;
			}
			
			if( hasTrigger() && !trigger )
			{
				return;
			}
			
			TweenManager.addTween( this );
			
			if( delay > 0 )
			{
				_delayTimer = new Timer( delay * 1000, 1 );
				_delayTimer.addEventListener( TimerEvent.TIMER, startTween );
				_delayTimer.start();
			}else{
				startTween();
			}
		}
		
		private function clear():void
		{
			clearInterval( _startInt );
		}
		
		override public function stop():void
		{
			if( _delayTimer != null )
			{
				if( _delayTimer.running )
				{
					_delayTimer.stop();
				}
			}
						
			if( !playing )
			{
				return;
			}
			
			clear();
			this.playing = false;
			super.stop();
		}
		
		private var _startPauseTime:Number = 0;
		private var _pausedTime:Number = 0;
		
		override public function pause():void
		{
			if( _startInt )
			{
				
				_startPauseTime = getTimer();
				
				stop();
				this.paused = true;
				
				/*
				trace( "Pause duration: " + this.duration );
				trace( "Pause elapsed: " + this.elapsed );
				trace( "Pause start time: " + _startTime );
				trace( "Pause now time: " + _now );
				*/
				
				super.pause();
			}
		}
		
		/**
		*	Resumes playback of a paused Tween, if the Tween is not
		*	paused invoking this method has no effect.
		*/
		override public function resume():void
		{
			if( paused )
			{
				
				_pausedTime =
					getTimer() - _startPauseTime;

				_startTime = _startTime + _pausedTime;
				_now = getTimer();
				
				/*
				trace( "Resume paused time : " + _pausedTime );
				trace( "Resume start time: " + _startTime );
				trace( "Resume now time: " + _now );
				*/
				
				startTween( null, _startTime, _now );
				
				super.resume();
			}
		}
		
		/**
		*	Finishes the Tween and applies the end values to
		*	all the properties of the target Object, optionally
		*	using the original end values.
		*
		*	If the Tween is playing when this method is invoked
		*	the Tween is stopped.
		*
		*	@param original a Boolean indicating whether to use the original end values
		*/
		override public function finish( original:Boolean = false ):void
		{
			if( playing )
			{
				stop();
			}
			
			original ? applyOriginalEndValues() : applyEndValues();
			
			super.finish();
		}
		
		public function continueTo( endValues:Array = null, delay:Number = 0 ):void
		{
			if( endValues == null )
			{
				var osv:Array = originalStartValues.slice();
				
				///trace( "Continue to : " + ev );
			
				var ev:Array = ( direction == TweenConstants.INBOUND ) ? osv : originalEndValues.slice();
				
				//trace( "continue end vals : " + ev );
				
				var sv:Array = ( direction == TweenConstants.INBOUND ) ? originalEndValues.slice() : osv;
				
				setEndValues( ev, false );
				
				//trace( "continue start vals : " + sv );
				
				setStartValues( sv );
				
			}else{
				setEndValues( endValues, false );
				setStartValues();
			}

			startTween();

		}
		
		public function reset():void
		{	
			this.direction = TweenConstants.OUTBOUND;
			_currentLoop = 0;
			setEndValues( originalEndValues, false );
			setStartValues( originalStartValues );
		}
		
		/*
		*	ITweenStatus implementation.
		*/
		
		/**
		*	Sets whether this Tween is playing.
		*
		*	If the Tween is not playing and you attempt
		*	to set this property to true the start() method
		*	is invoked.
		*
		*	If the Tween is playing and you attempt to set this
		*	property to false the stop() method is invoked.
		*
		*	@param val a Boolean indicating whether the 
		*/
		override public function set playing( val:Boolean ):void
		{
			
			if( val && !playing )
			{
				start();
			}else if( !val && playing )
			{
				stop();
			}
			
			super.playing = val;
		}
		
		/**
		*	Sets whether the Tween is complete.
		*
		*	If you attempt to set this property to true
		*	the finish() method is invoked.
		*
		*	@param val a Boolean indicating whether the Tween should complete
		*/
		override public function set complete( val:Boolean ):void
		{
			if( val )
			{
				finish();
			}
			
			super.complete = val;
		}
		
		override public function set paused( val:Boolean ):void
		{
			super.paused = val;
		}
		
		/*
		*	ITweenClone implementation.
		*/
		override public function clone():ITween
		{	
			var tween:Tween = new Tween(
				target,
				TweenParameters( parameters )
			)
			
			tween.frameRate = this.frameRate;
			
			return tween;
		}
		
		public function set direction( val:int ):void
		{
			_direction = val;
		}
		
		public function get direction():int
		{
			return _direction;
		}
		
		private function toggleDirection():void
		{
			direction =
				( direction == TweenConstants.OUTBOUND ) ? TweenConstants.INBOUND : TweenConstants.OUTBOUND;
		}
		
		/*
		*	ITweenTrigger implementation.
		*/		
		public function set trigger( trigger:ITween ):void
		{
			setTrigger( trigger );
		}
		
		public function get trigger():ITween
		{
			return _triggerTarget;
		}
		
		public function hasTrigger():Boolean
		{
			return _triggerTarget != null;
		}		
		
		public function removeTrigger():void
		{
			this._triggerTarget = null;
			this._triggerType = null;
		}
		
		/**
		*	@private
		*/
		private function triggerHandler( event:Event ):void
		{
			event.target.removeEventListener( event.type, triggerHandler );
			start( true );
		}						
		
		/**
		*	@private
		*/		
		private function setTrigger( trigger:ITween = null, type:String = null ):Boolean
		{
			if( !trigger )
			{
				removeTrigger();
				return false;
			}
		
			if( !type )
			{
				type = TweenEvent.COMPLETE;
			}
			
			if( hasTrigger() )
			{
				this._triggerTarget.removeEventListener( this._triggerType, triggerHandler );
			}
			
			this._triggerTarget = trigger;
			this._triggerType = type;			
			
			this._triggerTarget.addEventListener( type, triggerHandler );
			
			return true;
		}
		
		/*
		*	Utility methods.
		*/
		
		private function initStartValues():Array
		{
			var props:Array = properties;
			
			trace("Tween::initStartValues()", "INIT START VALUES", props );
			
			var arr:Array = [];
			
			var i:int;
			var l:int = props.length;
			
			var prop:String;
			
			for( i = 0;i < l;i++ )
			{
				prop = props[ i ];
				
				if( prop == TweenConstants.INDEX_PROPERTY )
				{
					arr.push( values[ i ] );
				}else if( Object( target ).hasOwnProperty( prop ) )
				{
					arr.push( target[ prop ] );
				}
			}
			
			return arr;
		}
		
		private function setDeltas():void
		{
			this.deltas = Tween.getDeltas( startValues, endValues );
		}
		
		public function refreshDeltas():void
		{
			setDeltas();
		}
		
		/**
		*	@private
		*/
		private function startTween(
			event:Event = null,
			startTime:Number = 0,
			nowTime:Number = 0 ):void
		{
			_delayTimer = null;
			
			_startTime = startTime ? startTime : getTimer();
			_now = nowTime ? nowTime : getTimer();
			
			if( _startInt )
			{
				clearInterval( _startInt );
			}
			
			_startInt = setInterval( tween, this.refreshRate );
			
			this.playing = true;
			this.complete = false;
			this.paused = false;
			
			dispatchEvent( new TweenStartEvent( this ) );
		}
		
		public function setStartValues(
			startValues:Array = null,
			deltaTrigger:Boolean = true,
			updateOriginals:Boolean = false ):void
		{
			this.startValues = ( startValues == null ) ? initStartValues() : startValues;
			if( deltaTrigger ) setDeltas();
			if( updateOriginals ) _parameters.originalStartValues = startValues;
		}		
		
		public function setEndValues(
			endValues:Array = null,
			deltaTrigger:Boolean = true, 
			updateOriginals:Boolean = false ):void
		{
			this.endValues = endValues;
			if( deltaTrigger ) setDeltas();
			if( updateOriginals ) _parameters.originalEndValues = endValues;
		}
		
		/*
		private function set startTime( val:Number ):void
		{
			_startTime = val;
		}
		*/
		
		/*
		private function set nowTime( val:Number ):void
		{
			_now = val;
		}
		*/
		
		/*
		private function get startTime():Number
		{
			return _startTime;
		}
		*/
		
		/*
		*	Static utility methods.
		*/

		static public function getDeltas( start:Array, end:Array ):Array
		{
			var output:Array = new Array();
		
			var i:int = 0;
			var l:int = start.length;
			
			for( ;i < l;i++ )
			{
				output.push( end[ i ] - start[ i ] );
			}
			
			return output;
		}
	}
}