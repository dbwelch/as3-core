package net.beadsproject.beads.data
{
	
	/**
	* 	Represents the audio format for a sample.
	*/
	public class SampleAudioFormat extends Object
	{
		public var channels:uint = 2;
		public var bitDepth:uint = 16;
		public var sampleRate:Number = 44100;
		public var bigEndian:Boolean = true;
		public var signed:Boolean = true;
		
		/**
		* 	Creates a <code>SampleAudioFormat</code> instance.
		*/
		public function SampleAudioFormat(
			sampleRate:Number,
			bitDepth:uint = 16,
			channels:uint = 2,
			signed:Boolean = true,
			bigEndian:Boolean = true )
		{
			super();
			this.sampleRate = sampleRate;
			this.bitDepth = bitDepth;
			this.signed = signed;
			this.bigEndian = bigEndian;
			this.channels = channels;
		}
	}
}