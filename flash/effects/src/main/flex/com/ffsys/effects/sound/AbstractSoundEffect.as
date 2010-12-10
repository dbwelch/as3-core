package com.ffsys.effects.sound {
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import com.ffsys.effects.AbstractObjectEffect;
	import com.ffsys.effects.easing.Linear;
	
	import com.ffsys.effects.tween.TweenEvent;	
	
	/**
	*	Abstract base class for sound effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class AbstractSoundEffect extends AbstractObjectEffect {
	
		private var _channel:SoundChannel;
		
		public function AbstractSoundEffect( channel:SoundChannel, properties:Array )
		{
			super( properties );
			_channel = channel;
		}
		
		override public function getDefaultEasing():Function
		{
			return Linear.easeNone;
		}
		
		override public function dispatchUpdateEvent( event:TweenEvent ):void
		{
			applyTransform();
			dispatchEvent( event );
		}
			
		protected function applyTransform():void
		{
			_channel.soundTransform = ( this.target as SoundTransform );
		}		
		
	}
	
}
