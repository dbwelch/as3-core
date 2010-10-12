package com.ffsys.effects {

	import com.ffsys.utils.array.ArrayUtils;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.Tween;
	import com.ffsys.effects.tween.TweenConstants;
	import com.ffsys.effects.tween.TweenParameters;
	import com.ffsys.effects.tween.TweenParametersDecorator;
	
	/**
	*	Abstract super class for Effect sub-sets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class AbstractObjectEffect extends AbstractEffect {
		
		protected var _properties:Array;
		
		protected var _tween:ITween;
		
		public function AbstractObjectEffect( properties:Array )
		{
			super();
			
			if( properties.length == 0 )
			{
				throw new Error(
					"The properties Array for an AbstractObjectEffect constructor " +
					"must not be empty" );
			}
			
			_properties = properties;
		}
		
		public function get tween():ITween
		{
			return _tween;
		}
		
		public function get property():String
		{
			return _properties[ 0 ];
		}
		
		override public function get properties():Array
		{
			return _properties;
		}
		
		protected function configure(
			target:Object,
			start:Object = 0,
			end:Object = 1,
			duration:Number = 1,
			easing:Object = null ):ITween
		{
			
			if( !easing )
			{
				easing = getDefaultEasing();
			}
			
			var easingValues:Array;
			if( !( easing is Array ) )
			{
				easingValues = ArrayUtils.fill( easing, properties.length );
			}else{
				easingValues = easing as Array;
			}
			
			var endValues:Array;
			if( !( end is Array ) )
			{
				endValues = ArrayUtils.fill( end, properties.length );
			}else{
				endValues = end as Array;
			}
			
			var startValues:Array;
			if( !( start is Array ) )
			{
				startValues = ArrayUtils.fill( start, properties.length );
			}else{
				startValues = start as Array;
			}
			
			var parameters:TweenParameters = new TweenParameters(
				this.properties,
				easingValues,
				endValues );
			
			parameters.duration = duration;
			parameters.startValues = startValues;
			
			var tween:ITween = new Tween( target, parameters );
			
			addTween( tween );
			
			//TweenParametersDecorator( _parametersDecorator ).proxy = tween.parameters;
			
			_parametersDecorator = tween.parameters;
			
			_tween = tween;
			
			return tween;
		}
	}
}