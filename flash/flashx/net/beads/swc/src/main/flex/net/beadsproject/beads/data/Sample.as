package net.beadsproject.beads.data
{
	
	/**
	* 
	*/
	public class Sample extends Object
	{
		
		private var _audioFormat:SampleAudioFormat;
		
		/**
		* 	Creates a <code>Sample</code> instance.
		* 
		* 	@param length The length of the
		* 	sample in milliseconds.
		* 
		* 	
		*/
		public function Sample( length:Number, format:SampleAudioFormat = null )
		{
			if( format == null )
			{
				//TODO
				//format = new SampleAudioFormat(44100, 16, 2), length)
			}
			
			super();
			
			/*
			
			nChannels = audioFormat.channels;
			current = new float[nChannels];
			next = new float[nChannels];
			nFrames = (long) msToSamples(length);
			if (bufferingRegime.storeInNativeBitDepth)
			{
				sampleData = new byte[2*nChannels*(int)nFrames]; //16-bit			
			}
			else
			{
				f_sampleData = new float[nChannels][(int)nFrames];			
			}
			this.length = 1000f * nFrames / audioFormat.sampleRate;			
			
			*/
		}
		
		public function get audioFormat():SampleAudioFormat
		{
			return _audioFormat;
		}
		
		public function set audioFormat( value:SampleAudioFormat ):void
		{
			_audioFormat = value;
		}
	}
}