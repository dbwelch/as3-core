package org.xml.sax.helpers
{
	import org.xml.sax.XMLReader;
	
	/**
	* 	Factory for creating an XML reader.
	* 
	* 	This class contains static methods for
	* 	creating an XML reader from an explicit class name,
	* 	or based on runtime defaults:
	* 
	* 	<pre>try {
	*     XMLReader myReader = XMLReaderFactory.createXMLReader();
	*   } catch (SAXException e) {
	*     System.err.println(e.getMessage());
	*   }</pre>
	* 
	* 	<p><strong>Note to Distributions bundled with parsers</strong>:
	* 	You should modify the implementation of the no-arguments createXMLReader
	* 	to handle cases where the external configuration mechanisms aren't set up.
	* 	That method should do its best to return a parser when one is in the
	* 	class path, even when nothing bound its class name to org.xml.sax.driver
	* 	so those configuration mechanisms would see it.</p>
	*/
	public class XMLReaderFactory extends Object
	{
		
		/**
		* 	Attempt to create an XMLReader from system defaults.
		* 
		* 	In environments which can support it, the name of the
		* 	XMLReader class is determined by trying each these options
		* 	in order, and using the first one which succeeds:
		* 
		* 	<ul>
		* 		<li>If the system property org.xml.sax.driver has a value,
		* 		that is used as an XMLReader class name.</li>
		* 		<li>The JAR "Services API" is used to look for a class name
		* 		in the META-INF/services/org.xml.sax.driver file in jarfiles
		* 		available to the runtime.</li>
		* 		<li>SAX parser distributions are strongly encouraged to
		* 		provide a default XMLReader class name that will take effect
		* 		only when previous options (on this list) are not successful.</li>
		* 		<li>Finally, if ParserFactory.makeParser() can return a
		* 		system default SAX1 parser, that parser is wrapped in a ParserAdapter.
		* 		(This is a migration aid for SAX1 environments, where the
		* 		org.xml.sax.parser system property will often be usable.)</li>
		* 	</ul>
		* 
		* 	<p>In environments such as small embedded systems, which can
		* 	not support that flexibility, other mechanisms to determine
		* 	the default may be used.</p>
		* 
		* 	<p>Note that many Java environments allow system properties
		* 	to be initialized on a command line. This means that in most cases
		* 	setting a good value for that property ensures that calls to this
		* 	method will succeed, except when security policies intervene. This
		* 	will also maximize application portability to older SAX environments,
		* 	with less robust implementations of this method.</p>
		* 
		* 	@throws SAXException If no default XMLReader class can be
		* 	identified and instantiated.
		* 
		* 	@return A new XMLReader.
		*/
		public static function createSystemXMLReader():XMLReader
		{
			//TODO
			return null;
		}
		
		/**
		* 	Attempt to create an XML reader from a class name.
		* 
		* 	Given a class name, this method attempts to load and
		* 	instantiate the class as an XML reader.
		* 
		* 	Note that this method will not be usable in environments
		* 	where the caller (perhaps an applet) is not permitted
		* 	to load classes dynamically.
		* 
		* 	@throws SAXException If the class cannot be loaded,
		* 	instantiated, and cast to XMLReader.
		* 
		* 	@return A new XML reader.
		*/
		public static function createXMLReader( className:String = null ):XMLReader
		{
			//TODO
			return null;
		}
	}
}