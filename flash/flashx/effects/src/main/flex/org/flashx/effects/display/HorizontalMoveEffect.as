package org.flashx.effects.display {
	
	import flash.display.DisplayObject;
	import org.flashx.utils.number.NumericRange;
	
	import org.flashx.effects.tween.TweenConstants;
	
	/**
	*	Represents a horizontal movement effect (x property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class HorizontalMoveEffect extends AbstractDisplayObjectEffect {
		
		public function HorizontalMoveEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			x:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.X_PROPERTY ] );
			
			if( !x )
			{
				x = new NumericRange( 0, 100 );
			}
			
			configure(
				displayObject,
				x.start,
				x.end,
				duration,
				easing );
		}		
		
	}
	
}
