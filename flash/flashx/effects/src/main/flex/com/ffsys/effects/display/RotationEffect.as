package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Performs a rotation on a given DisplayObject.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class RotationEffect extends AbstractDisplayObjectEffect {
		
		public function RotationEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			rotation:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.ROTATION_PROPERTY ] );
			
			if( !rotation )
			{
				rotation = new NumericRange( 0, 360 );
			}
			
			configure(
				displayObject,
				rotation.start,
				rotation.end,
				duration,
				easing );
		}
		
		override public function clone():ITween
		{
			//var cloned:RotationEffect = Object( RotationEffect ).constructor.apply( RotationEffect, _constructorArguments );
			
			//trace( "CLONED ROTATION EFFECT : " + cloned );
			
			return this;
		}		
		
	}
	
}
