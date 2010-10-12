package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import com.ffsys.utils.number.NumericRange;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	/**
	*	Represents a movement both vertically and diagonally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class MoveEffect extends AbstractDisplayObjectEffect {
		
		public function MoveEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			x:NumericRange = null,
			y:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.X_PROPERTY, TweenConstants.Y_PROPERTY ] );
			
			if( !x )
			{
				x = new NumericRange( 0, 100 );
			}
			
			if( !y )
			{
				y = new NumericRange( 0, 100 );
			}			
		
			configure(
				displayObject,
				[ x.start, y.start ],
				[ x.end, y.end ],
				duration,
				easing );
		}		
		
	}
	
}
