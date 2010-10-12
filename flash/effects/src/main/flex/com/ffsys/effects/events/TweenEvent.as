package com.ffsys.effects.events {

	import flash.events.Event;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.ITweenParameters;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
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
		
		//private var _parametersDecorator:TweenParametersDecorator;
		
		private var _tween:ITween;
		private var _parametersDecorator:ITweenParameters;
		
		public function TweenEvent( type:String, tween:ITween = null )
		{
			super( type );
			_tween = tween;
			_parametersDecorator = tween.parameters as ITweenParameters;
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
		
		public function applyValues( values:Array, target:Object = null ):void
		{
			_parametersDecorator.applyValues( values, target );
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
		
		override public function clone():Event
		{
			return new TweenEvent( this.type, this.tween );
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			output.push( tween );
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
			return getObjectString( true );
		}
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}