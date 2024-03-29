/**
	<p>This specification defines a <em>standards compliant</em>,
	<em>protocol independent</em> and <em>type-agnostic architecture</em> for
	web publishing, retrieval and analysis specifically in the
	context of screen driven rich applications that may require
	authentication.</p>
	
	<p>A #fluid:term:fluid:ecosystem; is designed to fulfill
	the definition of a <em>duplex &amp; multiplex</em>
	client server architecture.</p>

	<h1>Abstract</h1>
	<a name="#fluid:abstract" />

	<p>The exhaustive <em>issues</em> involved with web publishing,
	document retrieval and semantic
	analysis are beyond the scope of this document although
	some may be mentioned in the context of illustrations and examples.</p>
	
	<p>All information contained in this <em>draft specification</em> is considered
	to be <em>informative</em>, unless specifically declared as <em>normative</em>.</p>

	<h1>Metaphor</h1>
	<a name="#fluid:metaphor" />

	<p>Much in the same way that we use the term <em>desktop</em>
	to refer to an interactive display space on a computer screen as
	a replacement for the traditional physical desk, it is useful to try
	to describe a complex system as a metaphor.</p>

	<p>In this case we think that <em>water</em> and the physical
	relationships between <em>water</em> and it's surroundings serves
	as a good metaphor to illustrate the relationships
	between various parts of a #fluid:term:fluid:ecosystem;.</p>
	
	<p>As using a metaphor can become ambiguous, if there
	is a need to disambiguate we use the phrases <em>code world</em>
	to refer to <em>computer code</em> and the
	phrase #fluid:term:real:world; to refer to the <em>earth and
	it's physical attributes</em>.</p>
	
	<ul>
		<li>water -- The #fluid:term:real:type;, <em>fluid and dynamic</em>;
		can take the form of any container and
		has the ability to <em>transform type</em>.</li>
		<li>source -- Anything that can hold water, a spring, sea, reservoir etc.</li>
		<li>reservoir -- The place to store water for a period of time,
		refers to a persistent collection of #fluid:term:real:type;(s), analgous to
		a database, flat file system or maybe #fluid:term:s3; storage.</li>		
		<li>sea -- The control point for the cycle of water flow, a #fluid:term:fluid:ecosystem;.</li>
		<li>spring -- The source of a flow of water to or from the sea, analgous to a client connected
		to a server.</li>
		<li>flow -- The exchange of water between a source, analgous
		to any client server interaction.</li>
		<li>waterway -- A means for water to be transported between another two
		sources. A river, canal, evaporation, rain etc.
		A transport scheme, such as #fluid:term:http;.</li>
		<li>river -- The flow of water from a source, analgous to
		a client pushing data to the server.</li>
		<li>evaporation -- The process that allows seas to communicate
		with other sources. Defines an inter #fluid:term:fluid:ecosystem;
		transport mechanism.</li>
		<li>tidal wave -- A flow of water back to multiple sources, 
		comparable to a server pushing data to all connected clients.</li>
		<li>desalination -- A means for the sea to cleanse the water it returns
		to other sources. A transformation tier responsible for any authentication
		or conformance verification of data returned to a client.</li>
		<li>purification -- A transformation tier responsible for ensuring that
		water conforms to the seas acceptable toxicity levels.</li>
	</ul>
	
	<h1>Terminology</h1>
	<a name="#fluid:term" />
	
	<p>Parent child relationships are expressed using the #fluid:term:css; child descendant syntax:</p>
	
	<pre>parent>child</pre>
	
	<h2>w3c</h2>
	<a name="#fluid:term:w3c" />
	
	<p>The <a href="http://w3.org" title="w3">world-wide web consortium</a>.</p>
	
	<h2>TCP</h2>
	<a name="#fluid:term:tcp" />
	
	<p>The transmission control protocol.</p>	
	
	<h2>UDP</h2>
	<a name="#fluid:term:udp" />
	
	<p>The unified datagram protocol.</p>
	
	<h2>XML</h2>
	<a name="#fluid:term:xml" />
	
	<p>Extensible markup language as defined by the #fluid:term:w3c;.</p>
	
	<h2>DOM</h2>
	<a name="#fluid:term:dom" />
	
	<p>The level 3 Document Object Model (DOM) specification as defined
	by the #fluid:term:w3c;.</p>
	
	<h2>IDL</h2>
	<a name="#fluid:term:idl" />
	
	<p>Interface definition language. A #fluid:term:programming:language; and
	implementation neutral definition of a contractual obligation
	for an implementation.</p>
	
	<h2>ECMA</h2>
	<a name="#fluid:term:ecma" />
	
	<p>The european computer manufacturers association.</p>
	
	<h2>CSS</h2>
	<a name="#fluid:term:css" />
	
	<p>The level 3 cascading stylesheet specification.</p>
	
	<h2>URI</h2>
	<a name="#fluid:term:uri" />
	
	<p>A uniform resource identifier.</p>
	
	<h2>HTTP</h2>
	<a name="#fluid:term:http" />
	
	<p>The hyper text transfer protocol.</p>
	
	<h2>S3</h2>
	<a name="#fluid:term:s3" />
	
	<p>The web-based disk storage service provided by Amazon.</p>
	
	<h2>IoC</h2>
	<a name="#fluid:term:ioc" />
	
	<p>A common programming design pattern that involves moving control of object
	construction to an <em>inversion of control</em> container to encourage
	looser decoupling.</p>
	
	<h2>AOP</h2>
	<a name="#fluid:term:aop" />
	
	<p>Aspect oriented programming. A technique for viewing and manipulating
	a hierarchical class or structure using a sliced perspective
	of the relationships.</p>
	
	<h2>CRUD</h2>
	<a name="#fluid:term:crud" />
	
	<p>Refers to the common operations performed on a persistent store,
	create, read, update and delete.</p>
	
	<h2>implementation</h2>
	<a name="#fluid:term:implementation" />
	
	<p>An implementation of a specification, unless qualified it means
	an implementation of this specification; which is also referred to
	as a #fluid:term:fluid:ecosystem;.</p>
	
	<h2>real world</h2>
	<a name="#fluid:term:real:world" />
	
	<p>The <em>real world</em> is a term used to refer to the earth and
	it's physical attributes.</p>
	
	<h2>natural language</h2>
	<a name="#fluid:term:natural:language" />
	
	<p>Any of the known natural languages.</p>
	
	<h2>programming language</h2>
	<a name="#fluid:term:programming:language" />
	
	<p>Any of the known computer programming languages.</p>
	
	<h2>type</h2>
	<a name="#fluid:term:type" />
	
	<p>An object that can be described in terms of a collection of attributes
	and behaviours.</p>
	
	<h2>real type</h2>
	<a name="#fluid:term:real:type" />
	
	<p>A <em>real type</em> exists in the #fluid:term:real:world; and is said to be
	any physical thing that can be described in any <em>natural language</em>
	with any combination of attributes or behaviours. This definition inherently includes
	all #fluid:term:imaginary:type;(s).</p>
	
	<h2>imaginary type</h2>
	<a name="#fluid:term:imaginary:type" />
	
	<p>Anything that can be conceived by a human (recursively for a human
	imagining a human), including but not limited to all objects defined
	in the #fluid:term:code:world or any dream.</p>
	
	<h2>fluid ecosystem</h2>
	<a name="#fluid:term:fluid:ecosystem" />
	
	<p>The term <em>fluid ecosystem</em> is used to describe an implementation
	that #fluid:term:conforms; to this specification.</p>
	
	<h2>base type</h2>
	<a name="#fluid:term:base:type" />

	<p>A <em>base type</em> is anything in the #fluid:term:code:world; that
	supports the declaration of any combination of attributes and methods.</p>
	
	<p>In a #fluid:term:fluid:ecosystem; it is a #fluid:term:dom;
	<code>Element</code> implementation, see the #fluid:cfm:base:type;
	conformance requirements for full details.</p>

	<h3>ecosystem</h3>
	<a name="#fluid:term:ecosystem" />

	<p>In the context of the #fluid:term:code:world;, an <em>ecosystem</em> can be
	described with this simple tree relationship:</p>

	<pre>+ ecosystem(n):
	|  tier(n):
	|  |  module(n):
	|  |    component(n):
	|  |      library(n):
	|  |        package(n):
	|  |          class|interface(n):
	|  |            attribute(n):</pre>
	
	<p>Each child relationship can occur any number of times, as represented by the
	<code>'(n)'</code> suffix.</p>

	<p>Here the <code>class|interface</code> leaf node of the tree relationship is our primary
	type that can be mutated into anything, it <em>is the water</em> </p>
	
	<p>In the context of the #fluid:term:real:world;, an <em>ecosystem</em> retains it's natural meaning.</p>	

	<h2>code world</h2>
	<a name="#fluid:term:code:world" />

	<p>The phrase <em>code world</em> is a term used to represent the <em>conceptual and/or
	perceived relationships</em> of any computer code in any
	computer #fluid:term:programming:language;.</p>
	
	<h2>conforms</h2>
	<a name="#fluid:term:conforms" />
	
	<p>Describes an implementation that conforms to a specification, in the context
	of a #fluid:term:fluid:ecosystem; the rules and behaviours described in #fluid:conformance;
	must be implemented as specified.</p>
	
	<h1>Conformance</h1>
	<a name="#fluid:conformance" />
	
	<p>This section describes the conformance requirements for this specification
	and any prerequisites for conformance including demonstrability.</p>
	
	<h2>Transport Protocol</h2>
	<a name="#fluid:cfm:transport:protocol" />
	
	<p>A conforming #fluid:term:fluid:ecosystem; <strong>must</strong>
	at the minimum support the #fluid:term:tcp; transport protocol.
	See #fluid:appendix:idl:definitions for all recognised transport protocols.</p>
	
	<h2>Transport Scheme</h2>
	<a name="#fluid:cfm:transport:scheme" />
	
	<p>A conforming #fluid:term:fluid:ecosystem; <strong>must</strong>
	at the minimum support the #fluid:term:http; transport scheme.
	See #fluid:appendix:idl:definitions for all recognised transport schemes.</p>
	
	<h2>Atomicity</h2>
	<a name="#fluid:cfm:atomicity" />
	
	<p>This section defines conformance for data integrity in the context of the atomic nature
	of a #fluid:term:real:type; and the transactional nature of a #fluid:term:fluid:ecosystem;.</p>
	
	<h2>Type Acceptance</h2>
	<a name="#fluid:cfm:type:acceptance" />
	
	<p>If a user submits a #fluid:term:real:type; for a create or update
	operation and the user has the required permission to perform that operation
	<em>and has submitted a conforming #fluid:term:real:type;</em> the #fluid:term:fluid:ecosystem;
	<strong>must accept the request</strong>.</p>
	
	<h2>Dynamic Type Creation</h2>
	<a name="#fluid:cfm:dynamic:type:creation" />
	
	<p>The implementation must be able to dynamically create
	a representation of a #fluid:term:real:type; and persist
	the new #fluid:term:real:type;.</p>
	
	<p><strong>Demonstrability:</strong> You must demonstrate the ablility
	to create an arbitrary type of object that exists or doesn't exist
	in the #fluid:term:real:world; within your #fluid:term:fluid:ecosystem;.</p>
	
	<p>That is to say, we should be able to ask for a new <em>wobbly</em>
	and if you are unaware of <em>our definition of a wobbly</em>
	we should be able to demonstrate <em>our definition of a wobbly</em>
	via a <em>user interface</em> provided by your #fluid:term:fluid:ecosystem;.
	This is the <strong>primary show me requirement</strong> for conformance.</p>
	
	<h2>Base Type</h2>
	<a name="#fluid:cfm:base:type" />
	
	<p>The conforming #fluid:term:fluid:ecosystem; must provide
	a super class for all #fluid:term:real:type;
	representations that is a conforming #fluid:term:dom;
	<code>Element</code> implementation.</p>
	
	<h2>Base Type Representation</h2>
	<a name="#fluid:cfm:base:type:representation" />
	
	<p>The <em>base type implementation</em> <strong>must</strong> represent
	all public state information as a well-formed #fluid:term:xml; document.</p>
	
	<p>In addition wherever possible <em>it is recommended</em> that
	a <em>base type implementation</em> also represent it's public
	state as any of the following:</p>
	
	<ul>
		<li>JSON -- Javascript Object Notation.</li>
		<li>SOAP+XML -- Simple Object Access Protocol.</li>
		<li>RSS+XML -- An RSS document or document fragment.</li>
		<li>ATOM+AML -- An ATOM document or document fragment.</li>
		<li>XML+RPC -- The <code>XML RPC</code> format.</li>
		<li>WDDX -- The web description data exchange format.</li>
		<li>AMF -- Actionscript message format.</li>
		<li>HESSIAN -- Hessian compact binary format.</li>
		<li>OSC -- Open Sound control, a compact binary format with #fluid:term:uri; support.</li>
	</ul>
	
	<h2>Namespace Cascade</h2>
	<a name="#fluid:cfm:ns:cascade" />
	
	<p>A conforming #fluid:term:fluid:ecosystem; must be able to
	represent <em>the type of</em> all #fluid:term:real:type;(s) as an #fluid:term:xml; element using
	a combination of the <code>localName</code> and <code>namespace</code>
	associated with the element and any ancester element hierarchy. This
	is known as a <em>namespace cascade</em>.</p>
	
	<p>The attributes that combined define the <em>fully qualified type</em>
	of a #fluid:term:real:type; are:</p>
	
	<ul>
		<li><code>localName</code> -- The <em>name of the type</em>, eg: <code>book</code>.</li>
		<li><code>namespacePrefix</code> -- The <em>package name</em> or <em>parent namespace</em>,
		eg: <code>bookshelf</code>, or <code>desk</code>.</li>
		<li><code>namespacePackage</code> -- A <em>pseudo package created by walking
		in scope namespace prefixes for the ancestor #fluid:term:xml; hierarchy</em>,
		eg: <code>bedroom&gt;bookshelf</code>, or <code>study&gt;desk</code>.</li>
	</ul>
	
	<p>Extrapolated this gives us fully qualified paths of:</p>
	
	<pre>book
	bookshelf.book
	desk.book
	bedroom.bookshelf.book
	study.desk.book</pre>
	
	<p>Whilst always referring to a <code>book</code> type,
	the above extrapolations create the following packages:</p>
	
	<pre>package;
	package bookshelf;
	package desk;
	package bedroom.bookshelf;
	package study.desk;</pre>
	
	<p>Using this <em>rule</em> we can cleanly represent any #fluid:term:ecma; compliant
	class definition as valid well formed #fluid:term:xml; <em>without adding
	any additional type information</em>. To continue with the above examples,
	consider the class definition:</p>
	
	<pre>package {
        public class Book {
            public var author:String = "Freeform Systems";
            public function Book()
            {
                super();
            }
        }
    }
	</pre>
	
	<p>We can represent that as the #fluid:term:xml; document:</p>
	
	<pre>&lt;?xml version="1.0"?&gt;
	&lt;book author="Freeform Systems" /&gt;</pre>
	
	<p>Then as we decide that our book belongs to a bookshelf 
	our class definition becomes:</p>
	
	<pre>package bookshelf {
	    public class Book {
	        public var author:String = "Freeform Systems";
	        public function Book()
	        {
	            super();
	        }
	    }
	}
	</pre>
	
	<p>Now the original #fluid:term:xml; definition can be updated to reflect the qualification:</p>
	
	<pre>&lt;?xml version="1.0"?&gt;
	&lt;bookshelf:book
	  xmlns:bookshelf="http://examples.fluid.wav.co.uk/bookshelf"
	  author="Freeform Systems" /&gt;</pre>
	
	<p>It is a self-evident truth of nature that <em>things change</em>. So time has passed
	and we decide that we need to qualify our <code>bookshelf</code>, better update that
	class definition again:</p>
	
	<pre>package bedroom.bookshelf {
	    public class Book {
	        public var author:String = "Freeform Systems";
	        public function Book()
	        {
	            super();
	        }
	    }
	}
	</pre>
	
	<p>Clearly that was quite simple from the perspective of the class definition.
	But we also need to update our #fluid:term:xml; definition. This is the point where
	the <em>namespace cascades to create the package</em>.</p>
	
	<pre>&lt;?xml version="1.0"?&gt;
	&lt;bedroom:bookshelf
	  xmlns:bedroom="http://examples.fluid.wav.co.uk/bedroom"
	  xmlns:bookshelf="http://examples.fluid.wav.co.uk/bookshelf"&gt;
	  &lt;bookshelf:book author="Freeform Systems" /&gt;
	&lt;/bedroom:bookshelf&gt;</pre>
	
	<p>By adding a namespace to the parent element we <em>qualify</em>
	the previously defined <code>bookshelf</code> package.</p>
	
	<p>We are free to add and remove attributes and parent child relationships
	from our new <code>book</code> #fluid:term:real:type;.</p>
	
	<pre>&lt;?xml version="1.0"?&gt;
	&lt;bedroom:bookshelf
	  xmlns:bedroom="http://examples.fluid.wav.co.uk/bedroom"
	  xmlns:bookshelf="http://examples.fluid.wav.co.uk/bookshelf"&gt;
	  &lt;bookshelf:book author="Freeform Systems"
	    publisher="Publisher Name" isbn="xxx-xxx-xxx-xxx"&gt;
	      &lt;chapter title="Introduction" /&gt;
	  &lt;/bookshelf:book&gt;
	&lt;/bedroom:bookshelf&gt;</pre>
	
	<h2>Equality</h2>
	<a name="#fluid:cfm:ns:uri" />
	
	<p>The #fluid:cfm:ns:cascade allows us to <em>inspect the
	fully qualified class path to an object</em>. But there is another
	critical issue that needs to be addressed, how to determine
	<em>object equality</em>? To do so, we need to add
	a unique identifier to each <em>instance of a type</em>. Normally,
	this is achieved by assigning a <em>unique identifier</em> to an object,
	often the primary key from a database table
	for database-driven applications. First let's look at the
	common approach of assigning an <code>id</code> attribute:</p>
	
	<pre>&lt;books&gt;
	  &lt;book
	    id="1" author="Freeform Systems" /&gt;
	  &lt;book
	    id="2" author="Freeform Systems" /&gt;
	&lt;books&gt;</pre>
	
	<p>At first glance that seems acceptable, the <code>id</code> is part
	of the #fluid:term:xml; specification designed to allow direct access to an
	element by identifier. So, it's part of the semantics of the format and
	gives us the additional benefit of being able to retrieve an element directly
	by identifier. In this example, the fact the identifier is generated from a primary
	key ensures uniqueness. We're not so convinced.</p>
	
	<p>It has added a constraint that the <code>id</code> field cannot be used
	for any other purpose than as a <em>unique object identifier</em>. But that's not
	the real problem, it mean's that you are adding attributes to an element
	that performs a task other than <em>describing the state of that object</em>.</p>
	
	<p>By adding an attribute that serves to <em>identify the instance</em>
	the types of data encapsulated by an element become mixed. We now have some
	<em>identity attributes</em> and some <em>state attributes</em>.</p>
	
	<p>We believe object uniqueness indication can be defined without the
	use of an <code>id</code> attribute, before illustrating how this can be achieved
	we need to examine a namespace #fluid:term:uri;.</p>
	
	<p>In #fluid:term:xml; the namespace #fluid:term:uri; is used in conjunction with
	a namespace prefix to qualify the names of one or more elements.</p>
	
	<p>It must be a valid #fluid:term:uri; and it must (in conjunction with the prefix)
	serve to distinguish elements of the same name that serve different
	purposes. This allows for elements with the same name that
	server different purposes to be <em>intermingled in the same document</em>.</p>
	
	<p>Our approach is to take the purpose and definition of a <em>namespace #fluid:term:uri;</em>
	and <em>qualify it further</em>. Currently, namespaces serve to distinguish
	<em>one or more element names</em>; What happens if we change that rule
	so that we let:</p>
	
	<ul>
		<li>A namespace #fluid:term:uri; <em>qualify an individual element</em>
		using a <strong>unique</strong> #fluid:term:uri;.</li>
	</ul>
	
	<p>Without changing the <em>purpose and behaviour of a namespace</em> we
	have <em>allowed for</em> a namespace #fluid:term:uri; to be used as the
	<em>unique object identifier</em>. Our previous example updated for our new
	rule looks like:</p>
	
	<pre>&lt;books&gt;
	  xmlns:books="http://examples.fluid.wav.co.uk/books"&gt;
	  &lt;book
	    xmlns:book="http://examples.fluid.wav.co.uk/books/1"
	    author="Freeform Systems" /&gt;
	  &lt;book
	    xmlns:book="http://examples.fluid.wav.co.uk/books/2"
	    author="Freeform Systems" /&gt;
	&lt;books&gt;</pre>
	
	<h2>Persistence</h2>
	<a name="#fluid:cfm:persistence" />
	
	<p>The #fluid:term:fluid:ecosystem; <strong>must not</strong> impose a constraint
	on the storage used for persistence. It must allow for any type of relational database
	system or <em>any other</em> storage system, including but not limited to a flat-file
	storage system.</p>
	
	<h2>REST</h2>
	<a name="#fluid:cfm:rest" />
	
	<p>The #fluid:term:fluid:ecosystem; <strong>must</strong> recognise the #fluid:term:http;
	verbs for #fluid:term:crud; operations and perform the appropriate persistence operations.</p>
	
	<h1>Technical Considerations</h1>
	<a name="#fluid:technical:considerations" />
	
	<p>...</p>

	<h1>Appendix</h1>
	<a name="#fluid:appendix" />
	
	<p>...</p>

	<h2>IDL Definitions</h2>
	<a name="#fluid:appendix:idl:definitions" />
	
	<p>This section defines the interfaces for the #fluid:term:fluid:ecosystem;. These
	interfaces <em>define the implementation contract</em> in a #fluid:term:programming:language
	indepedent manner using #fluid:term:idl;. In particular take note that these interfaces
	do not imply any particular inheritance hierarchy.</p>
	
	<pre>interface FluidElement : Element {
	  readonly attribute DOMString namespacePackage;
	}</pre>
	
	<pre>interface FluidTransportScheme : Element {
	  const unsigned short HTTP = 1;
	  const unsigned short HTTPS = 2;
	  const unsigned short FTP = 3;
	  const unsigned short SCP = 4;
	  const unsigned short IMAP = 5;	
	  const unsigned short SMTP = 6;
	  const unsigned short POP = 7;
	}</pre>
	
	<pre>interface FluidTransportProtocol : Element {
	  const unsigned short TCP = 1;
	  const unsigned short UCP = 2;
	}</pre>
	
	<pre>interface FluidDataStoreType : Element {
	  const unsigned short OODBMS = 1;
	  const unsigned short RDBMS = 2;
	  const unsigned short XMLDBMS = 3;
	  const unsigned short AMAZON_S3 = 4;
	}</pre>
	
	<pre>interface FluidDataStoreFormat : Element {
	  const unsigned short DB_INTERNAL = 1;
	  const unsigned short XML_FILE = 2;
	}</pre>
	
	<h2>References</h2>
	<a name="#fluid:refs" />
	
	<ul>
		<li></li>
	</ul>
*/
package com.ffsys.fluid
{
	
	/**
	* 	The version of this specification.
	*/
	public var $version:String = "0.1";
}