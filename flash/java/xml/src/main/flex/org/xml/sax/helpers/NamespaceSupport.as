package org.xml.sax.helpers
{
	
	/**
	* 	Encapsulate Namespace logic for use by applications
	* 	using SAX, or internally by SAX drivers.
	* 
	* 	<p>This class encapsulates the logic of Namespace
	* 	processing: it tracks the declarations currently in
	* 	force for each context and automatically processes
	* 	qualified XML names into their Namespace parts; it
	* 	can also be used in reverse for generating XML qnames
	* 	from Namespaces.</p>
	* 
	* 	<p>Namespace support objects are reusable, but the
	* 	reset method must be invoked between each session.</p>
	* 
	* 	<pre>String parts[] = new String[3];
	*   NamespaceSupport support = new NamespaceSupport();
	*   
	*   support.pushContext();
	*   support.declarePrefix("", "http://www.w3.org/1999/xhtml");
	*   support.declarePrefix("dc", "http://www.purl.org/dc#");
	*   
	*   parts = support.processName("p", parts, false);
	*   System.out.println("Namespace URI: " + parts[0]);
	*   System.out.println("Local name: " + parts[1]);
	*   System.out.println("Raw name: " + parts[2]);
	*   
	*   parts = support.processName("dc:title", parts, false);
	*   System.out.println("Namespace URI: " + parts[0]);
	*   System.out.println("Local name: " + parts[1]);
	*   System.out.println("Raw name: " + parts[2]);
	*   
	*   support.popContext();</pre>
	* 
	* 	<p>Note that this class is optimized for the use case
	* 	where most elements do not contain Namespace declarations:
	* 	if the same prefix/URI mapping is repeated for each context
	* 	(for example), this class will be somewhat less efficient.</p>
	* 
	* 	<p>Although SAX drivers (parsers) may choose to use this
	* 	class to implement namespace handling, they are not required
	* 	to do so. Applications must track namespace information
	* 	themselves if they want to use namespace information.</p>
	*/
	public class NamespaceSupport extends Object
	{
		/**
		* 	Creats a <code>NamespaceSupport</code> instance.
		*/	
		public function NamespaceSupport()
		{
			super();
		}	
	}
}