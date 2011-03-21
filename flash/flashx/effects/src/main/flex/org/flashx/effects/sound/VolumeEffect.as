package org.flashx.effects.sound {
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import org.flashx.effects.tween.TweenEvent;
	import org.flashx.effects.tween.TweenConstants;
	
	import org.flashx.utils.number.NumericRange;
	
	/**
	*	Effect for changing the volume of a SoundTransform instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class VolumeEffect extends AbstractSoundEffect {
		
		public function VolumeEffect(
			channel:SoundChannel,
			transform:SoundTransform,
			duration:Number = 30,
			volume:NumericRange = null,
			easing:Function = null )
		{
			super( channel, [ TweenConstants.VOLUME_PROPERTY ] );
			
			if( !volume )
			{
				//let's not hurt people's ear drums - not all the way
				volume = new NumericRange( 0, .75 );
			}
			
			configure(
				transform,
				volume.start,
				volume.end,
				duration,
				easing );
		}
	}
}