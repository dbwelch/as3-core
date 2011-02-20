package net.beadsproject.beads.data
{
	
	import net.beadsproject.beads.data.buffers.SineBuffer;
	

	public class DefaultBuffers extends Object
	{
		// A collection of default buffers, initialised for your convenience.
		public static const SINE:Buffer = new SineBuffer().getDefault();
	}
}