package org.xml.sax.helpers
{
	import org.xml.sax.*;

	/**
	* 
	*/
	public class DefaultHandler extends Object
		implements 	ContentHandler,
					DTDHandler,
					EntityResolver,
					ErrorHandler
	{
		/**
		* 	Creates a <code>DefaultHandler</code> instance.
		*/
		public function DefaultHandler()
		{
			super();
		}
	}
}