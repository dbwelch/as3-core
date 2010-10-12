package com.ffsys.effects.filters {
	
	import flash.display.DisplayObject;
	
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Represents Blur effect.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class BlurEffect extends AbstractFilterEffect {
		
		public function BlurEffect(
			displayObject:DisplayObject,
			filter:BlurFilter,
			duration:Number = 1,
			blurX:NumericRange = null,
			blurY:NumericRange = null,
			easing:Function = null )
		{
			super(
				displayObject,
				filter,
				[
					TweenConstants.BLUR_X_PROPERTY,
					TweenConstants.BLUR_Y_PROPERTY
				]
			);
				
			if( !blurX )
			{
				blurX = new NumericRange( 15, 0 );
			}
			
			if( !blurY )
			{
				blurY = new NumericRange( 15, 0 );
			}			
		
			configure(
				filter,
				[ blurX.start, blurY.start ],
				[ blurX.end, blurY.end ],
				duration,
				easing );
		}
		
		override public function clone():ITween
		{
			return this;
		}
	}
}