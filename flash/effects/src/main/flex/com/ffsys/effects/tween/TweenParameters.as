package com.ffsys.effects.tween {
	
	import flash.errors.IllegalOperationError;
	
	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	Represents a collection of parameters that describe
	*	a tween.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public class TweenParameters extends AbstractTween {
		
		public function TweenParameters(
			properties:Object = null,
			easing:Object = null,
			endValues:Array = null,
			duration:Number = 1,
			delay:Number = 0,
			startValues:Array = null,
			loops:Number = 0 )
		{
			super();
			
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
			
			this.properties = properties as Array;
			this.easing = easing as Array;
			this.endValues = endValues;
			this.duration = duration;
			this.delay = delay;
			this.startValues = startValues;
			this.loops = loops;
		}
		
		internal function set tween( val:ITween ):void
		{
			TweenParametersDecorator( _parametersDecorator ).tween = val;
		}
		
		internal function get tween():ITween
		{
			return TweenParametersDecorator( _parametersDecorator ).tween;
		}
		
	}
	
}