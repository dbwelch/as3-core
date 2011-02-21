package javax.xml.validation
{
	import org.xml.sax.Attributes;	
	import org.xml.sax.ContentHandler;
	import org.xml.sax.Locator;
	
	/**
	* 	Streaming validator that works on SAX stream.
	* 
	* 	A ValidatorHandler object is not thread-safe and not reentrant.
	* 	In other words, it is the application's responsibility to make
	* 	sure that one ValidatorHandler object is not used from more than
	* 	one thread at any given time.
	* 
	* 	ValidatorHandler checks if the SAX events follow the set of
	* 	constraints described in the associated Schema, and additionally
	* 	it may modify the SAX events (for example by adding default values, etc.).
	* 
	* 	ValidatorHandler extends from ContentHandler, but it refines the
	* 	underlying ContentHandler in the following way:
	* 
	* 	<ol>
	* 		<li>startElement/endElement events must receive non-null
	* 		String for uri, localName, and qname, even though SAX allows
	* 		some of them to be null. Similarly, the user-specified
	* 		ContentHandler will receive non-null Strings for all three parameters.</li>
	* 		<li>Applications must ensure that ValidatorHandler's
	* 		ContentHandler.startPrefixMapping(String,String) and
	* 		ContentHandler.endPrefixMapping(String) are invoked properly.
	* 		Similarly, the user-specified ContentHandler will receive
	* 		startPrefixMapping/endPrefixMapping events. If the ValidatorHandler
	* 		introduces additional namespace bindings, the user-specified
	* 		ContentHandler will receive additional
	* 		startPrefixMapping/endPrefixMapping events.</li>
	* 		<li>Attributes for the ContentHandler.startElement(String,String,String,Attributes)
	* 		method may or may not include xmlns* attributes.</li>
	* 	</ol>
	* 
	* 	<p>A ValidatorHandler is automatically reset every time the
	* 	startDocument method is invoked.</p>
	* 
	*   Recognized Properties and Features
    *   
	*   This spec defines the following feature that must be
	* 	recognized by all ValidatorHandler implementations.
    *   
	*   http://xml.org/sax/features/namespace-prefixes
    *   
	*   This feature controls how a ValidatorHandler introduces namespace
	* 	bindings that were not present in the original SAX event stream.
	* 	When this feature is set to true, it must make sure that the
	* 	user's ContentHandler will see the corresponding xmlns* attribute
	* 	in the Attributes object of the
	* 	ContentHandler.startElement(String,String,String,Attributes)
	* 	callback. Otherwise, xmlns* attributes must not be added to
	* 	Attributes that's passed to the user-specified ContentHandler.
    *   
	*   (Note that regardless of this switch, namespace bindings are
	* 	always notified to applications through
	* 	ContentHandler.startPrefixMapping(String,String) and
	* 	ContentHandler.endPrefixMapping(String) methods of
	* 	the ContentHandler specified by the user.)
    *   
	*   Note that this feature does NOT affect the way a ValidatorHandler
	* 	receives SAX events. It merely changes the way it augments SAX events.
    *   
	*   This feature is set to false by default.
	*/
	public class ValidatorHandler extends Object
		implements ContentHandler
	{
		
		/**
		* 	@private
		* 
		* 	Creates a <code>ValidatorHandler</code> instance.
		*/
		public function ValidatorHandler()
		{
			super();
		}
		
		
		/**
		* 	@inheritDoc
		*/
		public function characters( ch:String, start:int, length:int ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startElement(
			uri:String,
			localName:String,
			qname:String,
			atts:Attributes ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endElement(
			uri:String,
			localName:String,
			qname:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function startPrefixMapping(
			prefix:String, uri:String ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/
		public function endPrefixMapping(
			prefix:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function ignorableWhitespace(
			ch:String, start:int, length:int ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function processingInstruction(
			target:String, data:String ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/
		public function setDocumentLocator(
			locator:Locator ):void
		{
			//TODO
		}
			
		/**
		* 	@inheritDoc
		*/	
		public function skippedEntity( name:String ):void
		{
			//TODO
		}
	}
}