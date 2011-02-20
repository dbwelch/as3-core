package java.nio.charset.iso
{
	import java.nio.charset.Charset;	
	
	/**
	* 	Represents the <code>iso-8859-1</code> character set.
	*/
	public class ISO_8859_1_Charset extends Charset
	{	
		/**
		* 	Creates an <code>ISO_8859_1_Charset</code> instance.
		*/
		public function ISO_8859_1_Charset()
		{
			super(
				"iso-8859-1",
				"cp819",
				"csISO",
				"Latin1",
				"ibm819",
				"iso_8859-1",
				"iso_8859-1:1987",
				"iso8859-1",
				"iso-ir-100",
				"l1",
				"latin1" );
		}
	}
}