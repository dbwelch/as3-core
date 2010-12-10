package com.ffsys.effects.tween {

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
	public class TweenEvent extends Event {
	
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
		
		private var _tween:ITween;
		
		public function TweenEvent( type:String, tween:ITween = null )
		{
			super( type );
			_tween = tween;
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
		
		override public function clone():Event
		{
			return new TweenEvent( this.type, this.tween );
		}
	}
}