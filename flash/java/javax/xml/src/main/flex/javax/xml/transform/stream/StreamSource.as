package javax.xml.transform.stream
{
	import javax.xml.transform.Source;
	
	/**
	* 	Acts as an holder for a transformation Source
	* 	in the form of a stream of XML markup.
	* 
	* 	<strong>Note:</strong> Due to their internal use of either a Reader
	* 	or InputStream instance, StreamSource instances
	* 	may only be used once.
	*/
	public class StreamSource extends Object
		implements Source
	{
		/**
		* 	Creates a <code>StreamSource</code> instance.
		*/
		public function StreamSource()
		{
			super();
		}
	}
}