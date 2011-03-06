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
package java.util.regex
{
	/**
	* 	The specification for a Pattern DOM implementation.
	*/
	public class PatternSpecification extends Object
	{
		//
	}
}