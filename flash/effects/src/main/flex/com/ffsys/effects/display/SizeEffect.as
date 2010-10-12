package com.ffsys.effects.display {
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Represents a size both vertically and diagonally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class SizeEffect extends AbstractDisplayObjectEffect {
		
		public function SizeEffect(
			displayObject:DisplayObject,
			duration:Number = 1,
			width:NumericRange = null,
			height:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.WIDTH_PROPERTY, TweenConstants.HEIGHT_PROPERTY ] );
			
			if( !width )
			{
				width = new NumericRange( 0, displayObject.width );
			}
			
			if( !height )
			{
				height = new NumericRange( 0, displayObject.height );
			}			
		
			configure(
				displayObject,
				[ width.start, height.start ],
				[ width.end, height.end ],
				duration,
				easing );
		}
		
		override public function clone():ITween
		{
			//var cloned:SizeEffect = Object( SizeEffect ).constructor.apply( SizeEffect, _constructorArguments );
			
			//trace( "CLONED SIZE EFFECT : " + cloned );
			
			return this;
		}		
		
	}
	
}
