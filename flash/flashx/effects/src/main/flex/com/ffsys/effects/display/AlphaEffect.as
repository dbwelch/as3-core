package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.utils.number.NumericRange;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.TweenConstants;
	
	/**
	*	Performs an alpha fade on a given DisplayObject.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public class AlphaEffect extends AbstractDisplayObjectEffect {
		
		public function AlphaEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			alpha:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.ALPHA_PROPERTY ] );
			
			if( !alpha )
			{
				alpha = new NumericRange( 0, 1 );
			}
			
			configure(
				displayObject,
				alpha.start,
				alpha.end,
				duration,
				easing );
		}
	}
}