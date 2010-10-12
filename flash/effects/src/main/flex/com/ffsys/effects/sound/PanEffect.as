package com.ffsys.effects.sound {
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import com.ffsys.effects.events.TweenEvent;
	import com.ffsys.effects.tween.TweenConstants;
	
	import com.ffsys.utils.number.NumericRange;
	
	/**
	*	Effect for changing the pan of a SoundTransform instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class PanEffect extends AbstractSoundEffect {
		
		public function PanEffect(
			channel:SoundChannel,
			transform:SoundTransform,
			duration:Number = 5,
			pan:NumericRange = null,
			easing:Function = null )
		{
			super( channel, [ TweenConstants.PAN_PROPERTY ] );
			
			if( !pan )
			{
				pan = new NumericRange( -1, 1 );
			}
			
			configure(
				transform,
				pan.start,
				pan.end,
				duration,
				easing );
			
		}		
		
	}
	
}
