package org.w3c.dom.ls
{
	import org.w3c.dom.Document;	
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.Node;
	
	/**
	* 	An interface to an object that is able to build, or augment,
	* 	a DOM tree from various input sources.
	* 
	* 	LSParser provides an API for parsing XML and building the
	* 	corresponding DOM document structure. A LSParser instance
	* 	can be obtained by invoking the DOMImplementationLS.createLSParser() method.
	* 
	* 	As specified in [DOM Level 3 Core] , when a document is first
	* 	made available via the LSParser:
	* 
	* 	<ul>
	* 		<li>there will never be two adjacent nodes of type NODE_TEXT,
	* 		and there will never be empty text nodes.</li>
	* 		<li>it is expected that the value and nodeValue attributes of
	* 		an Attr node initially return the XML 1.0 normalized value.
	* 		However, if the parameters "validate-if-schema" and " datatype-normalization"
	* 		are set to true, depending on the attribute normalization used,
	* 		the attribute values may differ from the ones obtained by the XML 1.0
	* 		attribute normalization. If the parameters " datatype-normalization"
	* 		is set to false, the XML 1.0 attribute normalization is guaranteed
	* 		to occur, and if the attributes list does not contain namespace
	* 		declarations, the attributes attribute on Element node represents
	* 		the property [attributes] defined in [XML Information Set].</li>
	* 	</ul>
	* 
	* 	Asynchronous LSParser objects are expected to also implement
	* 	the events::EventTarget interface so that event listeners can
	* 	be registered on asynchronous LSParser objects.
	* 
	* 	Events supported by asynchronous LSParser objects are:
	* 
	* 	<p><code>load</code> -- The LSParser finishes to load the document. See also the definition
	* 	of the LSLoadEvent interface.</p>
	* 
	* 	<p><code>progress</code> -- The LSParser signals progress as data is parsed.
	* 	This specification does not attempt to define exactly when progress events
	* 	should be dispatched. That is intentionally left as implementation-dependent.
	* 	Here is one example of how an application might dispatch progress events:
	* 	Once the parser starts receiving data, a progress event is dispatched to
	* 	indicate that the parsing starts. From there on, a progress event is dispatched
	* 	for every 4096 bytes of data that is received and processed. This is only one
	* 	example, though, and implementations can choose to dispatch progress events
	* 	at any time while parsing, or not dispatch them at all. See also the definition
	* 	of the LSProgressEvent interface.</p>
	* 
	* 	<p><strong>Note:</strong> All events defined in this specification use the
	* 	namespace URI "http://www.w3.org/2002/DOMLS".</p>
	* 
	* 	<p>While parsing an input source, errors are reported to the application
	* 	through the error handler (LSParser.domConfig's " error-handler" parameter).
	* 	This specification does in no way try to define all possible errors that
	* 	can occur while parsing XML, or any other markup, but some common error
	* 	cases are defined. The types (DOMError.type) of errors and warnings
	* 	defined by this specification are:</p>
	* 
	* 	<ul>
	* 		<li><code>"check-character-normalization-failure" [error]</code> --
	* 		Raised if the parameter "check-character-normalization" is set to
	* 		true and a string is encountered that fails normalization checking.</li>
	* 		<li><code>"doctype-not-allowed" [fatal]</code> --
	* 		Raised if the configuration parameter "disallow-doctype"
	* 		is set to true and a doctype is encountered.</li>
	* 		<li><code>"no-input-specified" [fatal]</code> --
	* 		Raised when loading a document and no input is specified in the LSInput object.</li>
	* 		<li><code>"pi-base-uri-not-preserved" [warning]</code> --
	* 		Raised if a processing instruction is encountered in a location where the base URI of the processing instruction can not be preserved. One example of a case where this warning will be raised is if the configuration parameter " entities" is set to false and the following XML file is parsed:
	* 		<pre>&lt;!DOCTYPE root [ &lt;!ENTITY e SYSTEM 'subdir/myentity.ent' ]&gt; 
	*		  &lt;root&gt; &amp;e; &lt;/root&gt;</pre>
	* 		And <code>subdir/myentity.ent</code> contains:
	* 		<pre>&lt;one&gt; &lt;two/&gt; &lt;/one&gt; &lt;?pi 3.14159?&gt; 
	*		  &lt;more/&gt;</pre>
	* 		</li>
	* 		<li><code>"unbound-prefix-in-entity" [warning]</code> --
	* 		An implementation dependent warning that may be raised if
	* 		the configuration parameter "namespaces" is set to true and
	* 		an unbound namespace prefix is encountered in an entity's
	* 		replacement text. Raising this warning is not enforced since
	* 		some existing parsers may not recognize unbound namespace
	* 		prefixes in the replacement text of entities.</li>
	* 		<li><code>"unknown-character-denormalization" [fatal]</code> -- 
	* 		Raised if the configuration parameter "ignore-unknown-character-denormalizations"
	* 		is set to false and a character is encountered for which the
	* 		processor cannot determine the normalization properties.</li>
	* 		<li><code>"unsupported-encoding" [fatal]</code> --
	* 		Raised if an unsupported encoding is encountered.</li>
	* 		<li><code>"unsupported-media-type" [fatal]</code> --
	* 		Raised if the configuration parameter "supported-media-types-only"
	* 		is set to true and an unsupported media type is encountered.</li>
	* 	</ul>
	* 
	* 	<p>In addition to raising the defined errors and warnings,
	* 	implementations are expected to raise implementation specific
	* 	errors and warnings for any other error and warning cases such
	* 	as IO errors (file not found, permission denied,...), XML
	* 	well-formedness errors, and so on.</p>
	* 
	* 	<p>See also the Document Object Model (DOM) Level 3 Load and Save Specification.</p>
	*/
	public interface LSParser
	{
		/**
		* 	Abort the loading of the document that is currently
		* 	being loaded by the LSParser.
		*/
		function abort():void;
		
		/**
		* 	Whether this parser is asynchronous;
		* 	true if the LSParser is asynchronous,
		* 	false if it is synchronous.
		*/
		function get async():Boolean;
		
		/**
		* 	Determines if this parser is busy
		* 	loading a document.
		*/	
		function get busy():Boolean;
		
		/**
		* 	The DOMConfiguration object used
		* 	when parsing an input source.
		*/
		function get domConfig():DOMConfiguration;
		
		/**
		*	When a filter is provided, the implementation
		* 	will call out to the filter as it is constructing
		* 	the DOM tree structure.
		*/
		function get filter():LSParserFilter;
		function set filter( filter:LSParserFilter ):void;
		
		/**
		* 	Parse an XML document from a resource
		* 	identified by a LSInput.
		* 
		* 	@param input The source input.
		* 
		* 	@return A Document implementation.
		*/
		function parse( input:LSInput ):Document;
		
		/**
		* 	Parse an XML document from a location
		* 	identified by a URI reference [IETF RFC 2396].
		* 
		* 	@param uri The URI for the document.
		* 
		* 	@return A Document implementation.
		*/
		function parseURI( uri:String ):Document;
		
		/**
		* 	Parse an XML fragment from a resource
		* 	identified by a LSInput and insert the
		* 	content into an existing document at the
		* 	position specified with the context and
		* 	action arguments.
		* 
		* 	@param iput The source input.
		* 	@param context The context node.
		* 	@param action The action to take
		* 	with the parsed node in the specified
		* 	context.
		* 
		* 	@return A Node implementation.
		*/
		function parseWithContext( input:LSInput, context:Node, action:uint ):Node;
		
		/*
		
		void	abort() 
		          Abort the loading of the document that is currently being loaded by the LSParser.
		 boolean	getAsync() 
		          true if the LSParser is asynchronous, false if it is synchronous.
		 boolean	getBusy() 
		          true if the LSParser is currently busy loading a document, otherwise false.
		 DOMConfiguration	getDomConfig() 
		          The DOMConfiguration object used when parsing an input source.
		 LSParserFilter	getFilter() 
		          When a filter is provided, the implementation will call out to the filter as it is constructing the DOM tree structure.
		 Document	parse(LSInput input) 
		          Parse an XML document from a resource identified by a LSInput.
		 Document	parseURI(String uri) 
		          Parse an XML document from a location identified by a URI reference [IETF RFC 2396].
		 Node	parseWithContext(LSInput input, Node contextArg, short action) 
		          Parse an XML fragment from a resource identified by a LSInput and insert the content into an existing document at the position specified with the context and action arguments.
		 void	setFilter(LSParserFilter filter) 
		          When a filter is provided, the implementation will call out to the filter as it is constructing the DOM tree structure.
		
		*/
	}
}