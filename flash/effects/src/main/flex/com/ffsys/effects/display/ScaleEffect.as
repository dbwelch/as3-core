package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Represents an effect for scaling in both directions
	*	simultaneously.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class ScaleEffect extends AbstractDisplayObjectEffect {
		
		public function ScaleEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			scaleX:NumericRange = null,
			scaleY:NumericRange = null,
			easing:Function = null )
		{
			super(
				displayObject,
				[ TweenConstants.SCALE_X_PROPERTY, TweenConstants.SCALE_Y_PROPERTY ]
			);
			
			if( !scaleX )
			{
				scaleX = new NumericRange( 0, 1 );
			}
			
			if( !scaleY )
			{
				scaleY = new NumericRange( 0, 1 );
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
