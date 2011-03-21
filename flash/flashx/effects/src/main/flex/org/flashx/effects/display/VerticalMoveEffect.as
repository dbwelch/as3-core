package org.flashx.effects.display {
	
	import flash.display.DisplayObject;
	
	import org.flashx.effects.tween.TweenConstants;
	
	import org.flashx.utils.number.NumericRange;
	
	/**
	*	Represents a vertical movement effect (y property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class VerticalMoveEffect extends AbstractDisplayObjectEffect {
		
		public function VerticalMoveEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			y:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.Y_PROPERTY ] );
			
			if( !y )
			{
				y = new NumericRange( 0, 100 );
			}
			
			configure(
				displayObject,
				y.start,
				y.end,
				duration,
				easing );
		}		
		
	}
	
}
