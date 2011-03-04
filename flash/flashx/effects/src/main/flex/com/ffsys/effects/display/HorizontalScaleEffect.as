package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.utils.number.NumericRange;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	/**
	*	Represents a horizontal scale effect (scaleX property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class HorizontalScaleEffect extends AbstractDisplayObjectEffect {
		
		public function HorizontalScaleEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			scaleX:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.SCALE_X_PROPERTY ] );
			
			if( !scaleX )
			{
				scaleX = new NumericRange( 0, 1 );
			}
			
			configure(
				displayObject,
				scaleX.start,
				scaleX.end,
				duration,
				easing );
		}		
		
	}
	
}
