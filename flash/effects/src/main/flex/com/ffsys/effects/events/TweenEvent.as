package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.ITweenParameters;
	
	/**
	*	Abstract super class for all Tween events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class TweenEvent extends Event
		implements ITweenEvent {
	
		static public const START:String = "start";
		static public const STOP:String = "stop";
		static public const PAUSE:String = "pause";
		static public const RESUME:String = "resume";
		static public const UPDATE:String = "update";
		static public const END:String = "end";
		static public const COMPLETE:String = "complete";
		static public const FINISH:String = "finish";
		
		static public const COLLECTION_START:String = "collectionStart";
		static public const COLLECTION_STOP:String = "collectionStop";
		static public const COLLECTION_PAUSE:String = "collectionPause";
		static public const COLLECTION_RESUME:String = "collectionResume";
		static public const COLLECTION_COMPLETE:String = "collectionComplete";
		static public const COLLECTION_FINISH:String = "collectionFinish";
		
		//private var _parameters:TweenParametersDecorator;
		
		private var _tween:ITween;
		private var _parameters:ITweenParameters;
		
		public function TweenEvent( type:String, tween:ITween = null )
		{
			super( type );
			_tween = tween;
			_parameters = tween.parameters as ITweenParameters;
		}
		
		/**
		*	Gets the underlying ITween that dispatched this event.
		*
		*	@return the ITween that dispatched this event
		*/
		public function get tween():ITween
		{
			return _tween;
		}
		
		/**
		*	Gets the underlying target Object that is being tweened.
		*/
		public function get tweenTarget():Object
		{
			if( tween )
			{
				return tween.target;
			}
			
			return null;
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
		
		public function applyValues( values:Array, target:Object = null ):void
		{
			_parameters.applyValues( values, target );
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
		
		override public function clone():Event
		{
			return new TweenEvent( this.type, this.tween );
		}
	}
}