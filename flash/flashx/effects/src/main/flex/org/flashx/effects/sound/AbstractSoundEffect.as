package org.flashx.effects.sound {
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import org.flashx.effects.AbstractObjectEffect;
	import org.flashx.effects.easing.Linear;
	
	import org.flashx.effects.tween.TweenEvent;	
	
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
		
		/**
		* 	Creates an <code>AbstractSoundEffect</code> instance.
		*/
		public function AbstractSoundEffect(
			channel:SoundChannel = null,
			properties:Array = null )
		{
			super( properties );
			this.channel = channel;
		}
		
		/**
		*	The sound channel this effect is operating on.
		*/
		public function get channel():SoundChannel
		{
			return _channel;
		}
		
		public function set channel( value:SoundChannel ):void
		{
			_channel = value;
		}
		
		/**
		* 	Modifies the default easing to a linear easing equation.
		*/
		override public function getDefaultEasing():Function
		{
			return Linear.easeNone;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function dispatchUpdateEvent( event:TweenEvent ):void
		{
			applyTransform();
			dispatchEvent( event );
		}
		
		/**
		* 	Applies the sound transform.
		*/
		protected function applyTransform():void
		{
			_channel.soundTransform = ( this.target as SoundTransform );
		}
	}
}