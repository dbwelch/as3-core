package com.ffsys.effects.array {
	
	import com.ffsys.effects.tween.Tween;
	import com.ffsys.effects.tween.TweenParameters;
	
	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	Tweens between an Array of start values
	*	and an Array of end values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class ArrayEffect extends AbstractArrayEffect {
		
		public function ArrayEffect(
			start:Array,
			end:Array,
			duration:Number = 1,
			easing:Object = null )
		{
			var targetArray:Array = start.slice();
			var propertiesArray:Array = ArrayUtils.fill( 1, start.length, true );
			
			super( targetArray, propertiesArray );
			
			/*
			trace( "ArrayEffect target : " + targetArray );
			trace( "ArrayEffect properties (indices) : " + propertiesArray );
			trace( "ArrayEffect start : " + start );
			trace( "ArrayEffect end : " + end );
			*/
			
			/*
			var parameters:TweenParameters =
				new TweenParameters(
					propertiesArray,
					easing,
					end
				);
			
			super( targetArray, parameters );
			*/
			
			configure(
				targetArray,
				start,
				end,
				duration,
				easing );
			
			if( !start || !end || ( start.length != end.length ) )
			{
				throw new Error(
					"ArrayEffect start/end Arrays should be non-null and of " +
					"equal length." );
			}			
		}
		
	}
	
}
