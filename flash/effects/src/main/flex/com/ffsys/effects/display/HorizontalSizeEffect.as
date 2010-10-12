package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.utils.number.NumericRange;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	/**
	*	Represents a horizontal size effect (width property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class HorizontalSizeEffect extends AbstractDisplayObjectEffect {
		
		public function HorizontalSizeEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			width:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.WIDTH_PROPERTY ] );
			
			if( !width )
			{
				width = new NumericRange( 0, displayObject.width );
			}
			
			configure(
				displayObject,
				width.start,
				width.end,
				duration,
				easing );
		}		
		
	}
	
}
