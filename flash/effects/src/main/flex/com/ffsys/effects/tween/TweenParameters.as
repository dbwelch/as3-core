package com.ffsys.effects.tween {

	import com.ffsys.effects.events.TweenUpdateEvent;
	
	import com.ffsys.effects.IEffect;
	
	/**
	*	Decorates common methods for accessing the parameters
	*	associated with a tween.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public class TweenParameters extends Object
		implements ITweenParameters {
		
		private var _values:Array;
		private var _properties:Array;
		private var _easing:Array;
		private var _endValues:Array;
		private var _duration:Number;
		private var _delay:Number;
		private var _startValues:Array;
		private var _loops:int;
		private var _originalEndValues:Array;
		private var _originalStartValues:Array;
		private var _refreshRate:int;
		private var _frameRate:int;
		private var _proxy:ITweenParameters;
		private var _tween:ITween;
		
		public function TweenParameters(
			properties:Object = null,
			easing:Object = null,
			endValues:Array = null,
			duration:Number = 1,
			delay:Number = 0,
			startValues:Array = null,
			loops:Number = 0,
			proxy:ITweenParameters = null )
		{
			super();
			
			
			//TODO: re-implement outside the constructor
			
			/*
			if( properties is Array )
			{
				properties = ( properties as Array );
			}else if( properties is String )
			{
				properties = [ properties ];
			}else{
				throw new IllegalOperationError(
					"The properties parameter must be a String or Array of Strings." );
			}
			
			if( easing is Array )
			{
				easing = ( easing as Array );
			}else if( easing is Function )
			{
				easing = ArrayUtils.fill( easing, properties.length );
			}else{
				throw new IllegalOperationError(
					"The easing parameter must be a Function or Array of Functions." );
			}
			*/
			
			this.properties = properties as Array;
			this.easing = easing as Array;
			this.endValues = endValues;
			this.duration = duration;
			this.delay = delay;
			this.startValues = startValues;
			this.loops = loops;			
			
			this.proxy = proxy;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get tween():ITween
		{
			return _tween;
		}		
		
		public function set tween( val:ITween ):void
		{
			_tween = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get proxy():ITweenParameters
		{
			return _proxy;
		}		
		
		public function set proxy( val:ITweenParameters ):void
		{
			_proxy = val;
			
			if( _proxy is ITween )
			{
				this.tween = ( val as ITween );
			}
		}
		
		/*
		*	ITweenSpeed implementation.
		*/
		public function get refreshRate():int
		{
			if( !_frameRate )
			{
				_frameRate = TweenConstants.DEFAULT_FRAME_RATE;
				_refreshRate = Math.round( 1000 / _frameRate );
			}
			
			return _refreshRate;
		}		
		
		public function set refreshRate( val:int ):void
		{
			_refreshRate = val;
			_frameRate = Math.round( 1000 / val );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get frameRate():int
		{
			if( !_frameRate )
			{
				_frameRate = TweenConstants.DEFAULT_FRAME_RATE;
			}			
			
			return _frameRate;
		}		
		
		public function set frameRate( val:int ):void
		{
			_frameRate = val;
			_refreshRate = Math.round( 1000 / val );
		}		
		
		
		/*
		*	ITweenParameters implementation.
		*/	
		
		public function get values():Array
		{
			return _values;
		}
			
		public function set properties( val:Array ):void
		{
			if( _proxy )
			{
				_proxy.properties = val;
			}
		
			_properties = val;
		}
		
		public function get properties():Array
		{
			if( _proxy )
			{
				return _proxy.properties;
			}		
		
			return _properties;
		}
		
		public function set easing( val:Array ):void
		{
			if( _proxy )
			{
				_proxy.easing = val;
			}		
		
			_easing = val;
		}
		
		public function get easing():Array
		{
			if( _proxy )
			{
				return _proxy.easing;
			}		
		
			return _easing;
		}
		
		public function set endValues( val:Array ):void
		{
			if( _proxy )
			{
				_proxy.endValues = val;
			}
		
			_endValues = val;
			
			if( !_originalEndValues && val )
			{
				_originalEndValues = val.slice();
			}
		}
		
		public function get endValues():Array
		{
			if( _proxy )
			{
				return _proxy.endValues;
			}
					
			return _endValues;
		}
		
		public function set duration( val:Number ):void
		{
		
			if( _proxy )
			{
				_proxy.duration = val;
			}		
		
			_duration = val;
		}
		
		public function get duration():Number
		{
			if( _proxy )
			{
				return _proxy.duration;
			}		
		
			return _duration;
		}
		
		public function set delay( val:Number ):void
		{
			if( _proxy )
			{
				_proxy.delay = val;
			}			
		
			_delay = val;
		}
		
		public function get delay():Number
		{
			if( _proxy )
			{
				return _proxy.delay;
			}
			
			return _delay;
		}
		
		public function set startValues( val:Array ):void
		{
		
			if( _proxy )
			{
				_proxy.startValues = val;
			}	
					
			_startValues = val;
			
			//trace( "SET START VALUES : " + val );
			
			//if( !_originalStartValues && val )
			
			if( !_originalStartValues && val )
			{
				//trace( "Set original start values : " + val );
				_originalStartValues = val.slice();
			}
		}
		
		public function get startValues():Array
		{
			if( _proxy )
			{
				return _proxy.startValues;
			}
		
			return _startValues;
		}
		
		public function set loops( val:int ):void
		{
			if( _proxy )
			{
				_proxy.loops = val;
			}		
		
			_loops = val;
		}
		
		public function get loops():int
		{
			if( _proxy )
			{
				return _proxy.loops;
			}
					
			return _loops;
		}
		
		public function set originalStartValues( val:Array ):void
		{
			_originalStartValues = val;
		}		
		
		public function get originalStartValues():Array
		{
			if( _proxy )
			{
				return _proxy.originalStartValues;
			}
		
			return _originalStartValues;
		}
		
		public function set originalEndValues( val:Array ):void
		{
			_originalEndValues = val;
		}

		public function get originalEndValues():Array
		{
			if( _proxy )
			{
				return _proxy.originalEndValues;
			}
			
			return _originalEndValues;
		}
		
		public function getParameters():Object
		{
			var props:Object = new Object();
			props.properties = this.properties;
			props.values = this.values;
			props.easing = this.easing;
			props.startValues = this.startValues;
			props.endValues = this.endValues;
			props.duration = this.duration;
			props.delay = this.delay;
			props.loops = this.loops;
			props.originalStartValues = this.originalStartValues;
			props.originalEndValues = this.originalEndValues;
			return props;
		}
		
		public function applyOriginalStartValues():void
		{
			if( tween is ITweenCollection )
			{
				var tweens:Array = ( tween as ITweenCollection ).getAllTweens();
				
				var i:int = 0;
				var l:int = tweens.length;
				
				var child:Tween;
				
				for( ;i < l;i++ )
				{
					child = tweens[ i ];
					child.applyOriginalStartValues();
				}
			}else if( tween is Tween )
			{
				applyValues( tween.originalStartValues, tween.target );
			}
		}
		
		public function applyOriginalEndValues():void
		{
			if( tween is ITweenCollection )
			{
				var tweens:Array = ( tween as ITweenCollection ).getAllTweens();
				
				var i:int = 0;
				var l:int = tweens.length;
				
				var child:Tween;
				
				for( ;i < l;i++ )
				{
					child = tweens[ i ];
					child.applyOriginalEndValues();
				}
			}else if( tween is Tween )
			{
				applyValues( tween.originalEndValues, tween.target );
			}			
		}		
		
		public function applyStartValues():void
		{
			if( tween is ITweenCollection )
			{
				var tweens:Array = ( tween as ITweenCollection ).getAllTweens();
				
				var i:int = 0;
				var l:int = tweens.length;
				
				var child:Tween;
				
				for( ;i < l;i++ )
				{
					child = tweens[ i ];
					child.applyStartValues();
				}
			}else if( tween is Tween )
			{
				applyValues( tween.startValues, tween.target );
			}
		}
		
		public function applyEndValues():void
		{
			if( tween is ITweenCollection )
			{
				var tweens:Array = ( tween as ITweenCollection ).getAllTweens();
				
				var i:int = 0;
				var l:int = tweens.length;
				
				var child:Tween;
				
				for( ;i < l;i++ )
				{
					child = tweens[ i ];
					child.applyEndValues();
				}
			}else if( tween is Tween )
			{
				applyValues( tween.endValues, tween.target );
			}			
		}		
		
		public function applyValues( values:Array, target:Object = null ):void
		{
			if( !( tween is Tween ) )
			{
				throw new Error( "Cannot invoke applyValues on a non-tween instance : " + tween );
			}
		
			if( tween && !target )
			{
				target = tween.target;
			}
			
			/*
			if( target is Tween )
			{
				target = target.target;
			}
			*/
			
			/*
			trace( "TweenParameters applyValues : " + tween );
			trace( "TweenParameters applyValues : " + target );
			trace( "TweenParameters applyValues : " + values );
			trace( "TweenParameters applyValues : " + properties );
			*/
			
			_values = values;
			
			if( target && values )
			{		
				var i:int = 0;
				var l:int = values.length;
				
				var prop:String;
				var value:Object;
				
				for( ;i < l;i++ )
				{
					prop = properties[ i ];
					value = values[ i ];
					
					if( tween && ( tween is Tween ) )
					{
						
						//trace( "Should apply tween value : " + Tween( tween ).updater.shouldApplyTweenValue( prop, value ) );
						
						if( Tween( tween ).updater.shouldApplyTweenValue( prop, value ) )
						{
							Tween( tween ).updater.applyTweenValue( target, prop, value );
						}
						
						/*
						else{
							target[ prop ] = value
						}
						*/
						
					}else{
						target[ prop ] = value;
					}
					
					/*
					trace( "Value applied to target : " + target );
					trace( "Value applied to target (property) : " + prop );
					trace( "Value applied to target (value) : " + value );
					*/
					
				}
				
				//we need to have the ITween dispatch an update event
				//so that effects (such as filters) that listen for this event
				//in order to update the display need to be informed the properties
				//have been changed
				var dispatcher:ITween = tween;
				
				if( tween.parent && !( tween.parent is IEffect ) )
				{
					dispatcher = tween.parent;
				}
				
				dispatcher.dispatchEvent(
					new TweenUpdateEvent( dispatcher )
				);
			}
		}	
	}
}