package com.ffsys.effects.display {
	
	import flash.display.MovieClip;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.effects.tween.ITweenUpdater;
	import com.ffsys.effects.tween.ITweenValueFormatter;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Controls playback of a MovieClip timeline.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class TimelineEffect extends AbstractDisplayObjectEffect
		implements 	ITweenValueFormatter,
					ITweenUpdater {
		
		public function TimelineEffect(
			displayObject:MovieClip,
			duration:Number = 1,
			frames:NumericRange = null,
			easing:Function = null )
		{
			super( displayObject, [ TweenConstants.CURRENT_FRAME_PROPERTY ] );
			
			if( !frames )
			{
				frames = new NumericRange(
					0, 
					displayObject.totalFrames );
			}
			
			var tween:ITween = configure(
				displayObject,
				frames.start,
				frames.end,
				duration,
				easing );
		
			tween.updater = this;
			tween.formatter = this;
		}
		
		public function set currentFrame( val:int ):void
		{
			MovieClip( this.displayObject ).gotoAndStop( val );
		}
		
		public function get currentFrame():int
		{
			return MovieClip( this.displayObject ).currentFrame;
		}
		
		/*
		*	ITweenValueFormatter implementation.
		*/
		public function formatTweenValue( value:Number ):Number
		{
			return Math.floor( value );
		}		
		
		/*
		*	ITweenUpdater implementation.
		*/
		public function shouldApplyTweenValues( properties:Array, values:Array ):Boolean
		{
			return true;
		}
		
		public function shouldApplyTweenValue( property:String, value:Object ):Boolean
		{
			return true;
		}
				
		public function applyTweenValue( target:Object, property:String, value:Object ):void
		{
			this.currentFrame = ( value as int );
		}		
		
	}
	
}
