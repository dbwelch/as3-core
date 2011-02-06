/**
*	A library for pattern matching.
*
*	Use cases include scanner token validation or form field validation.
*
*	The primary design goal was to <em>not deviate</em> from
*	regular expression syntax while allowing matching
*	against primitive and complex types.
*
*	In addition the library has been designed to be as flexible as possible
*	so should suffice for nearly any matching requirement.
*
*	An understanding of regular expression syntax is assumed
*	for the rest of this documentation.
*
*	Note that when discussing quantifiers that have <em>unlimited</em>
*	or <em>infinite</em> maximum matches in reality there is a 
*	limit that corresponds to <code>uint.MAX_VALUE</code> but
*	for brevity's sake it's easier to describe them as <em>unlimited</em>.
*
*	<h1>Representation</h1>
*
*	All patterns can be represented as a string
*	or regular expression and as an <code>XML</code>
*	tree structure.
*
*	The following example demonstrates the ability
*	to easily interchange the representation of a pattern
*	starting from a regular expression literal to
*	a <code>String</code> through to the <code>XML</code>
*	representation of a pattern.
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
*	Generates an <code>XML</code> representation of:
*
*	<pre>&lt;pattern begins="true" ends="true"&gt;
*	  &lt;source&gt;&lt;![CDATA[^[0-9]{10,11}$]]&gt;&lt;/source&gt;
*	  &lt;patterns&gt;
*	    &lt;meta&gt;&lt;![CDATA[^]]&gt;&lt;/meta&gt;
*	    &lt;range
*	        negated="false"
*	        lazy="false" 
*	        min="10"
*	        max="11"
*	        quantifier="{11}"&gt;
*	        &lt;![CDATA[[0-9]]]&gt;
*	    &lt;/range&gt;
*	    &lt;meta&gt;&lt;![CDATA[$]]&gt;&lt;/meta&gt;
*	  &lt;/patterns&gt;
*	&lt;/pattern&gt;</pre>
*
*	<h1>Primitive Matching</h1>
*
*	In the simplest case a pattern can be used for matching primitive values:
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
*	You could leverage this to test a <code>uint</code> or <code>int</code>
*	falls within a range:
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
*	Or quickly verify a number is a float:
*
*	<pre>//define a float pattern
*	var ptn:Pattern = new Pattern( /^([0-9]+)?\.[0-9]+$/, true );
*	Assert.assertTrue( ptn.test( .5 ) );
*	Assert.assertTrue( ptn.test( 1.67 ) );
*	Assert.assertFalse( ptn.test( 16 ) );</pre>
*
*	<h1>Named Groups</h1>
*
*	Let's illustrate how we leverage an Actionscript specific regular expression
*	feature to allow complex object comparison.
*
*	<pre>(?P&lt;id&gt;[_a-zA-Z$]{1}[a-zA-Z0-9]&#42;)</pre>
*
*	In this example we declare a <em>named capturing group</em>. The
*	<code>?P</code> after the start of the group declares the group
*	as named and the <em>group name</em> value is contained
*	within the <code>&lt;&gt;</code> characters which in
*	this case is <code>id</code>.
*	
*	The rest of the group pattern is normal regular expression syntax.
*
*	This ability to name groups is an extension to the ECMAScript specification
*	that enables us to <em>think about regular expressions differently</em>. Instead
*	of seeing a <em>named capture group</em> we can view the same expression
*	as an object with a property named <code>id</code> which should match
*	the expression contained within the group.
*
*	This shift of perspective is great as it creates the basis for
*	matching against complex object structures but there is still another
*	issue to handle first: how to resolve the <em>object property field name (?P&lt;id&gt;)</em>
*	for the various matching requirements?
*
*	<h1>Field Matching</h1>
*
*	To illustrate with a concrete example, consider a description
*	for a UK physical address, this may have various fields that require validation,
*	described as an anonymous object it might look like:
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
*	We could express the validation rules (for illustration purposes only) as a pattern
*	such as:
*
*	<pre>var source:String =
*		"(?P&lt;name&gt;\w( \w)+)"
*		+ "(?P&lt;number&gt;\d+[a-zA-Z]?)"
*		+ "(?P&lt;address1&gt;\w( \w)+)"
*		+ "(?P&lt;address2&gt;\w( \w)+)"
*		+ "(?P&lt;city&gt;\w( \w)+)"
*		+ "(?P&lt;county&gt;\w( \w)+)"
*		+ "(?P&lt;postcode&gt;)[a-zA-Z]{1,2}[0-9a-zA-Z]{1,2}( [0-9]{1,2}[a-zA-Z]{1,2})?";
*	//create the compiled pattern
*	var ptn:Pattern = new Pattern( source, true );</pre>
*
*	This attempt to define the validation rules for our address object does describe
*	(approximately) the patterns for each field value but it omits some other relationships
*	such as that <code>name</code> and <code>number</code> should be treated as mutually exclusive
*	and that the field <code>address2</code> is optional.
*
*	We can update our source description to reflect these rules, first use alternation
*	to make the <code>name</code> and <code>number</code> mutually exclusive and
*	then use the <code>?</code> quantifier to make <code>address2</code> optional.
*	The updated source pattern would look like:
*
*	<pre>var source:String =
*		"((?P&lt;name&gt;\w( \w)+)"
*		+ "|(?P&lt;number&gt;\d+[a-zA-Z]?))"  //alternation between name and number '|'
*		+ "(?P&lt;address1&gt;\w( \w)+)"
*		+ "(?P&lt;address2&gt;\w( \w)+)?"     //added optionality to address2 '?'
*		+ "(?P&lt;city&gt;\w( \w)+)"
*		+ "(?P&lt;county&gt;\w( \w)+)"
*		+ "(?P&lt;postcode&gt;)[a-zA-Z]{1,2}[0-9a-zA-Z]{1,2}( [0-9]{1,2}[a-zA-Z]{1,2})?";</pre>
*
*	You can then <code>validate</code> this pattern rule against any arbitrary object
*	representing an address:
*
*	<pre>var valid:Boolean = ptn.test( address );</pre>
*
*	<h1>Sequence Matching</h1>
*
*	The above example serves to illustrate validating value objects but there are other
*	use cases that need to be handled gracefully. For example, during a scan routine
*	a series of tokens for a scan part may be created <em>as a list</em>, but no validation of token
*	<em>value</em> or <em>occurence</em> has been performed.
*
*	Let's supposed you've created a scanner to tokenize an <code>XML</code> document
*	(maybe for a SAX implementation) and have a token to represent the name
*	of an <code>XML</code> element.
*
*	The pattern decribing an <code>XML</code> element name could be expressed approximately as:
*
*	<pre>var source:String =
*		"(?P&lt;nsprefix&gt;([a-zA-Z0-9\\-]:)?)"
*		+ "(?P&lt;localname&gt;[a-zA-Z0-9\\-]+)";
*	var ptn:Pattern = new Pattern( source, true );</pre>
*
*	Your scanner implementation recognises the element name pattern and correctly and
*	creates a token to represent the element name as part of a sequence of tokens
*	that represent the start of an <code>XML</code> element. That is the job complete
*	for the scanner, but the namespace prefix for the element name has not been
*	validated and verification that the element name tokens are all declared
*	correctly has not been performed.
*
*	We could express an approximation of the entire pattern for the start
*	of an <code>XML</code> element as:
*
*	<pre>var source:String =
*		"(?P&lt;open-tag&gt;&lt;\\s&#42;)"
*		+ "(?P&lt;nsprefix&gt;([a-zA-Z0-9\\-]:)?)"
*		+ "(?P&lt;localname&gt;[a-zA-Z0-9\\-]+)"
*		+ "(?P&lt;attr&gt;\\s&#42;(?P&lt;attrname&gt;[a-zA-Z0-9\\-]+)"
*		+ "(?P&lt;assignment&gt;={1})"
*		+ "(?P&lt;attrvalue&gt;(\"|')[^\"']&#42;(\"|')))&#42;"
*		+ "(?P&lt;close-tag&gt;\\s&#42;/?&gt;)";</pre>
*
*	If we assign token identifiers to the pattern groups:
*
*	<pre>open-tag: 1
*	nsprefix: 2
*	localname: 3
*	attr: 4
*	close-tag: 5</pre>
*
*	Then the expected token relationship could be expressed more succinctly as:
*	
*	<pre>(1){1}(2)?(3){1}(4)&#42;(5){1}</pre>
*
*	Which states that we expect a single open tag character '&lt;' followed by an optional
*	namespace prefix 'nsprefix:' followed by the local name of the element 'localname'
*	followed by zero or more attribute declarations 'attr="value"' and finally the '&gt;'
*	character indicating the end of the element statement (optionally terminated with '/').
*	Which should match element declarations such as:
*
*	<pre>&lt;localname /&gt;
*	&lt;nsprefix:localname /&gt;
*	&lt;nsprefix:localname attr="value"&gt;</pre>
*
*	Now suppose that you would like to validate that the general structure of
*	the element declaration conforms to the rules described above.
*	The general pattern for validating the <em>token list</em> would be:
*
*	<pre>(?P&lt;id&gt;1){1}(?P&lt;id&gt;2)?(?P&lt;id&gt;3){1}(?P&lt;id&gt;4)&#42;(?P&lt;id&gt;5){1}</pre>
*
*	Note that the <code>id</code> property names correspond to the <code>id</code> property
*	of a <code>Token</code>.
*
*	Assuming you have determined the list of namespace prefixes that are currently
*	valid you can modify this pattern to include the namespace requirements.
*	Assuming that namespace prefixes of <code>svg</code> and <code>fluid</code>
*	are currently valid namespace prefixes we could modify the pattern to:
*
*	<pre>var ptn:Pattern = new Pattern(
*	  "(?P&lt;id&gt;1){1}"
*	  + "((?P&lt;id&gt;2)(?P&lt;matched&gt;(svg|fluid):))?"
*	  + "(?P&lt;id&gt;3){1}(?P&lt;id&gt;4)&#42;(?P&lt;id&gt;5){1}", true );</pre>
*
*	By adding a nested grouping for the <code>Token.matched</code> property,
*	the <code>matched</code> property is also tested for adherence to
*	<code>/(svg|fluid):/</code> thereby validating the statement conforms to
*	the currently declared namespaces.
*
*	To perform this style of sequential match against a list, use the <code>list</code>
*	method:
*
*	<pre>var tokens:Vector.&lt;Token&gt; = new Vector.&lt;Token&gt;();
*	// ...configure token list here
*	var matched:Boolean = ptn.list( tokens );</pre>
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
	dynamic public class Pattern extends PatternSet
	{	
		/**
		* 	The namespace used when creating <code>XML</code>
		* 	representations of a pattern.
		*/
		public static const NAMESPACE:Namespace = new Namespace(
			"ptn",
			"http://pattern.freeformsystems.com" );
						
		/**
		* 	A meta character that indicates
		* 	the start position or negation
		* 	when specified as the first character
		* 	in a character class.
		*/
		public static const CARET:String = "^";
		
		/**
		* 	Represents a wildcard character.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	A quantifier character that indicates
		* 	zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	A quantifier character that indicates one
		* 	or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	A quantifier character that indicates zero or one occurence
		* 	or as a greedy behaviour modifier.
		*/
		public static const QUESTION_MARK:String = "?";
		
		/**
		* 	A meta character that indicates alternation.
		*/
		public static const PIPE:String = "|";
		
		/**
		* 	A meta character that indicates a character range.
		* 
		* 	Only applicable within character classes.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	A meta character that indicates the end position.
		*/
		public static const DOLLAR:String = "$";
		
		/**
		* 	A meta character that indicates the start of a group.
		*/
		public static const LPAREN:String = "(";
		
		/**
		* 	A meta character that indicates the end of a group.
		*/
		public static const RPAREN:String = ")";
		
		/**
		* 	A meta character that indicates the start of a
		* 	character class.
		*/
		public static const LBRACKET:String = "[";
		
		/**
		* 	A meta character that indicates the end of a
		* 	character class.
		*/
		public static const RBRACKET:String = "]";
		
		/**
		* 	A meta character that indicates the start
		* 	of a qualifier range.
		*/
		public static const LBRACE:String = "{";
		
		/**
		* 	A meta character that indicates the end
		* 	of a qualifier range.
		*/
		public static const RBRACE:String = "}";
		
		/**
		* 	A meta character that indicates the start
		* 	of a name for a named group.
		*/
		public static const LESS_THAN:String = "<";
		
		/**
		* 	A meta character that indicates the end
		* 	of a name for a named group.
		*/
		public static const GREATER_THAN:String = ">";
		
		/**
		*	The meta sequence representing a
		* 	positive lookahead group.
		*/
		public static const POSITIVE_LOOKAHEAD_SEQUENCE:String = "?=";
		
		/**
		*	The meta sequence representing a
		* 	negative lookahead group.
		*/
		public static const NEGATIVE_LOOKAHEAD_SEQUENCE:String = "?!";
		
		/**
		*	The meta sequence representing a
		* 	non-capturing group.
		*/
		public static const NON_CAPTURING_SEQUENCE:String = "?:";
		
		/**
		*	The meta sequence representing a
		* 	named group.
		*/
		public static const NAMED_GROUP_SEQUENCE:String = "?P";
		
		/**
		*	Represents the <code>g</code> flag, the
		* 	<code>global</code> property.
		*/
		public static const GLOBAL_FLAG:String = "g";
		
		/**
		*	Represents the <code>s</code> flag, the
		* 	<code>dotall</code> property.
		*/
		public static const DOTALL_FLAG:String = "s";
		
		/**
		*	Represents the <code>x</code> flag, the
		* 	<code>extended</code> property.
		*/
		public static const EXTENDED_FLAG:String = "x";
		
		/**
		*	Represents the <code>m</code> flag, the
		* 	<code>multiline</code> property.
		*/
		public static const MULTILINE_FLAG:String = "m";
		
		/**
		*	Represents the <code>i</code> flag, the
		* 	<code>ignoreCase</code> property.
		*/
		public static const IGNORE_CASE_FLAG:String = "i";
		
		private var _patterns:Vector.<Pattern>;
		private var _parts:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		private var _compiled:String;
		private var _open:Boolean = false;
		
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
		* 	The modifiers of the regular expression.
		* 
		* 	These can include the following:
		* 
		*	g - When using the replace() method of the String class, specify this
		* 	modifier to replace all matches, rather than only the first one.
		*	This modifier corresponds to the global property of the RegExp instance.
		* 
		*	i - The regular expression is evaluated without case sensitivity.
		* 	This modifier corresponds to the ignoreCase property of the RegExp instance.
		* 
		*	s - The dot (.) character matches new-line characters.
		* 	Note This modifier corresponds to the dotall property of the RegExp instance.
		* 
		*	m - The caret (^) character and dollar sign ($) match before and after new-line characters.
		* 	This modifier corresponds to the multiline property of the RegExp instance.
		* 
		*	x - White space characters in the re string are ignored, so that you can write more readable constructors.
		* 	This modifier corresponds to the extended property of the RegExp instance.
		* 
		*	All other characters in the flags string are ignored.
		*/
		public function get flags():String
		{
			var flags:String = "";
			if( global )
			{
				flags += GLOBAL_FLAG;
			}
			if( dotall )
			{
				flags += DOTALL_FLAG;
			}
			if( extended )
			{
				flags += EXTENDED_FLAG;
			}
			if( multiline )
			{
				flags += MULTILINE_FLAG;
			}
			if( ignoreCase )
			{
				flags += IGNORE_CASE_FLAG;
			}						
			return flags;
		}
		
		public function set flags( value:String ):void
		{
			if( value == null )
			{
				value = "";
			}
			value = value.replace( /[^xmigs]/, "" );
			//regex is invalidated on flag change
			_regex = new RegExp( this.regex.source, value );
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
			}else if( group || range )
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
			}else if( group || range )
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
			if( group || range
				&& ( nextSibling != null
				&& nextSibling.quantifier ) )
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
			return isMetaSequence( this.source );
		}
		
		/**
		* 	Determines whether this is a pattern
		* 	part that does not contain any special
		* 	characters.
		*/
		public function get chunk():Boolean
		{
			return !root && !meta;
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
				//TODO: extract flags
				trace("Pattern::set source()", "[EXTRACTED REGEX SOURCE]", value );
			}
			
			return "" + value;
		}
		
		/**
		* 	A next sibling pattern if available.
		*/
		public function get nextSibling():Pattern
		{
			try
			{
				return this.owner.patterns[ this.index + 1 ];
			}catch( e:Error )
			{
				//no valid owner or index is out of range
			}
			return null;
		}
		
		/**
		* 	A previous sibling pattern if available.
		*/
		public function get previousSibling():Pattern
		{
			try
			{
				return this.owner.patterns[ this.index - 1 ];
			}catch( e:Error )
			{
				//no valid owner or index is out of range
			}			
			return null;
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
			return 	( root && !empty && firstChild.source == CARET )
				||	( owner != null
					&& owner.root
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
			return 	( root && !empty && lastChild.source == DOLLAR )
				||	( owner != null
					&& owner.root
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
			pattern:Pattern, value:*, position:uint = 0 ):PatternMatchResult
		{
			var match:PatternMatchResult = new PatternMatchResult( position, pattern, value );
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
			var matched:PatternMatchResult = null;
			
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
		*/
		public function get grouping():Boolean
		{
			return patterns.length > 0
				&& __group.test( firstChild.toString() );
		}
		
		/**
		* 	Determines whether this pattern is a group.
		*/
		public function get group():Boolean
		{
			return this.grouping && ( firstChild.toString() == LPAREN );
		}
		
		/**
		* 	@private
		*/
		override public function get children():Pattern
		{
			if( group )
			{
				//TODO: stash this and invalidate	
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
					output.add( ptn );
				}
				return output;
			}
			return null;
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
		* 	@private
		*/
		override public function get name():String
		{
			var nm:String = super.name;
			if( nm == null )
			{
				switch( source )
				{
					case PIPE:
						nm = "alternator";
						break;
					case DOT:
						nm = "dot";
						break;
				}
				if( nm == null )
				{
					if( group )
					{
						nm = "group";
					}else if( range )
					{
						nm = "range";
					}else if( quantifier )
					{
						nm = "quantifier";
					}else if( meta )
					{
						nm = "meta";
					}else if( chunk )
					{
						nm = "data";
					}
				}
			}
			return nm == null ? "pattern" : nm;
		}
		
		/**
		* 	@private
		*/
		override public function get xml():XML
		{
			//TODO: stash this XML and invalidate
			
			var i:int = 0;
			var name:String = this.name;
			var x:XML = getXmlElement();
			
			if( !root && !group )
			{	
				if( range || meta || chunk )
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
			if( quantifier || range || group )
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
			
			//shortcut out for simple types
			if( !root && !group )
			{	
				if( range || meta || chunk )
				{
					return x;
				}
			}			
			
			//handle complex types
			var ptns:Vector.<Pattern> = this.patterns;
			var isGrouped:Boolean = !root && group;
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
			
			if( root || source == CARET || source == DOLLAR )
			{
				x.@begins = begins;
				x.@ends = ends;
			}
			
			if( root )
			{			
				x.appendChild( getXmlElement( SOURCE, this.source ) );
				
				if( length > 0 )
				{
					var results:XML = getXmlElement( RESULTS );
					var match:PatternMatchResult = null;
					for( i = 0;i < length;i++ )
					{
						match = this[ i ] as PatternMatchResult;
						results.appendChild( match.xml );
					}
					x.appendChild( results );
				}
			}else
			{
				//x.appendChild( new XML( "<source><![CDATA[" + toString() + "]]></source>" ) );
				
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
					//by the preceeding pattern they apply to
					if( !ptn.quantifier )
					{
						children.appendChild( child );
					}
					
					//apply the quantifier source as an
					//attribute of the preceeding element
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
		
		/**
		* 	@private
		*/
		override public function toPatternString():String
		{
			var prefix:String = root ? PATTERN : PTN;
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
		* 	Determines whether the last attempt
		* 	to compile a pattern completed successfully.
		*/
		public function get compiled():Boolean
		{
			return _compiled != null
				&& _source != null
				&& _compiled == "";
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
			tree:Boolean = true,
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
				var chunk:String = null;
				var tmp:Pattern = null;

				var current:Pattern = null;				
						
				trace("[CANDIDATE] PatternBuilder::build()", _compiled );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";
				
				var expr:String = "\\\\?(?:\\?!|\\?:|\\?=|\\?P|\\[|\\]|[()|^\\$:<>.\\-]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( _compiled );
				
				//no regex special character match
				if( results == null )
				{
					ptn = new Pattern( _compiled );
					parentTarget.add( ptn );
					parts.add( ptn );
					return target;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					chunk = _compiled.substr( 0, results.index );
					ptn = getCompilationPattern( chunk );
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
						current.add( ptn );
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
						
						if( tree )
						{
							parentTarget = current;
						}
					}
					
					//close an open group
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						
						//only manipulate the parent target
						//when building tree structures
						if( tree )
						{
							parentTarget = Pattern( current.owner );
						}
						current = parentTarget;
					}

					//look for the next meta character sequence
					//to extract any intermediary chunk
					var next:int = _compiled.search( re );
					if( next > 0 )
					{
						//extract the non-meta character chunk
						chunk = _compiled.substr( 0, next );
					
						if( __quantity.test( chunk ) )
						{
							results = __quantity.exec( chunk );
							var c:String = results[ 1 ] as String;
							var just:Boolean = __justquantity.test( chunk );
							
							//trace("Pattern::compile()", "[FOUND QUANTITY CHUNK]", chunk, results, c, just, ptn );
							
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
									getCompilationPattern( chunk.substr( 0, c.length ) ),
									true );
								
								//re-assign the current chunk value
								chunk = chunk.substr( c.length );
							}else if( just && c != null )
							{
								chunk = c;
							}
						}

						ptn = new Pattern( chunk );
						
						//trace("[COMPILE] Pattern::compile()", "[ADDING CHUNK]", chunk );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.grouping
							&& parentTarget.owner is Pattern
							&& parentTarget.firstChild != null
							&& parentTarget.firstChild.toString() == LESS_THAN )
						{	
							//assign the named property field to
							//the parent group
							Pattern( parentTarget.owner ).field = chunk;
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
		*/
		internal function getCompilationPattern(
			chunk:String ):Pattern
		{
			return new Pattern( chunk );
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPattern(
			parent:Pattern,
			ptn:Pattern,
			part:Boolean = false ):String
		{
			parent.add( ptn );
			if( part )
			{
				addCompilationPart( ptn );
			}
			_compiled = _compiled.substr( ptn.source.length );
			return _compiled;
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPart(
			ptn:Pattern ):Pattern
		{
			parts.add( ptn );
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
				
				var ptns:Pattern = this.children;
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
					}else if( ptns.firstChild.chunk )
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
					if( ptn.meta || ptn.chunk )
					{
						//convert plain patterns to groups
						grp = new Pattern();
						grp.add( new Pattern( LPAREN ) );	
						grp.add( ptn );
						
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
								grp.add( new Pattern( RPAREN ) );
								grp.add( new Pattern( LPAREN ) );
								grp.add( next );					
							}else
							{
								grp.add( next );
								//trace("[FOUND QUANTIFIER/CHUNK ADD TO PREVIOUS] Pattern::explode()", next, ptn, grp );								
							}
						}
						grp.add( new Pattern( RPAREN ) );
						output.add( grp );
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
					output.add( new Pattern( LPAREN ) );
				}
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = new Pattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.add( new Pattern( LPAREN ) );
				
				//add the positional group to the output
				output.add( tmp );
				
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
					tmp.add( ptn );	
				}
			}
			
			//close the temp group
			tmp.add( new Pattern( RPAREN ) );
					
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
				output.add( new Pattern( RPAREN ) );
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
		
		private static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + LPAREN
			+ "|\\" + LBRACKET
			+ "|\\" + LBRACE
			+ "|\\" + LESS_THAN + ")"
		);		

		private static var __quantifierRangeExpr:String =
			"(?:\\{(?:[0-9]+)(?:,[0-9]*)?\\})";
		
		private static var __quantifierRange:RegExp =
			new RegExp( "^(" + __quantifierRangeExpr + ")+$" );
				
		private static var __quantifiers:String =
			"(?:" + __quantifierRangeExpr + "|\\*|\\+|\\?){1}"
			+ "(?:\\?)?";	//additional lazy quantifier
		
		private static var __quantity:RegExp = new RegExp( "(" + __quantifiers + ")" );
		private static var __justquantity:RegExp = new RegExp( "^(" + __quantifiers + ")$" );
	}
}