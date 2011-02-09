/**
	<p>This specification defines a <em>standards compliant</em>,
	<em>protocol independent</em> and <em>type-agnostic architecture</em> for
	web publishing, retrieval and analysis specifically in the
	context of screen driven rich applications that may require
	authentication.</p>
	
	<p>A #fluid:term:fluid:ecosystem; is inherently a bi-directional
	client server architecture</p>

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
	between various parts of the #fluid:term:code:world;.</p>
	
	<p>As using a metaphor can become ambiguous, if there
	is a need to disambiguate we use the phrases <em>code world</em>
	to refer to <em>computer code</em> and the
	phrase #fluid:term:real:world; to refer to the <em>earth and
	it's physical attributes</em>.</p>
	
	<ul>
		<li>water -- The #fluid:term:real:type;, <em>fluid and dynamic</em>;
		can take the form of any container.</li>
		<li>reservoir -- The place to store water for a period of time,
		refers to a persistent collection of #fluid:term:real:type;(s), analgous to
		a database, flat file system or maybe #fluid:term:s3; storage.</li>
		<li>sea -- The control point for the cycle of water flow, a #fluid:term:fluid:ecosystem;.</li>
		<li>spring -- The source of a flow of water to or from the sea, analgous to a client connected
		to a server.</li>
		<li>waterway -- A means for water to be transported between a spring
		and the sea.</li>
		<li>river -- The flow of water from a source, analgous to
		a client pushing data to the server.</li>
		<li>evaporation -- The returning of water to the source, metaphorically
		this is the server returning data to the client.</li>
		<li>tidal wave -- A flow of water back to multiple sources, 
		comparable to a server pushing data to all connected clients.</li>
		<li>cloud -- A means for the sea to purify the water it returns
		to the client. A transformation tier responsible for any authentication
		or conformance verification.</li>
	</ul>
	
	<h1>Terminology</h1>
	<a name="#fluid:term" />
	
	<p>Parent child relationships are expressed using the #fluid:term:css; child descendant syntax:</p>
	
	<pre>parent>child</pre>
	
	<h2>w3c</h2>
	<a name="#fluid:term:w3c" />
	
	<p>The <a href="http://w3.org" title="w3">world-wide web consortium</a>.</p>
	
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
	implementation neutral method of defining a contractual obligation
	to an interface.</p>
	
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
	
	<p>The term <em>fluid ecosystem</em> is used to describe an implementation that
	#fluid:term:conforms to this specification.</p>
	
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

	<pre>ecosystem(n):
	  tier(n):
	    module(n):
	      component(n):
	        library(n):
	          package(n):
	            class|interface(n):</pre>
	
	<p>Each child relationship can occur any number of times, as represented by the
	<code>'(n)'</code> suffix.</p>

	<p>Here the <code>class|interface</code> leaf node of the tree relationship is our primary
	type that can be mutated into anything.</p>
	
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
		<li><code>localName</code> be the <em>name of the type</em>, eg: book.</li>
		<li><code>namespacePrefix</code> be the <em>package name</em> or <em>parent namespace</em>, eg: bookshelf, or desk.</li>
		<li><code>namespacePackage</code> be a <em>pseudo package created by walking
		in scope namespace prefixes for the ancestor #fluid:term:xml; hierarchy</em>,
		eg: bedroom>bookshelf, or study>desk.</li>
	</ul>
	
	<p>Extrapolated this gives us fully qualified paths of:</p>
	
	<pre>book
	bookshelf.book
	desk.book
	bedroom.bookshelf.book
	study.desk.book</pre>
	
	<p>Whilst always referring to the same <code>book</code> type,
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
	
	<p>Clearly that was quite simple from the perspecive of the class definition.
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
	
	<p>We are free to and and remove attributes and parent child relationships
	from our new <code>book</code> #fluid:term:real:type;.</p>
	
	<pre>&lt;?xml version="1.0"?&gt;
	&lt;bedroom:bookshelf
	  xmlns:bedroom="http://examples.fluid.wav.co.uk/bedroom"
	  xmlns:bookshelf="http://examples.fluid.wav.co.uk/bookshelf"&gt;
	  &lt;bookshelf:book author="Freeform Systems"
	    publisher="Publisher Name" isbn="xxx-xxx-xxx-xxx"&gt;
	  &lt;/bookshelf:book&gt;
	&lt;/bedroom:bookshelf&gt;</pre>
	
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