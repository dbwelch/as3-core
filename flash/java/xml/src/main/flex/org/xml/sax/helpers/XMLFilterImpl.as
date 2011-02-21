package org.xml.sax.helpers
{
	import org.xml.sax.*;
	
	/**
	* 	
	*/
	public class XMLFilterImpl extends Object
		implements	ContentHandler,
					DTDHandler,
					EntityResolver,
					ErrorHandler,
					XMLFilter
	{
		/**
		* 	Creates an <code>XMLFilterImpl</code> instance.
		*/
		public function XMLFilterImpl()
		{
			super();
		}	
	}
}