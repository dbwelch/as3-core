package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Represents a vertical scale effect (scaleY property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class VerticalScaleEffect extends AbstractDisplayObjectEffect {
		
		public function VerticalScaleEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			scaleY:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.SCALE_Y_PROPERTY ] );
			
			if( !scaleY )
			{
				scaleY = new NumericRange( 0, 1 );
			}
			
			configure(
				displayObject,
				scaleY.start,
				scaleY.end,
				duration,
				easing );
		}					
		
	}
	
}
