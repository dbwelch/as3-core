package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Represents a vertical size effect (height property).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class VerticalSizeEffect extends AbstractDisplayObjectEffect {
		
		public function VerticalSizeEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			height:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.HEIGHT_PROPERTY ] );
			
			if( !height )
			{
				height = new NumericRange( 0, displayObject.height );
			}			
			
			configure(
				displayObject,
				height.start,
				height.end,
				duration,
				easing );
		}	
		
	}
	
}
