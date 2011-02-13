/**
*	<p>The specification and reference implementation for a versatile
*	pattern matching library.</p>
*
*	<p>An understanding of regular expression grammar is assumed
*	for the rest of this documentation.</p>
*
*	<h1>Abstract</h1>
*	<a name="#ptnlib:abstract" />
*
*	<p>Regular expressions are something of a double-edged sword. The powerful
*	nature of the syntax allows for complex rules to be expressed concisely,
*	but complex rules can become unwieldy to manage unless broken down into
*	smaller pattern rules.</p>
*
*	<p>In addition they have always appeared to be limited by the implementation
*	in most programming languages that <em>only</em> allows for matching regular expressions
*	against a <a href="#ptnlib:term:string" />.</p>
*
*	<p>Therefore this specification has been designed to provide a language-neutral
*	consistent API for powerful pattern matching.</p>
*
*	<p>Inspiration comes from various regular expression implementations, notably
*	the ECMAScript and Java implementations. In addition, various names and conventions
*	have been borrowed from the DOM specification with regard to the #ptnlib:term:tree;
*	representation of a #ptnlib:term:pattern;</p>
*
*	<h1>Terminology</h1>
*
*	<p>This section expands on accepted regular expression grammar definitions to
*	define terms specific to the pattern library.</p>
*
*	<p>String literals are enclosed in double quotes <code>'"'</code>:</p>
*
*	<pre>"A literal sequence of characters."</pre>
*
*	<p>Regular expression literals begin and end with a forward slash <code>'/'</code>:</p>
*
*	<pre>/^[0-9]{10,11}$/</pre>
*
*	<p>And are optionally followed by one or more <a href="#ptnlib:term:flags" />.</p>
*
*	<p>When it is ambiguous as to whether a character takes on special meaning
*	in the context of a descripton it is enclosed in single quotes, for example, 
*	the question mark <code>'?'</code> used to signify <a href="#ptnlib:term:optionality" />.</p>
*
*	<h2>environment</h2>
*	<a name="#ptnlib:term:environment" />
*
*	<p>A term used to describe the combination of a programming <em>language</em>
*	and optional primary <em>deployment platform</em> for
*	a <a href="#ptnlib:term:pattern:implementation" />.</p>
*
*	<p>For this reference <a href="#ptnlib:term:pattern:implementation" /> the language
*	is <em>Actionscript</em> and the <em>deployment platform</em> is the <em>Flash Platform</em>.</p>
*
*	<h2>pattern implementation</h2>
*	<a name="#ptnlib:term:pattern:implementation" />
*
*	<p>An implementation of this pattern library specification.</p>
*
*	<p>A name of Pattern should be preferred but if this is not possible
*	in a programming language the name <code>PatternImpl</code> may
*	be used.</p>
*
*	<p>If a programming language does not enfore the convention that
*	complex types start with an uppercase character the name <code>pattern</code>
*	is acceptable.</p>
*
*	<h2>pattern exception</h2>
*	<a name="#ptnlib:term:pattern:exception" />
*
*	<p>An exceptional condition encountered by a <a href="#ptnlib:term:pattern:implementation" />.</p>
*
*	<h2>rule</h2>
*	<a name="#ptnlib:term:rule" />
*
*	<p>A <a href="#ptnlib:term:pattern" /> at the root of a <a href="#ptnlib:term:pattern:tree" />.</p>
*
*	<h2>pattern</h2>
*	<a name="#ptnlib:term:pattern" />
*
*	<p>Any sequence of characters.</p>
*
*	<h2>expression</h2>
*	<a name="#ptnlib:term:expression" />
*
*	<p>A <a href="#ptnlib:term:pattern" /> that contains one or more
*	<a href="#ptnlib:term:meta:character" /> or <a href="#ptnlib:term:meta:sequence" />
*	declarations.</p>
*
*	<h2>character class</h2>
*	<a name="#ptnlib:term:character:class" />
*
*	<p>A <a href="#ptnlib:term:meta:character" /> or <a href="#ptnlib:term:meta:sequence" />
*	that provides are shortcut for one or more characters. The most powerful of which is the
*	<a href="#ptnlib:term:dot" />.</p>
*	
*	<h3>dot</h3>
*	<a name="#ptnlib:term:dot" />
*
*	<p>A <a href="#ptnlib:term:meta:character" /> <code>'.'</code> that
*	indicates a <a href="#ptnlib:term:match" /> against (nearly)
*	any <a href="#ptnlib:term:character" />. The <em>dot</em>
*	<a href="#ptnlib:term:meta:character" /> will match <em>all characters</em>
*	when the <a href="#ptnlib:term:flags:dotall" /> flag has been specified.</p>
*
*	<h2>flags</h2>
*	<a name="#ptnlib:term:flags" />
*
*	<p>A sequence of single <a href="#ptnlib:term:meta:character" /> <em>flags</em>
*	that modify the behaviour of an entire regular expression. In the context of
*	a <a href="#ptnlib:term:pattern:implementation" /> the <em>flags</em> are said
*	to apply to a <a href="#ptnlib:term:rule" />.</p>
*
*	<p>The list of defined <em>flags</em> are:</p>
*
*	<ul>
*		<li><code>x</code> -- The <a href="#ptnlib:term:flag:extended" /> flag.</li>
*		<li><code>m</code> -- The <a href="#ptnlib:term:flag:multiline" /> flag.</li>
*		<li><code>i</code> -- The <a href="#ptnlib:term:flag:ignore:case" /> flag.</li>
*		<li><code>g</code> -- The <a href="#ptnlib:term:flag:global" /> flag.</li>
*		<li><code>s</code> -- The <a href="#ptnlib:term:flag:dotall" /> flag.</li>
*	</ul>
*
*	<p>Any unknown <a href="#ptnlib:term:meta:character" /> flags may be removed by a
*	<a href="#ptnlib:term:pattern:implementation" />.</p>
*
*	<h3>extended</h3>
*	<a name="#ptnlib:term:flag:extended" />
*
*	<p>The <code>extended</code> flag <code>'x'</code> is used to indicate
*	that a regular expression include literal whitespace. When this
*	flag is set, literal whitespace is ignored when matching.</p>
*
*	<p>This allows for more readable regular expressions.</p>
*
*	<pre>var re:RegExp = /    (\d{2})    (\s*\w{2}\s*)    (\d{2})    /x;</pre>
*
*	<p>Note that the ability to use a new-line character in an extended regular
*	expression will depend upon the <a href="#ptnlib:term:environment" />.</p>
*
*	<h3>multiline</h3>
*	<a name="#ptnlib:term:flag:multiline" />
*
*	<p>The <code>multiline</code> flag <code>'m'</code> is used to
*	indicate that the <a href="#ptnlib:term:caret" /> and <a href="#ptnlib:term:dollar" />
*	in a regular expression <a href="#ptnlib:term:match" /> before and after new lines.</p>
*
*	<h3>ignore case</h3>
*	<a name="#ptnlib:term:flag:ignore:case" />
*
*	<p>The <code>ignoreCase</code> flag <code>'i'</code> is used to indicate that
*	a <a href="#ptnlib:term:match" /> should be performed in a case-insensitive manner.</p>
*
*	<h3>global</h3>
*	<a name="#ptnlib:term:flag:global" />
*
*	<p>The <code>global</code> flag <code>'g'</code> is used to indicate that
*	a <a href="#ptnlib:term:match" /> is <em>global in scope</em>.</p>
*
*	<h3>dotall</h3>
*	<a name="#ptnlib:term:flag:dotall" />
*
*	<p>The <code>dotall</code> flag <code>'s'</code> is used to indicate that
*	the <a href="#ptnlib:term:dot" /> character in a regular expression pattern
*	matches new-line characters.</p>
*
*	<h2>value</h2>
*	<a name="#ptnlib:term:value" />
*
*	<p>Any primitive or complex type defined by a programming language.</p>
*
*	<h2>string</h2>
*	<a name="#ptnlib:term:string" />
*
*	<p>A literal expression or instance of a complex object used by a programming language
*	to represent a sequence of characters.</p>
*
*	<p>In Actionscript the <code>String</code> class.</p>
*
*	<h2>primitive</h2>
*	<a name="#ptnlib:term:primitive" />
*
*	<p>Any <a href="#ptnlib:term:value" /> that is not an <a href="#ptnlib:term:object" />
*	or <a href="#ptnlib:term:string" />.</p>
*
*	<h2>tree</h2>
*	<a name="#ptnlib:term:tree" />
*
*	<p>A hierarchical relationship that could be expressed as <code>XML</code>.</p>
*
*	<h2>object</h2>
*	<a name="#ptnlib:term:object" />
*
*	<p>A <a href="#ptnlib:term:value" /> in a programming language that allows
*	for the definition of a <a href="#ptnlib:term:property" />.</p>
*
*	<p>An <em>object</em> <em>is inherently a</em> <a href="#ptnlib:term:tree" />.</p>
*
*	<h2>property</h2>
*	<a name="#ptnlib:term:property" />
*
*	<p>A named <a href="#ptnlib:term:value" /> assigned to an <a href="#ptnlib:term:object" />.</p>
*
*	<h2>field</h2>
*	<a name="#ptnlib:term:field" />
*
*	<p>The <a href="#ptnlib:term:string" /> name of the <a href="#ptnlib:term:property" />
*	of an <a href="#ptnlib:term:object" />.</p>
*
*	<h2>list</h2>
*	<a name="#ptnlib:term:list" />
*
*	<p>An <a href="#ptnlib:term:object" /> in a programming language that stores
*	a sequential collection of <a href="#ptnlib:term:object" />(s).</p>
*
*	<h2>source expression</h2>
*	<a name="#ptnlib:term:source:expression" />
*
*	<p>An expression that defines a <a href="#ptnlib:term:pattern" />,
*	either a <code>RegExp</code> or <code>String</code> in Actionscript.</p>
*
*	<h2>target</h2>
*	<a name="#ptnlib:term:target" />
*
*	<p>A <em>target</em> is any <a href="#ptnlib:term:value" />
*	that a <a href="#ptnlib:term:pattern:implementation" /> is
*	attempting to <a href="#ptnlib:term:match" />.</p>
*
*	<h2>match</h2>
*	<a name="#ptnlib:term:match" />
*
*	<p>The process of comparing a <a href="#ptnlib:term:pattern" />
*	to a <a href="#ptnlib:term:target" />.</p>
*
*	<h2>occurence</h2>
*	<a name="#ptnlib:term:occurence" />
*
*	<p>The powerful ability of regular expressions to express the
*	<a href="#ptnlib:term:minimum" /> and <a href="#ptnlib:term:maximum" />
*	<em>number of times</em> a preceding <a href="#ptnlib:term:statement" />
*	can <em>occur</em> using a <a href="#ptnlib:term:quantifier" />.</p>
*
*	<h2>pattern list</h2>
*	<a name="#ptnlib:term:pattern:list" />
*
*	<p>A sequential collection of <a href="#ptnlib:term:zero" /> or
*	more <a href="#ptnlib:term:pattern" /> declarations.</p>
*
*	<h2>pattern tree</h2>
*	<a name="#ptnlib:term:pattern:tree" />
*
*	<p>A <a href="#ptnlib:term:tree" /> of one or more <a href="#ptnlib:term:pattern" /> declarations
*	created based on the <a href="#ptnlib:term:group" /> (and any
*	<a href="#ptnlib:term:implicit:group" />) declarations contained in
*	a <a href="#ptnlib:term:source:expression" />.</p>
*
*	<h2>compile</h2>
*	<a name="#ptnlib:term:compile" />
*
*	<p>The process of converting a <a href="#ptnlib:term:source:expression" />
*	to a <a href="#ptnlib:term:pattern:tree" />.</p>
*
*	<h2>statement</h2>
*	<a name="#ptnlib:term:statement" />
*
*	<p>A <a href="#ptnlib:term:group" />, <a href="#ptnlib:term:range" />
*	or <a href="#ptnlib:term:character:sequence" />.</p>
*
*	<h2>meta</h2>
*	<a name="#ptnlib:term:meta" />
*
*	<p>Any <a href="#ptnlib:term:meta:character" /> or <a href="#ptnlib:term:meta:sequence" />.</p>
*
*	<h3>meta character</h3>
*	<a name="#ptnlib:term:meta:character" />
*
*	<p>A single character that has special
*	meaning in a <a href="#ptnlib:term:pattern" />.</p>
*
*	<h3>meta sequence</h3>
*	<a name="#ptnlib:term:meta:sequence" />
*
*	<p>A sequence of two or more characters
*	that have special meaning in a <a href="#ptnlib:term:pattern" />.</p>
*
*	<h3>caret</h3>
*	<a name="#ptnlib:term:caret" />
*
*	<p>The <code>'^'</code> <a href="#ptnlib:term:meta:character" /> that when specified
*	at the beginning of a <a href="#ptnlib:term:rule" /> indicates that a <a href="#ptnlib:term:match" />
*	must exist at the beginning of a <a href="#ptnlib:term:target" />.</p>
*
*	<p>When specified as the <em>first character</em> of a <a href="#ptnlib:term:range" />
*	it creates a <a href="#ptnlib:term:negated:range" />.</p>
*
*	<h3>dollar</h3>
*	<a name="#ptnlib:term:dollar" />
*
*	<p>The <code>'$'</code> <a href="#ptnlib:term:meta:character" /> that when specified
*	as the final character of a <a href="#ptnlib:term:rule" /> indicates that a <a href="#ptnlib:term:match" />
*	must exist at the end of a <a href="#ptnlib:term:target" />.</p>
*
*	<p>Declared any other part of an <a href="#ptnlib:term:expression" /> this <a href="#ptnlib:term:meta:character" />
*	holds no special meaning.</p>
*
*	<h2>grouping</h2>
*	<a name="#ptnlib:term:grouping" />
*
*	<p>A <a href="#ptnlib:term:meta:character" /> used to indicate the start
*	of a <em>grouping</em> followed by a <a href="#ptnlib:term:pattern" /> and terminated
*	by a <a href="#ptnlib:term:meta:character" /> used to indicate the end of a
*	<em>grouping</em>.</p>
*
*	<p>Available groupings are defined as:</p>
*
*	<ul>
*		<li><code>()</code> -- A <a href="#ptnlib:term:group" />.</li>
*		<li><code>[]</code> -- A <a href="#ptnlib:term:range" />.</li>
*		<li><code>{}</code> -- A <a href="#ptnlib:term:quantifier:range" />.</li>
*		<li><code>&lt;&gt;</code> -- A <a href="#ptnlib:term:field:grouping" />.</li>
*	</ul>
*
*	<p>Only a <a href="#ptnlib:term:group" /> allows for the <em>grouping</em>
*	to be nested: <code>/([0-9]+([a-z]+))/</code>.</p>
*
*	<h3>field grouping</h3>
*	<a name="#ptnlib:term:field:grouping" />
*
*	<p>A <a href="#ptnlib:term:field" /> encapsulated by <code>&lt;&gt;</code>.</p>
*
*	<h2>group</h2>
*	<a name="#ptnlib:term:group" />
*
*	<p>A <a href="#ptnlib:term:pattern" /> encapsulated using parentheses.</p>
*
*	<pre>/([a-z])/</pre>
*
*	<p>In the context of a <em>group</em>, a <a href="#ptnlib:term:field" />
*	is synonymous with the <em>group name</em>.</p>
*
*	<h3>qualifier</h3>
*	<a name="#ptnlib:term:group:qualifier" />
*
*	<p>A <a href="#ptnlib:term:meta:sequence" /> that <em>qualifies</em>
*	the behaviour of a group.</p>
*
*	<ul>
*		<li><code>?:</code> -- The <a href="#ptnlib:term:non:capturing:qualifier" />.</li>
*		<li><code>?=</code> -- The <a href="#ptnlib:term:positive:lookahead:qualifier" />.</li>
*		<li><code>?!</code> -- The <a href="#ptnlib:term:negative:lookahead:qualifier" />.</li>
*		<li><code>?P</code> -- The <a href="#ptnlib:term:named:qualifier" />.</li>
*	</ul>
*
*	<h3>non-capturing qualifier</h3>
*	<a name="#ptnlib:term:non:capturing:qualifier" />
*
*	<p>The <a href="#ptnlib:term:meta:sequence" /> <code>'?:'</code> declared immediately
*	after the left parentheses <code>'('</code> used to declare the start of a <a href="#ptnlib:term:group" />.</p>
*
*	<p>This <em>qualifier</em> indicates that the result of a <a href="#ptnlib:term:match" />
*	(against this <a href="#ptnlib:term:group" />) should
*	be discarded, the <a href="#ptnlib:term:group" /> is said to be <em>non-capturing</em>.</p>
*
*	<h3>positive lookahead qualifier</h3>
*	<a name="#ptnlib:term:positive:lookahead:qualifier" />
*
*	<p>The <a href="#ptnlib:term:meta:sequence" /> <code>'?='</code> declared immediately
*	after the left parentheses <code>'('</code> used to declare the start of a <a href="#ptnlib:term:group" />.</p>
*
*	<h3>negative lookahead qualifier</h3>
*	<a name="#ptnlib:term:negative:lookahead:qualifier" />
*
*	<p>The <a href="#ptnlib:term:meta:sequence" /> <code>'?!'</code> declared immediately
*	after the left parentheses <code>'('</code> used to declare the start of a <a href="#ptnlib:term:group" />.</p>
*
*	<h3>named qualifier</h3>
*	<a name="#ptnlib:term:named:qualifier" />
*
*	<p>The <a href="#ptnlib:term:meta:sequence" /> <code>'?P'</code> declared immediately
*	after the left parentheses <code>'('</code> indicating the
*	start of a <a href="#ptnlib:term:named:group" />.</p>
*
*	<h3>named group</h3>
*	<a name="#ptnlib:term:named:group" />
*
*	<p>A <a href="#ptnlib:term:group" /> that has been assigned 
*	a <a href="#ptnlib:term:named:qualifier" /> and a <a href="#ptnlib:term:field:grouping" />
*	which declares the <em>group name</em>.</p>
*
*	<pre>/(?P&lt;id&gt;[a-zA-Z0-9]+)/</pre>
*
*	<p>In the above example <code>id</code> is the name of the <a href="#ptnlib:term:group" />
*	<em>and</em> the <a href="#ptnlib:term:field" />. The expression <code>[a-zA-Z0-9]+</code>
*	within the group is the <em>pattern list</em>.</p>
*
*	<p>It is this <a href="#ptnlib:term:string" /> (<code>id</code>) that defines both the
*	<em>group name</em> and the <a href="#ptnlib:term:field" /> of a <a href="#ptnlib:term:target" />
*	that a <a href="#ptnlib:term:match" /> should be performed against.</p>
*
*	<h3>implicit group</h3>
*	<a name="#ptnlib:term:implicit:group" />
*
*	<p>An <em>implicit group</em> is a <a href="#ptnlib:term:group" /> that
*	has <em>not been declared</em> that if created
*	would not alter the meaning of the <a href="#ptnlib:term:expression" />.</p>
*
*	<pre>/(a|b|c(d))/</pre>
*
*	<p>In this case <code>a|b|c</code> is the <em>implicit group</em> and the entire
*	<a href="#ptnlib:term:pattern" /> could be represented with additional
*	<a href="#ptnlib:term:group" /> declarations without altering the meaning:</p>
*
*	<pre>/((a|b|c)(d))/</pre>
*
*	<h2>range</h2>
*	<a name="#ptnlib:term:range" />
*
*	<p>A character class <a href="#ptnlib:term:pattern" />.</p>
*
*	<pre>/[0-9]/</pre>
*
*	<h2>negated range</h2>
*	<a name="#ptnlib:term:negated:range" />
*
*	<p>A character class that has been negated by specifying the
*	<a href="#ptnlib:term:caret" /> <code>'^'</code> at the <em>beginning of the
*	character class</em>.</p>
*
*	<pre>/[^0-9]/</pre>
*
*	<h2>quantifier</h2>
*	<a name="#ptnlib:term:quantifier" />
*
*	<p>A <a href="#ptnlib:term:meta:sequence" /> that indicates the minimum and
*	maximum number of occurences for a preceding <a href="#ptnlib:term:statement" />.</p>
*
*	<p>Includes the <a href="#ptnlib:term:meta:character" /> <em>quantifiers</em>
*	<a href="#ptnlib:term:wildcard" />, <a href="#ptnlib:term:plus" />,
*	<a href="#ptnlib:term:optionality" /> and the <a href="#ptnlib:term:quantifier:range" />.</p>
*
*	<h3>minimum</h3>
*	<a name="#ptnlib:term:minimum" />
*
*	<p>The pseudo property of a <a href="#ptnlib:term:quantifier" /> that indicates the minimum
*	number of occurences for a preceding <a href="#ptnlib:term:statement" />.</p>
*
*	<h3>maximum</h3>
*	<a name="#ptnlib:term:maximum" />
*
*	<p>The pseudo property of a <a href="#ptnlib:term:quantifier" /> that indicates the maximum
*	number of occurences for a preceding <a href="#ptnlib:term:statement" />.</p>
*
*	<h3>unlimited</h3>
*	<a name="#ptnlib:term:unlimited" />
*
*	<p>Refers to the perceived ability of a <a href="#ptnlib:term:quantifier" /> to match
*	an <em>unlimited</em> number of times.</p>
*
*	<p>In reality in would be nonsense for an implementation to allow for the infinite loop
*	that this could create so an unsigned integer should be used to represent this limit.</p>
*
*	<p>The actual limitation in the Actionscript implementation is equaivalent to
*	<code>uint.MAX_VALUE</code>.</p>
*
*	<h3>zero</h3>
*	<a name="#ptnlib:term:zero" />
*
*	<p>Refers to the ability of a <a href="#ptnlib:term:quantifier" /> to indicate
*	that a preceding statement is optional, that is to say, it may not occur at
*	all when matching is performed.</p>
*
*	<h3>wildcard</h3>
*	<a name="#ptnlib:term:wildcard" />
*
*	<p>The <code>'&#42;'</code> character used to indicate that a preceding
*	<a href="#ptnlib:term:statement" /> can occur <em>zero or an
*	unlimited number of times</em>.</p>
*
*	<pre>/[a-z]&#42;/</pre>
*
*	<h3>plus</h3>
*	<a name="#ptnlib:term:plus" />
*
*	<p>The <code>'&#43;'</code> character used to indicate that a preceding
*	<a href="#ptnlib:term:statement" /> can occur <em>once or an
*	unlimited number of times</em>.</p>
*
*	<pre>/[a-z]&#43;/</pre>
*
*	<h3>optionality</h3>
*	<a name="#ptnlib:term:optionality" />
*
*	<p>The <code>'?'</code> character used to indicate that a preceding
*	<a href="#ptnlib:term:statement" /> can occur <em>zero</em> or <em>once</em>.</p>
*
*	<pre>/[a-z]?/</pre>
*
*	<h3>quantifier range</h3>
*	<a name="#ptnlib:term:quantifier:range" />
*
*	<p>A <a href="#ptnlib:term:quantifier" /> that defines an explicit <a href="#ptnlib:term:minimum" /> and
*	optional <a href="#ptnlib:term:maximum" /> number of occurences for a preceding
*	<a href="#ptnlib:term:statement" /> conforming to the syntax:</p>
*
*	<pre>{n}
*	{n,n}
*	{n,}</pre>
*
*	<p>For example:</p>
*
*	<pre>/[a-z]{2}/       //exactly 2 occurences
*	/[a-z]{2,4}/     //minimum 2 occurences and maximum 4 occurences
*	/[a-z]{2,}/      //minimum 2 occurences and an unlimited maximum</pre>
*
*	<h2>data</h2>
*	<a name="#ptnlib:term:data" />
*
*	<p>A <a href="#ptnlib:term:character:sequence" /> that may contain zero
*	or more <a href="#ptnlib:term:inline:character:quantifier" /> occurences.</p>
*
*	<p>This type of <a href="#ptnlib:term:pattern" /> may have a <a href="#ptnlib:term:quantifier" />
*	at the end (or in between) but should never have a <a href="#ptnlib:term:quantifier" />
*	at the beginning that applies to a <a href="#ptnlib:term:group" /> or
*	<a href="#ptnlib:term:range" /> preceding the <a href="#ptnlib:term:quantifier" />.</p>
*
*	<h3>character</h3>
*	<a name="#ptnlib:term:character" />
*
*	<p>Any single character that is not a
*	meta character or meta sequence.</p>
*
*	<h3>character sequence</h3>
*	<a name="#ptnlib:term:character:sequence" />
*
*	<p>A sequence of one or more characters
*	that are not a meta character or meta sequence.</p>
*
*	<h3>character quantifier</h3>
*	<a name="#ptnlib:term:character:quantifier" />
*
*	<p>A <a href="#ptnlib:term:quantifier" /> that applies to a preceding
*	<a href="#ptnlib:term:character" />.</p>
*
*	<pre>/alpha+/</pre>
*
*	<h3>inline character quantifier</h3>
*	<a name="#ptnlib:term:inline:character:quantifier" />
*
*	<p>A <a href="#ptnlib:term:quantifier" /> that appears between a <a href="#ptnlib:term:character:sequence" />
*	and another <a href="#ptnlib:term:character:sequence" />.</p>
* 
*	<pre>/alpha+numeric/</pre>
*
*	<h1>Design Goals</h1>
*	<a name="#ptnlib:design:goals" />
*
*	<h2>Regular Expression Grammar Compliance</h2>
*	<a name="#ptnlib:regex:grammar:compliance" />
*
*	<p>The primary design goal was to <em>not deviate</em> from
*	regular expression syntax whilst allowing matching
*	against primitive and complex types <em>in addition</em> to the
*	string matching that regular expressions were originally designed for.</p>
*
*	<h2>Complete Grammar Representation</h2>
*	<a name="#ptnlib:regex:grammar:representation" />
*
*	<p>A pattern library implementation should understand the regular expression
*	grammar completely as a pattern tree, even if certain parts of the
*	grammar are superficial to the matching requirements defined by this specification.</p>
*
*	<p>This helps to future-proof the library for any further matching requirements.</p>
*
*	<h2>Language Neutrality</h2>
*	<a name="#ptnlib:language:neutrality" />
*
*	<p>The pattern library specification has been designed
*	to be language neutral so that the same API can be
*	ported to any language capable of implementing this specification.</p>
*
*	<h1>Match Definitions</h1>
*	<a name="#ptnlib:pattern:match:definitions" />
*
*	<p>A summary of definitive <a href="#ptnlib:term:match" /> use cases that the pattern library <em>must fulfill</em>
*	in order of perceived complexity from simplest to most complex:</p>
*
*	<ul>
*		<li>Match a <a href="#ptnlib:term:string" /> -- standard regular expression behaviour.</li>
*		<li>Match a <a href="#ptnlib:term:primitive" />, it is acceptable to coerce the <a href="#ptnlib:term:primitive" /> to a <a href="#ptnlib:term:string" /> and <a href="#ptnlib:term:match" /> against the resulting <a href="#ptnlib:term:string" />.</li>
*		<li>Match the <a href="#ptnlib:term:field" />(s) of <a href="#ptnlib:term:object" />(s).</li>
*		<li>Match the <a href="#ptnlib:term:field" />(s) of <a href="#ptnlib:term:object" />(s) that occur in a <a href="#ptnlib:term:list" />, including <a href="#ptnlib:term:occurence" /> matching.</li>
*		<li>Match against a <a href="#ptnlib:term:target" /> treating it as a <a href="#ptnlib:term:tree" /> and performing the <a href="#ptnlib:term:match" /> against nested <a href="#ptnlib:term:field" />(s).</li>
*	</ul>
*
*	<h1>Representation</h1>
*
*	<p>All patterns can be represented as a string
*	or regular expression and as an <code>XML</code>
*	tree structure.</p>
*
*	<p>The following example demonstrates the ability
*	to easily interchange the representation of a pattern
*	starting from a regular expression literal to
*	a <code>String</code> through to the <code>XML</code>
*	representation of a pattern.</p>
*
*	<pre>default xml namespace = Pattern.NAMESPACE;
*	var re:RegExp = /^[0-9]{10,11}$/;
*	var source:String = re.source;
*	var ptn:Pattern = new Pattern( re, true );
*	var xml:XML = ptn.xml;	
*	Assert.assertEquals( source, ptn.source );
*	Assert.assertEquals( source, ptn.toString() );
*	Assert.assertEquals( source, ptn.regex.source );
*	Assert.assertEquals( source, xml.source.text()[0] );</pre>
*
*	<p>Generates an <code>XML</code> representation of:</p>
*
<pre>&lt;ptn:rule
  xmlns:ptn="http://pattern.freeformsystems.com"
  begins="true"
  ends="true"&gt;
  &lt;ptn:source&gt;&lt;![CDATA[^[0-9]{10,11}$]]&gt;&lt;/ptn:source&gt;
  &lt;ptn:patterns&gt;
    &lt;ptn:meta&gt;&lt;![CDATA[^]]&gt;&lt;/ptn:meta&gt;
    &lt;ptn:range
        negated="false"
        lazy="false"
        min="10"
        max="11"
        quantifier="{10,11}"&gt;
        &lt;![CDATA[[0-9]]]&gt;
    &lt;/ptn:range&gt;
    &lt;ptn:meta&gt;&lt;![CDATA[$]]&gt;&lt;/ptn:meta&gt;
  &lt;/ptn:patterns&gt;
&lt;/ptn:rule&gt;</pre>
*
*	<h1>Primitive Matching</h1>
*
*	<p>In the simplest case a pattern can be used for matching primitive values:</p>
*
*	<pre>var ptn:Pattern = new Pattern( /^[0-9]+$/, true );
*	Assert.assertTrue( ptn.test( "100" ) );
*	Assert.assertTrue( ptn.test( 100 ) );
*	ptn = new Pattern( /^(true|false)$/, true );
*	Assert.assertTrue( ptn.test( true ) );
*	Assert.assertTrue( ptn.test( false ) );
*	Assert.assertFalse( ptn.test( "TRUE" ) );
*	Assert.assertFalse( ptn.test( "FALSE" ) );</pre>
*
*	<p>You could leverage this to test a <code>uint</code> or <code>int</code>
*	falls within a range:</p>
*
*	<pre>//define a 100-199 range
*	var ptn:Pattern = new Pattern( /^1[0-9]{2}$/, true );
*	Assert.assertTrue( ptn.test( 100 ) );
*	Assert.assertTrue( ptn.test( 199 ) );
*	Assert.assertFalse( ptn.test( 0 ) );
*	Assert.assertFalse( ptn.test( 99 ) );
*	Assert.assertFalse( ptn.test( 200 ) );
*	Assert.assertFalse( ptn.test( 1024 ) );</pre>
*
*	<p>Or quickly verify a number is a float:</p>
*
*	<pre>//define a float pattern
*	var ptn:Pattern = new Pattern( /^([0-9]+)?\.[0-9]+$/, true );
*	Assert.assertTrue( ptn.test( .5 ) );
*	Assert.assertTrue( ptn.test( 1.67 ) );
*	Assert.assertFalse( ptn.test( 16 ) );</pre>
*
*	<h1>Named Groups</h1>
*
*	<p>Let's demonstrate how we leverage an Actionscript specific regular expression
*	feature to allow complex object comparison.</p>
*
*	<pre>(?P&lt;id&gt;[_a-zA-Z$]{1}[a-zA-Z0-9]&#42;)</pre>
*
*	<p>In this example we declare a <em>named capturing group</em>. The
*	<code>?P</code> after the start of the group declares the group
*	as named and the <em>group name</em> value is contained
*	within the <code>&lt;&gt;</code> characters which in
*	this case is <code>id</code>.</p>
*	
*	<p>The rest of the group pattern is normal regular expression syntax.</p>
*
*	<p>This ability to name groups is an extension to the ECMAScript specification
*	that enables us to <em>think about regular expressions differently</em>. Instead
*	of seeing a <em>named capture group</em> we can view the same expression
*	as an object with a property named <code>id</code> which should match
*	the expression contained within the group.</p>
*
*	<p>This shift of perspective is great as it creates the basis for
*	matching against complex object structures but there is still another
*	issue to handle first: how to resolve the <em>object property field name</em>
*	for the various matching requirements?</p>
*
*	<h1>Field Matching</h1>
*
*	<p>To illustrate with a concrete example, consider a description
*	for a UK physical address, this may have various fields that require validation,
*	described as an anonymous object it might look like:</p>
*
*	<pre>{
*	  name: "Building name",
*	  number: "Building number",
*	  address1: "Address line 1",
*	  address2: "Address line 2",
*	  city: "City",
*	  county: "County",
*	  postcode: "Postal code"
*	}</pre>
*
*	<p>We could express the validation rules (for illustration purposes only) as a pattern
*	such as:</p>
*
*	<pre>var source:String =
*		"(?P&lt;name&gt;\\w( \\w)+)"
*		+ "(?P&lt;number&gt;\\d+[a-zA-Z]?)"
*		+ "(?P&lt;address1&gt;\\w( \\w)+)"
*		+ "(?P&lt;address2&gt;\\w( \\w)+)"
*		+ "(?P&lt;city&gt;\\w( \\w)+)"
*		+ "(?P&lt;county&gt;\\w( \\w)+)"
*		+ "(?P&lt;postcode&gt;)[a-zA-Z]{1,2}[0-9a-zA-Z]{1,2}( [0-9]{1,2}[a-zA-Z]{1,2})?";
*	//create the compiled pattern
*	var ptn:Pattern = new Pattern( source, true );</pre>
*
*	<p>This attempt to define the validation rules for our address object does describe
*	(approximately) the patterns for each field value but it omits some other relationships
*	such as that <code>name</code> and <code>number</code> should be treated as mutually exclusive
*	and that the field <code>address2</code> is optional.</p>
*
*	<p>We can update our source description to reflect these rules, first use alternation
*	to make the <code>name</code> and <code>number</code> mutually exclusive and
*	then use the <code>?</code> quantifier to make <code>address2</code> optional.
*	The updated source pattern would look like:</p>
*
*	<pre>var source:String =
*		"((?P&lt;name&gt;\\w( \\w)+)"
*		+ "|(?P&lt;number&gt;\\d+[a-zA-Z]?))"  //alternation between name and number '|'
*		+ "(?P&lt;address1&gt;\\w( \\w)+)"
*		+ "(?P&lt;address2&gt;\\w( \\w)+)?"     //added optionality to address2 '?'
*		+ "(?P&lt;city&gt;\\w( \\w)+)"
*		+ "(?P&lt;county&gt;\\w( \\w)+)"
*		+ "(?P&lt;postcode&gt;)[a-zA-Z]{1,2}[0-9a-zA-Z]{1,2}( [0-9]{1,2}[a-zA-Z]{1,2})?";</pre>
*
*	<p>You can then <code>validate</code> this pattern rule against any arbitrary object
*	representing an address:</p>
*
*	<pre>var matched:Boolean = ptn.test( address );</pre>
*
*	<h1>Sequence Matching</h1>
*
*	<p>The above example serves to illustrate validating value objects but there are other
*	use cases that need to be handled gracefully. For example, during a scan routine
*	a series of tokens for a scan part may be created <em>as a list</em>, but no validation of token
*	<em>value</em> or <em>occurence</em> has been performed.</p>
*
*	<p>Let's supposed you've created a scanner to tokenize an <code>XML</code> document
*	(maybe for a SAX implementation) and have a token to represent the name
*	of an <code>XML</code> element.</p>
*
*	<p>The pattern decribing an <code>XML</code> element name could be expressed approximately as:</p>
*
*	<pre>var source:String =
*		"(?P&lt;nsprefix&gt;([a-zA-Z0-9\\-]:)?)"
*		+ "(?P&lt;localname&gt;[a-zA-Z0-9\\-]+)";
*	var ptn:Pattern = new Pattern( source, true );</pre>
*
*	<p>Your scanner implementation recognises the element name pattern and correctly and
*	creates a token to represent the element name as part of a sequence of tokens
*	that represent the start of an <code>XML</code> element. That is the job complete
*	for the scanner, but the namespace prefix for the element name has not been
*	validated and verification that the element name tokens are all declared
*	correctly has not been performed.</p>
*
*	<p>We could express an approximation of the entire pattern for the start
*	of an <code>XML</code> element as:</p>
*
*	<pre>var source:String =
*		"(?P&lt;opentag&gt;&lt;\\s&#42;)"
*		+ "(?P&lt;nsprefix&gt;[a-zA-Z0-9\\-]+:)?"
*		+ "(?P&lt;localname&gt;[a-zA-Z0-9\\-]+)"
*		+ "(?P&lt;attr&gt;\\s&#42;(?P&lt;attrname&gt;[a-zA-Z0-9\\-]+)"
*		+ "(?P&lt;assignment&gt;={1})"
*		+ "(?P&lt;attrvalue&gt;(\"|')[^\"']&#42;(\"|')))&#42;"
*		+ "(?P&lt;closetag&gt;\\s&#42;/?&gt;)";</pre>
*
*	<p>If we assign token identifiers to the pattern groups:</p>
*
*	<pre>opentag: 1
*	nsprefix: 2
*	localname: 3
*	attr: 4
*	closetag: 5</pre>
*
*	<p>Then the expected token relationship could be expressed more succinctly as:</p>
*	
*	<pre>(1){1}(2)?(3){1}(4)&#42;(5){1}</pre>
*
*	<p>Which states that we expect a single open tag character '&lt;' followed by an optional
*	namespace prefix 'nsprefix:' followed by the local name of the element 'localname'
*	followed by zero or more attribute declarations 'attr="value"' and finally the '&gt;'
*	character indicating the end of the element statement (optionally terminated with '/').
*	Which should match element declarations such as:</p>
*
*	<pre>&lt;localname /&gt;
*	&lt;nsprefix:localname /&gt;
*	&lt;nsprefix:localname attr="value"&gt;</pre>
*
*	<p>Now suppose that you would like to validate that the general structure of
*	the element declaration conforms to the rules described above.
*	The general pattern for validating the <em>token list</em> would be:</p>
*
*	<pre>(?P&lt;id&gt;1){1}(?P&lt;id&gt;2)?(?P&lt;id&gt;3){1}(?P&lt;id&gt;4)&#42;(?P&lt;id&gt;5){1}</pre>
*
*	<p>Note that the <code>id</code> property names correspond to the <code>id</code> property
*	of a <code>Token</code>.</p>
*
*	<p>Assuming you have determined the list of namespace prefixes that are currently
*	valid you can modify this pattern to include the namespace requirements.
*	Assuming that namespace prefixes of <code>svg</code> and <code>fluid</code>
*	are currently valid namespace prefixes we could modify the pattern to:</p>
*
*	<pre>var ptn:Pattern = new Pattern(
*	  "(?P&lt;id&gt;1){1}"
*	  + "((?P&lt;id&gt;2)(?P&lt;matched&gt;(svg|fluid):))?"
*	  + "(?P&lt;id&gt;3){1}(?P&lt;id&gt;4)&#42;(?P&lt;id&gt;5){1}", true );</pre>
*
*	<p>By adding a nested grouping for the <code>Token.matched</code> property,
*	the <code>matched</code> property is also tested for adherence to
*	<code>/(svg|fluid):/</code> thereby validating the statement conforms to
*	the currently declared namespaces.</p>
*
*	<p>To perform this style of sequential match against a list, use the <code>list</code>
*	method:</p>
*
*	<pre>var tokens:Vector.&lt;Token&gt; = new Vector.&lt;Token&gt;();
*	// ...configure token list here
*	var matched:Boolean = ptn.list( tokens );</pre>
*
*	<h1>Compiler</h1>
*	<a name="#ptnlib:compiler" />
*
*	<p>A <em>pattern compiler</em> has the following responsibilities:</p>
*
*	<ul>
*		<li>Enfore groups -- create groups for any sequences that are not already grouped that require grouping for tree analysis.</li>
*		<li>Tree analysis -- create a tree structure representation of the pattern based on the group declarations.</li>
*	</ul>
*
*	<h1>Usage Notes</h1>
*	<a name="#ptnlib:usage:notes" />
*
*	<p>Groups are very important to the pattern recognition logic used when compiling a pattern
*	so it is recommended that you always declare groups in pattern expressions.</p>
*
*	@appendix
*
*	<h2>IDL Defintitions</h2>
*	<a name="#ptnlib:idl:definitions" />
*
*	<p>This section defines the contract for a
*	#ptnlib:term:pattern:implementation; using the [WEBIDL] grammar.</p>
*
*	<h3>!Pattern</h3>
*	<a name="#ptnlib:idl:pattern" />
*
*	<pre>
*	interface Pattern : Node {
*	    const unsigned long RULE_LIST_TYPE								= 1;
*	    const unsigned long RULE_TYPE									= 2;
*	    const unsigned long GROUP_TYPE									= 4;
*	    const unsigned long RANGE_TYPE        							= 8;
*	    const unsigned long CHARACTER_CLASS_TYPE        				= 16;
*	    const unsigned long QUANTIFIER_TYPE								= 32;
*	    const unsigned long DATA_TYPE									= 64;
*	    const unsigned long MODIFIER_TYPE        						= 128;
*	    const unsigned long META_TYPE        							= 256;

*	    const DOMString NAMESPACE_PREFIX								= 64;
*	    const DOMString NAMESPACE_URI        							= 128;
*	}
*	</pre>
*
*	<h2>Implementation Notes</h2>
*	<a name="#ptnlib:implementation:notes" />
*
*	<p>In order for a compiler to capture a correct tree analysis for the pattern
*	it must group sequences that are not already grouped, therefore it is inherently
*	more efficient if these #ptnlib:term:group;(s) are always declared in the #ptnlib:term:source:expression;,
*	see <a href="#ptnlib:usage:notes" />.</p>
*/
package com.ffsys.pattern
{
	/**
	* 	Represents a regular expression pattern.
	* 
	* 	This implementation allows for matching against complex
	* 	object structures using a regular expression.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class Pattern extends PatternList
	{	
		/*
		*	TYPE CONSTANTS (uint)
		*/
		
		/**
		* 	Represents a rule list type.
		*/
		public static const RULE_LIST_TYPE:uint = 1;
		
		/**
		* 	Represents a #ptnlib:term:rule; type.
		*/
		public static const RULE_TYPE:uint = 2;
		
		/**
		* 	Represents a #ptnlib:term:group; type.
		*/
		public static const GROUP_TYPE:uint = 4;
		
		/**
		* 	Represents a #ptnlib:term:range; type.
		*/
		public static const RANGE_TYPE:uint = 8;
		
		/**
		* 	Represents a #ptnlib:term:character:class; type.
		*/
		public static const CHARACTER_CLASS_TYPE:uint = 16;
		
		/**
		* 	Represents a #ptnlib:term:quantifier type.
		*/
		public static const QUANTIFIER_TYPE:uint = 32;
		
		/**
		* 	Represents character data type.
		*/
		public static const DATA_TYPE:uint = 64;
		
		/**
		* 	Represents a #ptnlib:term:modifier; type.
		*/
		public static const MODIFIER_TYPE:uint = 128;
		
		/**
		* 	Represents any other #ptnlib:term:meta:character; or #ptnlib:term:meta:sequence; type.
		*/
		public static const META_TYPE:uint = 256;
		
		/*
		*	NAMESPACE CONSTANTS (String/Namespace)
		*/
		
		/**
		* 	The pattern namespace prefix.
		*/
		public static const NAMESPACE_PREFIX:String = 
			"ptn";
			
		/**
		* 	The pattern namespace <code>URI</code>.
		*/
		public static const NAMESPACE_URI:String = 
			"http://pattern.freeformsystems.com";
		
		/**
		* 	The namespace used when creating <code>XML</code>
		* 	representations of a pattern.
		*/
		public static const NAMESPACE:Namespace = new Namespace(
			NAMESPACE_PREFIX,
			NAMESPACE_URI );
			
		/*
		*	META SEQUENCE CONSTANTS (String)
		*/
						
		/**
		* 	@private
		* 
		* 	A meta character that indicates
		* 	the start position or negation
		* 	when specified as the first character
		* 	in a character class.
		*/
		public static const CARET:String = "^";
		
		/**
		* 	@private
		* 
		* 	Represents a wildcard character.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates
		* 	zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates one
		* 	or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates zero or one occurence
		* 	or as a greedy behaviour modifier.
		*/
		public static const QUESTION_MARK:String = "?";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates alternation.
		*/
		public static const PIPE:String = "|";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates a character range.
		* 
		* 	Only applicable within character classes.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end position.
		*/
		public static const DOLLAR:String = "$";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start of a group.
		*/
		public static const LPAREN:String = "(";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end of a group.
		*/
		public static const RPAREN:String = ")";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start of a
		* 	character class.
		*/
		public static const LBRACKET:String = "[";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end of a
		* 	character class.
		*/
		public static const RBRACKET:String = "]";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start
		* 	of a qualifier range.
		*/
		public static const LBRACE:String = "{";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end
		* 	of a qualifier range.
		*/
		public static const RBRACE:String = "}";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start
		* 	of a name for a named group.
		*/
		public static const LESS_THAN:String = "<";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end
		* 	of a name for a named group.
		*/
		public static const GREATER_THAN:String = ">";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	positive lookahead group.
		*/
		public static const POSITIVE_LOOKAHEAD_SEQUENCE:String = "?=";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	negative lookahead group.
		*/
		public static const NEGATIVE_LOOKAHEAD_SEQUENCE:String = "?!";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	non-capturing group.
		*/
		public static const NON_CAPTURING_SEQUENCE:String = "?:";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	named group.
		*/
		public static const NAMED_GROUP_SEQUENCE:String = "?P";
		
		/*
		*	FLAG CONSTANTS (char)
		*/
		
		/**
		* 	@private
		* 
		*	Represents the <code>g</code> flag, the
		* 	<code>global</code> property.
		*/
		public static const GLOBAL_FLAG:String = "g";
		
		/**
		* 	@private
		* 
		*	Represents the <code>s</code> flag, the
		* 	<code>dotall</code> property.
		*/
		public static const DOTALL_FLAG:String = "s";
		
		/**
		* 	@private
		* 
		*	Represents the <code>x</code> flag, the
		* 	<code>extended</code> property.
		*/
		public static const EXTENDED_FLAG:String = "x";
		
		/**
		* 	@private
		* 
		*	Represents the <code>m</code> flag, the
		* 	<code>multiline</code> property.
		*/
		public static const MULTILINE_FLAG:String = "m";
		
		/**
		* 	@private
		* 
		*	Represents the <code>i</code> flag, the
		* 	<code>ignoreCase</code> property.
		*/
		public static const IGNORE_CASE_FLAG:String = "i";
		
		/**
		* 	A pattern representing the opening of a group.
		*/
		public static const OPEN_GROUP:Pattern =
			new Pattern( LPAREN );
			
		/*
		*	META SEQUENCE CONSTANTS (Pattern)
		*/
			
		/**
		* 	A pattern representing the closing of a group.
		*/
		public static const CLOSE_GROUP:Pattern =
			new Pattern( RPAREN );
		
		//
		private var _patterns:Vector.<Pattern>;
		private var _parts:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		private var _compiled:String;
		private var _open:Boolean = false;
		private var _type:uint;
		
		/**
		* 	@private
		* 
		* 	A minimum number of occurences for this pattern.
		*/
		internal var _min:Number = -1;
		
		/**
		* 	@private
		* 
		* 	A maximum number of occurences for this pattern.
		*/
		internal var _max:Number = -1;
		
		/**
		* 	Creates a <code>Pattern</code> instance.
		* 
		* 	@param source The source for the pattern.
		* 	@param compile Whether the source should
		* 	be compiled.
		*/
		public function Pattern(
			source:* = null, compile:Boolean = false )
		{
			super();
			if( compile === true )
			{
				this.compile( extractSource( source ) );
			}else{
				this.source = source;
			}
		}
		
		/**
		* 	Specifies whether the <code>g</code> flag is set.
		* 
		* 	Specifies whether to use global matching
		* 	for the regular expression.
		*/
		public function get global():Boolean
		{
			return this.regex.global;
		}
		
		/**
		* 	Specifies whether the <code>s</code> flag is set.
		* 	
		* 	When present indicates that the dot character (<code>.</code>)
		* 	in a regular expression pattern matches new-line characters.
		*/
		public function get dotall():Boolean
		{
			return this.regex.dotall;
		}
		
		/**
		* 	Specifies whether the <code>x</code> flag is set.
		* 
		* 	When present the regular expression will use extended mode.
		*/
		public function get extended():Boolean
		{
			return this.regex.extended;
		}
		
		/**
		* 	Specifies whether the <code>m</code> flag is set.
		* 	
		* 	If it is set, the caret (<code>^</code>) and dollar
		* 	sign (<code>$</code>) in a regular expression match
		* 	before and after new lines.
		*/
		public function get multiline():Boolean
		{
			return this.regex.multiline;
		}
		
		/**
		* 	Specifies whether the <code>i</code> flag is set.
		* 
		* 	When present the regular expression
		* 	ignores case sensitivity.
		*/
		public function get ignoreCase():Boolean
		{
			return this.regex.ignoreCase;
		}
		
		/**
		* 	The minimum number of occurences
		* 	for this pattern.
		*/
		public function get minimum():uint
		{
			if( quantifier )
			{
				if( _min == -1 )
				{
					_min = getOccurences().min;
				}
			}else
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				
				if( nextSibling != null
					&& nextSibling.quantifier )
				{
					_min = nextSibling.minimum;
				}
			}
			return _min;
		}
		
		/**
		* 	The maximum number of occurences
		* 	for this pattern.
		*/
		public function get maximum():uint
		{
			if( quantifier )
			{
				if( _max == -1 )
				{
					_max = getOccurences().max;
				}
			}else
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				if( nextSibling != null
					&& nextSibling.quantifier )
				{
					_max = nextSibling.maximum;
				}
			}		
			return _max;
		}
		
		/**
		*	Gets the qualifier for a group.
		* 
		* 	A qualifier for a group is a meta
		* 	character sequence that qualifies the 
		* 	group behaviour.
		* 
		* 	Valid values are the non-capturing qualifier (<code>?:</code>),
		* 	the positive lookahead qualifier (<code>?=</code>), the negative
		* 	lookahead qualifier (<code>?!</code>) and the named group qualifier
		* 	(<code>?P</code>).
		*/
		public function get qualifier():String
		{
			if ( source == POSITIVE_LOOKAHEAD_SEQUENCE
				|| source == NEGATIVE_LOOKAHEAD_SEQUENCE
				|| source == NON_CAPTURING_SEQUENCE
				|| source == NAMED_GROUP_SEQUENCE
				|| namedGroup )
			{
				return source;
			}
			return null;
		}
		
		/**
		* 	Determines whether this pattern is a named
		* 	group. A named group is a group that has been
		*	assigned a property name using the regular expression
		* 	syntax <code>(?P&lt;property&gt;)</code>.
		*/
		public function get namedGroup():Boolean
		{
			var src:String = toString();
			var namedStart:int = src.indexOf( LESS_THAN );
			var namedEnd:int = src.indexOf( GREATER_THAN );
			
			//TODO: test previous sibling is '?P'
			
			return ( namedStart == 0 && namedEnd == ( src.length - 1 ) );
		}
		
		/**
		* 	Determines whether this pattern
		* 	is quantifier meta data.
		* 
		* 	A quantifier is deemed to be a sequence
		* 	that affects the number of occurences for
		* 	a previous pattern.
		* 
		* 	@return Whether this pattern is a
		* 	quantifier.
		*/
		public function get quantifier():Boolean
		{
			return ( source != null
				&& ( __justquantity.test( source )
				|| quantifierRange ) );
		}
		
		/**
		* 	Determines whether this pattern is a quantifier
		* 	range, <code>{1,2}</code>.
		*/
		public function get quantifierRange():Boolean
		{
			return __quantifierRange.test( this.source );
		}		
		
		/**
		*	Determines whether a capture group
		* 	has a qualifier specified.
		*/
		public function get qualified():Boolean
		{
			if( group )
			{
				if( patterns.length > 1
					&& patterns[ 0 ].toString() == LPAREN
					&& patterns[ 1 ] is Pattern )
				{
					return ( patterns[ 1 ].qualifier != null );
				}
			}
			return false;
		}
		
		/**
		* 	Determines whether this is a lazy quantifier.
		* 
		* 	These are the <code>&#43;</code> and <code>&#42;</code>
		* 	operators whose behaviour has been modified from the
		* 	default greedy behaviour using the <code>?</code> meta
		* 	character.
		* 
		* 	Valid examples are <code>&#43;?</code> and <code>&#42;?</code>.
		* 
		* 	This lazy behaviour modifier only applies when a quantifier
		* 	allows for unlimited matches (only the &#42; and &#43; quantifiers)
		* 	and applying this to another quantifier is invalid.
		* 
		* 	For example, <code>??</code> and <code>{10,20}?</code> are meaningless because
		* 	both statements declare a fixed number of maximum possible matches,
		* 	one and twenty respectively.
		* 
		* 	Finally you can consider <code>{10,}?</code> as a valid use of the
		* 	lazy modifier as the quantifier range allows for unlimited maximum
		* 	matches.
		*/
		public function get lazy():Boolean
		{
			if( nextSibling != null
				&& nextSibling.quantifier )
			{
				return nextSibling.lazy;
			}
			return quantifier
				&& source != QUESTION_MARK
				&& ( ( source.indexOf( QUESTION_MARK ) == source.length - 1 )
				|| ( nextSibling != null
					&& nextSibling.source == QUESTION_MARK ) );
		}
		
		/**
		* 	Determines whether this pattern
		* 	represents a named capture group
		* 	declaration, <code>?P</code>.
		*/
		public function get named():Boolean
		{
			return source == NAMED_GROUP_SEQUENCE;
		}
		
		/**
		* 	Determines whether this pattern represents a
		* 	meta character sequence.
		*/
		public function get meta():Boolean
		{
			return isMetaSequence( this.source ) || shortcut;
		}
		
		/**
		* 	Determines whether this is a character match
		* 	data pattern.
		* 
		* 	A character match data pattern does not contain groups
		* 	or character classes buy may contain quantifiers that
		* 	apply to a preceding <em>character</em>.
		* 
		* 	This implies that quantifiers in data patterns may
		* 	be intermingled with other data elements and appear
		* 	at the end (apply to the last character), but may not
		* 	appear at the beginning of a data pattern
		* 	as the quantifier should be applied to the
		* 	preceding pattern.
		*/
		public function get data():Boolean
		{
			return !rule && !meta;
		}
		
		/**
		* 	The source for this pattern.
		*/
		public function get source():*
		{
			if( _source == null
				&& patterns != null )
			{
				_source = patterns.join( "," );
			}
			return _source;
		}
		
		public function set source( value:* ):void
		{
			extractSource( value );
			_source = value;
		}
		
		private function extractSource( value:* ):String
		{
			if( value is RegExp )
			{
				value = RegExp( value ).source;
				_regex = value as RegExp;
				//trace("Pattern::set source()", "[EXTRACTED REGEX SOURCE]", value );
			}
			return "" + value;
		}
		
		/**
		* 	The target property name when matching
		* 	pattern parts against complex objects.
		*/
		public function get field():String
		{
			return _field;
		}
		
		public function set field( value:String ):void
		{
			_field = value;
		}
		
		/**
		* 	All pattern parts as a flat list.
		*/
		public function get parts():Pattern
		{
			if( _parts == null )
			{
				_parts = new Pattern();
				_parts.name = PARTS;
			}
			return _parts;
		}
		
		/**
		* 	Determines whether this pattern
		* 	should match from the beginning
		* 	of a target being matched against.
		* 
		* 	Equivalent to a <code>^</code> at the beginning
		* 	of a regular expression.
		*/
		public function get begins():Boolean
		{
			return 	( rule && !empty && firstChild.source == CARET )
				||	( owner != null
					&& owner.rule
					&& source == CARET
					&& index == 0 );
		}
		
		/**
		* 	Determines whether this pattern
		* 	should match until the end
		*	of a target being matched against.
		* 
		* 	Equivalent to a <code>$</code> at the end
		* 	of a regular expression.
		*/
		public function get ends():Boolean
		{
			return 	( rule && !empty && lastChild.source == DOLLAR )
				||	( owner != null
					&& owner.rule
					&& source == DOLLAR
					&& ( index == owner.patterns.length - 1 ) );
		}
		
		/**
		* 	@private
		*/
		override public function clear():void
		{
			super.clear();
			_source = "";
			_compiled =  null;
			_parts = null;
		}
		
		/**
		* 	@private
		*/
		internal function match(
			pattern:Pattern, value:*, position:uint = 0 ):PatternMatch
		{
			var match:PatternMatch = new PatternMatch( position, pattern, value );
			var re:RegExp = pattern.regex;
			
			//compare against the source of other
			//regular expressions
			if( value is RegExp )
			{
				value = RegExp( value ).source;
			}
			
			//non-string primitive value
			//coerce to a string for comparison
			if( value is Number || value is Boolean )
			{
				//trace("[PRIMITIVE TEST] Pattern::test()", re, "" + value, re.test( "" + value ) );
				value = "" + value;
			}
			
			match.result = re.test( value as String );
			
			trace("[MATCH] Pattern::test()",
				value, re, re.test( value as String ), match.result );
			
			//add the match result to this pattern
			this[ position ] = match;
			return match;
		}
		
		/**
		* 	Tests whether the pattern matches
		* 	a value.
		* 
		* 	@param value The value to compare this pattern against.
		* 
		* 	@return Whether the pattern matches the value.
		*/
		override public function test( value:* ):Boolean
		{
			var matched:PatternMatch = null;
			
			//simple type so treat as a
			//single length match
			if( value is RegExp
				|| value is String
				|| value is uint
				|| value is int
				|| value is Number
				|| value is Boolean )
			{
				matched = match( this, value );
			//check for list/property matching
			}else if( value is Object )
			{
				return testObject( value as Object );
			}
			return matched.result;
		}
		
		/**
		* 	Validates a target object comparing the named
		* 	groups within this pattern against the properties
		* 	of the target object.
		* 
		* 	@param target The target object to validate.
		* 
		* 	@return Whether this pattern matched the target
		* 	object structure.
		*/
		public function validate( target:Object ):Boolean
		{
			var result:Boolean = false;
			if( target != null )
			{
				//TODO
			}
			return result;
		}
		
		/**
		* 	Performs matching against an array or vector.
		* 
		* 	@param target The target to match this pattern against.
		* 
		* 	@throws ArgumentError If the supplied target is not
		* 	an <code>Array</code> or <code>Vector</code>.
		* 
		* 	@return Whether the <code>target</code> list
		* 	matches this pattern.
		*/
		public function list( target:Object ):Boolean
		{
			if( !( ( target is Array ) || target is Vector ) )
			{
				throw new ArgumentError(
					"You must specify an array or vector when"
					+ " attempting to match a pattern against a list." );
			}
			//TODO
			return false;
		}
		
		/**
		* 	@private
		*/
		private function testObject( value:Object ):Boolean
		{
			//got a collection - should test against
			//the collection entries
			if( value is Array )
			{
				return compareList( value as Array );
			}else if( value is Vector )
			{
				return compareList( value as Vector );
			//non-collection object				
			}else if( value is Object )
			{
				return validate( value );
			}
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Compares a collection against the exploded
		* 	patterns.
		*/
		private function compareList( values:Object ):Boolean
		{
			//TODO: explode patterns and compare against the exploded parts
			
			//var tokens:Pattern = explode();
			
			var result:Boolean = false;
			var value:*;
			for( var i:int = 0;i < values.length;i++ )
			{
				value = values[ i ];
				result = compareObject( value );
				
				trace("Pattern::compareList()", value, result );
			}
			return result;
		}
		
		/**
		* 	@private
		*/
		private function compareObject( value:Object ):Boolean
		{
			var re:RegExp = this.regex;
			//comparing against an object property
			if( field != null && value.hasOwnProperty( field ) )
			{
				//access the underlying property and
				//coerce to a string
				value = "" + value[ field ];
			}else{
				//try to access an underlying primitive
				//value and coerce it to a string for comparison
				//when no field name is available
				value = "" + value.valueOf();
			}
			return re.test( "" + value );
		}
		
		/**
		* 	Returns a pattern that represents
		* 	the positional matches for this pattern.
		*/
		public function get positions():Pattern
		{
			return explode();
		}
		
		/**
		* 	Determines whether this pattern is grouping.
		* 
		* 	This will return <code>true</code> for groups
		* 	<code>()</code>, character classes <code>[]</code>,
		* 	quantifier ranges <code>{}</code> and group names
		* 	<code>&lt;&gt;</code>.
		* 
		* 	Comparison is performed on the first child and does not
		* 	imply that the grouping has been correctly closed.
		*/
		public function get grouping():Boolean
		{
			return length > 0
				&& __group.test( firstChild.toString() );
		}
		
		/**
		* 	Retrieves a group pattern.
		* 
		* 	@param name A name for the group.
		* 	@param contents A pattern containing patterns
		* 	to add as the contents of the group.
		* 	@param close Whether to close the group.
		* 
		* 	@return A group pattern.
		*/
		public function getGroup(
			name:String = null,
			contents:Pattern = null,
			close:Boolean = false ):Pattern
		{
			var grp:Pattern = new Pattern();
			grp.appendChild( OPEN_GROUP );
			if( contents != null )
			{
				//TODO
				//grp.concat( contents );
			}
			if( close === true )
			{
				grp.appendChild( CLOSE_GROUP );
			}
			return grp;
		}
		
		/**
		* 	Determines whether this pattern is a group.
		*/
		public function get group():Boolean
		{
			return this.grouping && ( firstChild.toString() == LPAREN );
		}
		
		/**
		* 	Retrieves all escape characters (<code>\</code>)
		* 	at the end of the source of this pattern.
		*/
		public function get escapes():String
		{
			var re:RegExp = /(\\+)$/;
			if( re.test( source ) )
			{
				var results:Array = re.exec( source );
				if( results != null && results[ 1 ] is String )
				{
					return results[ 1 ] as String;
				}
			}
			return null;
		}
		
		/**
		* 	Determines whether this pattern is an escape
		* 	sequence and would cancel the special meaning
		* 	of any subsequent pattern.
		*/
		public function get cancels():Boolean
		{
			return escapes != null
				&& ( escapes.length == 1
					|| escapes.length % 2 != 0 );
		}
		
		/**
		* 	Determines whether this pattern has any special
		* 	meaning cancelled by a preceding escape sequence.
		*/
		public function get cancelled():Boolean
		{
			if( previousSibling != null )
			{
				if( previousSibling.cancels )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	Determines whether this pattern represents
		* 	an escaped character class shortcut.
		*/
		public function get shortcut():Boolean
		{
			return isShortCut( this.source );
		}
		
		/**
		* 	@private
		*/
		override public function get children():PatternList
		{
			if( group )
			{
				var output:Pattern = new Pattern();
				var ptns:Vector.<Pattern> = this.patterns;
				var ptn:Pattern = null;
				for( var i:int = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					//remove all capture group qualifiers and open and close
					//patterns to get to the child patterns
					if( ( ptn.source == LPAREN && i == 0 )
						|| ( ptn.source == RPAREN && i == ptns.length - 1 )
						|| ptn.qualifier != null )
					{
						continue;
					}
					output.appendChild( ptn );
				}
				return output;
			}
			return super.children;
		}
		
		/**
		* 	Determines whether this pattern is a range
		* 	(character class), <code>[0-9]</code>.
		*/
		public function get range():Boolean
		{
			return ( source != null && source == LBRACKET )
				|| this.grouping && ( firstChild.toString() == LBRACKET );
		}
		
		/**
		* 	Determines whether this pattern is a character
		* 	range and is negated, <code>[^0-9]</code>.
		*/
		public function get negated():Boolean
		{
			return range
				&& firstChild != null
				&& firstChild.nextSibling != null
				&& firstChild.nextSibling.source == CARET;
		}
		
		/**
		* 	@private
		*/
		override public function get regex():RegExp
		{
			if( _regex == null )
			{
				if( patterns.length == 0 && _source == null )
				{
					_source = patterns.join( "" );
					_regex = new RegExp( this.source );
				}else{
					_regex = new RegExp( toString() );
				}
			}			
			return super.regex;
		}
		
		/**
		* 	The type for the pattern.
		*/
		public function get type():uint
		{
			return _type;
		}
		
		/**
		* 	@private
		*/
		internal function setType( value:uint ):void
		{
			_type = value;
		}
		
		/**
		* 	@private
		*/
		override public function get name():String
		{
			var nm:String = super.name;
			if( rule )
			{
				nm = RULE;
			}
			if( nm == null )
			{
				switch( source )
				{
					case PIPE:
						nm = ALTERNATOR_NAME;
						break;
				}
				if( nm == null )
				{
					if( group )
					{
						nm = GROUP_NAME;
					}else if( range )
					{
						nm = RANGE_NAME;
					}else if( quantifier )
					{
						nm = QUANTIFIER_NAME;
					}else if( meta )
					{
						nm = META_NAME;
					}else if( data )
					{
						nm = DATA_NAME;
					}
				}
			}
			return nm == null ? PATTERN : nm;
		}
		
		/**
		* 	@private
		*/
		
		/*
		override public function get xml():XML
		{
			//TODO: stash this XML and invalidate
			
			var i:int = 0;
			var name:String = this.name;
			var x:XML = getXmlElement();
			
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					x = getXmlElement( null, toString() );
				}
				if( range )
				{
					x.@negated = this.negated;
				}
			}
			
			//handle the output of pattern occurences.
			//groups proxy the corresponding value
			//for any subsequent quantifier or if
			//the group is not quantified reports
			//a count of one
			if( !quantifier
				&& nextSibling != null && nextSibling.quantifier )
			{
				x.@lazy = this.lazy;
				//single quantifier occurence amount
				if( this.minimum > -1
					&& this.maximum > -1
					&& this.minimum == this.maximum )
				{
					x.@count = this.minimum;
				}else
				{
					if( this.minimum > -1 )
					{
						x.@min = this.minimum;
					}
					if( this.maximum > -1 )
					{
						x.@max = this.maximum;
					}
				}
			}
			
			if( cancelled )
			{
				x.@cancelled = cancelled;
			}
			
			//shortcut out for simple types
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					return x;
				}
			}			
			
			//handle complex types
			var ptns:Vector.<Pattern> = this.patterns;
			var isGrouped:Boolean = !rule && group;
			if( isGrouped )
			{
				ptns = children.patterns;
			}
			
			if( isGrouped )
			{
				x.@qualified = this.qualified;
				if( field != null )
				{
					x.@field = this.field;
				}
			}
			
			if( rule || source == CARET || source == DOLLAR )
			{
				x.@begins = begins;
				x.@ends = ends;
			}
			
			if( rule )
			{			
				x.appendChild( getXmlElement( SOURCE, this.source ) );
				
				if( length > 0 )
				{
					var results:XML = getXmlElement( RESULTS );
					var match:PatternMatch = null;
					for( i = 0;i < length;i++ )
					{
						match = this[ i ] as PatternMatch;
						results.appendChild( match.xml );
					}
					x.appendChild( results );
				}
			}else
			{
				x.appendChild( getXmlElement( SOURCE, toString() ) );
			}
			
			if( ptns != null && ptns.length > 0 )
			{
				var children:XML = getXmlElement( PATTERNS );
				x.appendChild( children );
				var ptn:Pattern = null;
				var child:XML = null;
				var previous:XML = null;
				for( i = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					child = ptn.xml;
					
					//skip quantifier elements as
					//their values should be represented
					//by the preceding pattern they apply to
					if( !ptn.quantifier )
					{
						children.appendChild( child );
					}
					
					//apply the quantifier source as an
					//attribute of the preceding element
					if( ptn.quantifier
						&& previous != null )
					{
						previous.@quantifier = ptn.source;
					}
					previous = child;
				}
			}
			
			return x;
		}
		*/
		
		/**
		* 	@private
		*/
		override public function toPatternLiteral():String
		{
			var prefix:String = rule ? PATTERN : PTN;
			return prefix + ":" + DELIMITER + toString() + DELIMITER;
		}
		
		/**
		* 	@private
		*/
		override public function toString():String
		{
			var delimiter:String = "";
			if( name == PARTS )
			{
				delimiter = ",";
			}
			return patterns.length > 0 ? patterns.join( delimiter ) : _source;
		}
		
		/**
		* 	Compiles a source string into this pattern.
		* 
		* 	@param source The source string to compile.
		*/
		public function compile( source:String ):void
		{
			__compile( source );
		}
		
		/**
		* 	@private
		* 	
		* 	Compiles a string to a pattern.
		* 
		* 	Any existing patterns belonging to this pattern
		* 	are removed before attempting to compile.
		* 
		* 	@param candidate The string candidate to compile.
		* 	@param list Whether this pattern should be treated
		* 	as a tree rather than a list structure.
		* 	@param target An optional target to compile into,
		* 	if not specified the pattern is compiled into this
		* 	pattern.
		* 
		* 	@return A compiled pattern.
		*/
		private function __compile(
			candidate:String,
			target:Pattern = null ):Pattern
		{
			if( target == null )
			{
				target = this;
			}
			
			if( candidate != null )
			{
				clear();
				//copy the candidate to our source
				_source = candidate.substr();
				_compiled = candidate.substr();
				
				if( isMetaSequence( _compiled ) )
				{
					//nothing to build for meta character sequences
					return target;
				}
				
				var parentTarget:Pattern = target;
				var opens:Boolean = false;
				var closes:Boolean = false;
				var meta:String = null;
				var ptn:Pattern = null;
				var data:String = null;
				var tmp:Pattern = null;

				var current:Pattern = null;				
						
				trace("[COMPILE] PatternBuilder::compile()", _compiled );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";
				
				//meta sequences '\b', '\n' etc, etc
				
				var expr:String = "(?:" + __sequence + "|\\?!|\\?:|\\?=|\\?P|\\[|\\]|[()|^\\$<>]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( _compiled );
				
				//no regex special character match
				if( results == null )
				{
					ptn = new Pattern( _compiled );
					parentTarget.appendChild( ptn );
					parts.appendChild( ptn );
					return target;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					data = _compiled.substr( 0, results.index );
					ptn = getCompilationPattern( data );
					addCompilationPattern(
						parentTarget, ptn, true );
				}
				
				//grab the first pattern match
				if( results[ 1 ] is String )
				{
					ptn = getCompilationPattern( results[ 1 ] );
				}

				while( ptn != null )
				{
					opens = ptn.opens();
					closes = ptn.closes();
					
					if( opens
						&& parentTarget != null )
					{
						if( !( ptn.source == LESS_THAN ) )
						{
							addCompilationPart( ptn );
						}

						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = new Pattern( ptn.source );
						current.appendChild( ptn );
						current.setOpen( true );
						ptn = current;
					}else
					{
						if( ptn.qualifier == null
							&& !( ptn.source == GREATER_THAN ) )
						{
							addCompilationPart( ptn );
						}
					}
					
					//
					addCompilationPattern( parentTarget, ptn );
					
					if( opens )
					{
						//opening a group update the parent target *after* adding the group
						parentTarget = current;
					}
					
					//close an open group
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						parentTarget = Pattern( current.owner );
						current = parentTarget;
					}

					//look for the next meta character sequence
					//to extract any intermediary chunk
					var next:int = _compiled.search( re );
					if( next > 0 )
					{
						//extract the non-meta character chunk
						data = _compiled.substr( 0, next );
					
						if( __quantity.test( data ) )
						{
							results = __quantity.exec( data );
							var c:String = results[ 1 ] as String;
							var just:Boolean = __justquantity.test( data );
							
							//trace("Pattern::compile()", "[FOUND QUANTITY CHUNK]", data, results, c, just, ptn );
							
							//quantifier with chunk data after
							//a group or character class so
							//split into quantifier and remaining
							//chunk
							if( c != null
								&& results.index == 0
								&& !just
								&& (
									closes
									&& ptn.source == RPAREN
									|| ptn.source == RBRACKET ) )
							{
								//trace("Pattern::compile()", "[FOUND MIXED QUANTITY CHUNK]" );
								
								//add the quantifier part
								addCompilationPattern(
									parentTarget,
									getCompilationPattern( data.substr( 0, c.length ) ),
									true );
								
								//re-assign the current chunk value
								data = data.substr( c.length );
							}else if( just && c != null )
							{
								data = c;
							}
						}

						ptn = new Pattern( data );
						
						//trace("[COMPILE] Pattern::compile()", "[ADDING CHUNK]", data );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.grouping
							&& parentTarget.owner is Pattern
							&& parentTarget.firstChild != null
							&& parentTarget.firstChild.toString() == LESS_THAN )
						{	
							//assign the named property field to
							//the parent group
							Pattern( parentTarget.owner ).field = data;
						}else
						{
							addCompilationPart( ptn );
						}
						
						//add the chunk pattern
						addCompilationPattern( parentTarget, ptn );
					}
					
					//test for more meta sequences
					results = re.exec( _compiled );					
					ptn = null;
					if( results != null )
					{
						position = results.index;
						if( results[ 1 ] as String != null )
						{
							ptn = new Pattern(
								results[ 1 ] as String );
						}
					}
				}
			}
			return target;
		}
		
		/*
		*	COMPILATION INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether the last attempt
		* 	to compile a pattern completed successfully.
		*/
		internal function get compiled():Boolean
		{
			return _compiled != null
				&& _source != null
				&& _compiled == "";
		}
		
		/**
		* 	@private
		*/
		internal function getCompilationPattern(
			data:String ):Pattern
		{
			return new Pattern( data );
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPattern(
			parent:Pattern,
			ptn:Pattern,
			part:Boolean = false ):String
		{
			//chomp the matched string
			_compiled = _compiled.substr( ptn.source.length );
						
			//a cancelled meta character/sequence
			if( ptn.cancelled )
			{
				//fold into any previous character matching data
				//if we can
				if( ptn.previousSibling.data )
				{
					ptn.previousSibling.source += ptn.source;
					return _compiled;
				}else{
					//TODO?
					trace("Pattern::get compiled()", "[FOUND ESCAPED META SEQUENCE WITH NO PREVIOUS CHARACTER MATCH]", ptn );
				}
			}
			
			parent.appendChild( ptn );
			if( part )
			{
				addCompilationPart( ptn );
			}
			return _compiled;
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPart(
			ptn:Pattern ):Pattern
		{
			parts.appendChild( ptn );
			return parts;
		}
		
		/*
		*	GROUPING INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether this pattern is
		* 	currently open.
		* 
		* 	Used during the process of building
		* 	pattern representations from string
		* 	representations.
		*/
		internal function get open():Boolean
		{
			return _open;
		}
		
		/**
		* 	@private
		*/
		internal function setOpen( value:Boolean ):void
		{
			_open = value;
		}
		
		/**
		* 	@private
		* 
		* 	Determines whether this pattern
		* 	opens a grouping.
		* 
		* 	@return Whether this pattern opens a grouping.
		*/
		internal function opens():Boolean
		{
			var valid:Boolean = (
				source == Pattern.LPAREN
				|| source == Pattern.LBRACKET
				|| source == Pattern.LBRACE
				|| source == Pattern.LESS_THAN );	
			if( valid )
			{
				_open = true;
			}
			return valid;
		}
		
		/**
		* 	@private
		* 	
		* 	Determines whether the this pattern
		* 	closes a grouping.
		* 
		* 	@return Whether this pattern closes a grouping.
		*/
		internal function closes():Boolean
		{
			var valid:Boolean = (
				source == Pattern.RPAREN
				|| source == Pattern.RBRACKET
				|| source == Pattern.RBRACE
				|| source == Pattern.GREATER_THAN );			
			if( valid && _open )
			{
				_open = false;
			}
			return valid;
		}
		
		/*
		*	INTERNAL QUANTIFIER AMOUNT CALCULATION
		*/		
		
		/**
		* 	@private
		*/
		internal function getQuantifierRangeOccurences( tmp:String ):Object
		{
			var output:Object = new Object();
			output.min = _min;
			output.max = _max;
			tmp = tmp.replace( /\{/, "" );
			tmp = tmp.replace( /\}/, "" );
			var parts:Array = tmp.split( "," );
			if( output.min == -1 && parts.length >= 1 )
			{
				output.min = parseInt( parts[ 0 ] );
				if( parts.length == 1 )
				{
					output.max = output.min;
				}
			}
			if( output.max == -1 
				&& parts.length == 2 )
			{
				if( parts[ 1 ] == "" )
				{
					output.max = uint.MAX_VALUE;
				}else
				{
					output.max = parseInt( parts[ 1 ] );
				}
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		internal function getOccurences():Object
		{
			var floor:int = 0;
			var ceiling:int = uint.MAX_VALUE;
			var output:Object = new Object();
			output.min = _min;
			output.max = _max;
			var tmp:String = source.substr();
			
			//remove any lazy modifiers associated
			//with another quantifier before calculation
			if( tmp != QUESTION_MARK
				&& tmp.indexOf( QUESTION_MARK ) > -1 )
			{
				tmp = tmp.replace( /[?]+$/, "" );
			}
			
			if( quantifierRange && _min == -1 && _max == -1 )
			{
				output = getQuantifierRangeOccurences( tmp );
			}
			
			if( output.min == -1
				&& output.max == -1 )
			{
				var defined:Boolean = _min > 0 && _max > 0;
				if( !defined && quantifier )
				{
					switch( tmp )
					{
						case ASTERISK:
							output.min = floor;
							output.max = ceiling;
							break;
						case PLUS:
							output.min = 1;
							output.max = ceiling;
							break;
						case QUESTION_MARK:
							output.min = floor;
							output.max = 1;
							break;
					}
				}
			}
			_min = output.min;
			_max = output.max;
			return output;
		}
		
		
		/**
		* 	@private
		*/
		internal function requiresGrouping():Boolean
		{
			if( group )
			{
				//trace("[REQUIRES GROUPING] Pattern::requiresGrouping()", toString() );
				
				var ptns:PatternList = this.children;
				var ptn:Pattern = null;
				var groups:uint = 0;
				var alternators:uint = 0;
				for( var i:int = 0;i < ptns.length;i++ )
				{
					ptn = ptns.getPatternAt( i );
					if( ptn.group )
					{
						groups++;
					}
					
					if( ptn.source == PIPE )
					{
						alternators++;
					}
					//trace("Pattern::requiresGrouping()", "[TESTING CHILD PATTERN]", ptn, ptn.source, groups, alternators );
				}
				
				//empty capture group
				if( ptns.length == 0 )
				{
					return false;
				}
				
				//single nested pattern
				if( ptns.length == 1 )
				{
					//single group contents
					if( ptns.firstChild.group )
					{
						return false;
					//single chunk contents
					}else if( ptns.firstChild.data )
					{
						return false;
					}
				}				
				
				//complex child patterns
				if( groups > 0 && alternators > 0 )
				{
					return true;
				}
				
				if( groups == 0 && alternators > 0 )
				{
					return false;
				}
				
				//trace("[TESTING GROUPING REQUIREMENTS] Pattern::requiresGrouping()", ptns );
				return true;
			}
			return false;
		}
		
		/*
		*	INTERNAL GROUP MANIPULATION
		*/
		
		/**
		* 	Explodes this pattern into a tokenized
		* 	representation where each pattern part
		* 	represents an individual positional match.
		* 
		* 	@return A pattern representing this pattern
		* 	as patterns tokens for each position.
		*/
		private function explode(
			targets:Vector.<Pattern> = null,
			output:Pattern = null ):Pattern
		{
			if( output == null )
			{
				output = new Pattern();
			}
			
			if( targets == null )
			{
				targets = this.patterns;
			}
					
			var ptn:Pattern = null;
			var next:Pattern = null;
			var grp:Pattern = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				ptn = targets[ i ];
				
				if( ptn.group )
				{
					extract( ptn, output );
				}else
				{
					if( ptn.meta || ptn.data )
					{
						//convert plain patterns to groups
						grp = new Pattern();
						grp.appendChild( new Pattern( LPAREN ) );	
						grp.appendChild( ptn );
						
						//look ahead and swallow non-group patterns
						while( ++i < targets.length )
						{
							next = targets[ i ];
							if( next.group )
							{
								i--;
								break;
							}
							//close and re-open the group when
							//we encounter a range
							if( next.range )
							{
								//trace("[FOUND RANGE ADD TO PREVIOUS] Pattern::explode()", next, ptn, group );
								grp.appendChild( new Pattern( RPAREN ) );
								grp.appendChild( new Pattern( LPAREN ) );
								grp.appendChild( next );					
							}else
							{
								grp.appendChild( next );
								//trace("[FOUND QUANTIFIER/CHUNK ADD TO PREVIOUS] Pattern::explode()", next, ptn, grp );								
							}
						}
						grp.appendChild( new Pattern( RPAREN ) );
						output.appendChild( grp );
					}
				}
			}
			//trace("[EXPLODE] Pattern::explode()", output.patterns );
			return output;
		}	
		
		/**
		* 	@private
		*/
		private function extract( target:Pattern, output:Pattern ):Pattern
		{
			if( target.grouping
				&& target.group )
			{
				var ptns:Vector.<Pattern> = target.patterns;
				var ptn:Pattern = null;
				var named:Boolean = false;
				var next:Pattern = null;
				var grouped:Pattern = null;
				
				//skip the last part - the group close: ')'
				var l:int = ptns.length - 1;
				
				//skip the first part - the group open '('
				var i:int = 1;
				
				//trace("[EXTRACT] Pattern::extract()", target, target.field, target.field != null );
				
				var requiresGroup:Boolean = target.requiresGrouping();
				
				//trace("[TEST FOR ADDITIONAL GROUPING] Pattern::extract()", requiresGroup );
				
				if( requiresGroup )
				{
					output.appendChild( new Pattern( LPAREN ) );
				}
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = new Pattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.appendChild( new Pattern( LPAREN ) );
				
				//add the positional group to the output
				output.appendChild( tmp );
				
				for( ;i < l;i++ )
				{
					ptn = ptns[ i ];
					
					//trace("[EXTRACTING] Pattern::extract()", ptn );
					
					//ignore invalid patterns
					//and and group qualifiers: '?:', '?!', '?=', '?P'
					if( ptn == null
						|| ptn.qualifier != null )
					{
						//handle named groups: '?P<propertyName>'
						if( ptn.named )
						{
							//trace("[FOUND NAMED_GROUP_SEQUENCE GROUP] Pattern::extract()", ptn );

							//finished a named capture group
							if( i < ( ptns.length - 1 ) )
							{
								next = ptns[ i + 1 ];
								//found a named group declaration
								if( next.toString().indexOf( LESS_THAN ) == 0 )
								{
									//skip the named group part: <propertyName>
									i++;
								}
								
								//trace("[CLOSED NAMED_GROUP_SEQUENCE GROUP] Pattern::extract()", ptn );
							}		
						}
						continue;
					}
					
					//trace("[HANDLE EXTRACTION] Pattern::extract()", ptn, ptn.group );
					
					if( ptn.group )
					{
						//trace("Pattern::extract()", "[FOUND NESTED GROUP PATTERN]" );
						//handle nested groups
						//as we encounter them
						grouped = extract( ptn, output );
						
						//trace("[GOT EXTRACTED GROUP RESULT] Pattern::extract()", grouped, grouped.length - 2, i );
						
						//explode( output );
						
						break;
					}
					
					//add the part to the extracted group
					tmp.appendChild( ptn );	
				}
			}
			
			//close the temp group
			tmp.appendChild( new Pattern( RPAREN ) );
					
			if( i < ( l - 1 ) )
			{
				l = ptns.length;
				if( ptns[ l - 1 ] is Pattern
				 	&& ptns[ l - 1 ].source == RPAREN )
				{
					//ignore end group declarations
					l--;
				}
				
				var remainder:Vector.<Pattern> = ptns.slice( i + 1, l );
				
				/*
				trace("Pattern::extract()", "[FOUND MORE TO EXTRACT]", grouped,
					remainder );
				*/
				
				explode( remainder, output );
			}
			
			if( requiresGroup )
			{
				output.appendChild( new Pattern( RPAREN ) );
			}
			return tmp;
		}				
		
		/*
		*	INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether a string is considered
		* 	to be a meta character or meta sequence.
		* 
		* 	@param char The string to test against.
		* 
		* 	@return Whether the value is a meta character
		* 	or meta sequence.
		*/
		private function isMetaSequence( char:String ):Boolean
		{
			return char == POSITIVE_LOOKAHEAD_SEQUENCE
				|| char == NEGATIVE_LOOKAHEAD_SEQUENCE
				|| char == NON_CAPTURING_SEQUENCE
				|| char == NAMED_GROUP_SEQUENCE	
				|| char == CARET
				|| char == ASTERISK
				|| char == PLUS
				|| char == QUESTION_MARK
				|| char == DOLLAR
				|| char == PIPE
				|| char == LPAREN
				|| char == RPAREN
				|| char == LBRACE
				|| char == RBRACE
				|| char == LBRACKET
				|| char == RBRACKET
				|| char == LESS_THAN
				|| char == GREATER_THAN;			
		}
		
		/*
		*	REGEX INTERNALS
		*/
		
		/**
		* 	@private
		*/
		protected static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + LPAREN
			+ "|\\" + LBRACKET
			+ "|\\" + LBRACE
			+ "|\\" + LESS_THAN + ")"
		);		
	}
}