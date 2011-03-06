package
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.utils.*;
	
	import net.beadsproject.beads.data.*;
	import net.beadsproject.beads.data.buffers.SineBuffer;

	public class BeadsProject extends Sprite
	{
		private var _sound:Sound;
		private var _channel:SoundChannel;
		
		private var toggle:Boolean;
		
		private var _sampleRate:Number = 8192;
		
		/**
		* 	Creates a <code>BeadsProject</code> instance.
		*/
		public function BeadsProject()
		{
			super();
			_sound = new Sound();
			_sound.addEventListener(
				SampleDataEvent.SAMPLE_DATA, sineWaveGenerator );
			
			//addEventListener( Event.ENTER_FRAME, enterFrame );
			
			_sound.play();
		}
		
		private function enterFrame( event:Event ):void
		{
			if( _channel )
			{
				_channel.stop();
			}
			
			_channel = _sound.play();
		}
		
		private function sineWaveGenerator( event:SampleDataEvent ):void
		{
			var l:Number;
			var r:Number;
			
			//trace("BeadsProject::sineWaveGenerator()", event.position, DefaultBuffers.SINE );
			
			//write twice for both channels
			//new SineBuffer().generateBuffer( 4096 ).write( event.data );
			
			//DefaultBuffers.SINE.write( event.data );
			
			
			//latency: ((SampleDataEvent.position/44.1) - SoundChannelObject.position)
			
			SineBuffer.write( event.data, event.position );
			
			trace("BeadsProject::sineWaveGenerator()", _sampleRate, event.position );			
			
			for ( var c:int=0; c < _sampleRate; c++ )
			{
				l = 0;
				r = 0;
				
				//if( !toggle )
				//{
					l = Math.sin((Number( c + event.position ) / Math.PI / 2 )) * 0.125;
					r = Math.sin((Number( c + event.position ) / Math.PI / 2 )) * 0.125;
				//}
				
				
				//event.data.writeFloat(l);
				//event.data.writeFloat(r);
			}
			//_sampleRate -= 32;
			
			toggle = !toggle;
		}
	}
}