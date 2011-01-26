package com.ffsys.token
{
	/**
	*	A tokenizer for css documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	public class CssTokenizer extends Tokenizer
	{
		/**
		* 	The identifier for an ident token.
		*/
		public static const IDENT:int = 1;	

		/**
		* 	The identifier for an atkeyword token.
		*/
		public static const ATKEYWORD:int = 2;	
		
		/**
		* 	The identifier for a string token.
		*/
		public static const STRING:int = 3;
		
		/**
		* 	The identifier for a badstring token.
		*/
		public static const BAD_STRING:int = 4;
		
		/**
		* 	The identifier for a baduri token.
		*/
		public static const BAD_URI:int = 5;
		
		/**
		* 	The identifier for a badcomment token.
		*/
		public static const BAD_COMMENT:int = 6;
		
		/**
		* 	The identifier for a hash token.
		*/
		public static const HASH:int = 7;
		
		/**
		* 	The identifier for a number token.
		*/
		public static const NUMBER:int = 8;
		
		/**
		* 	The identifier for a percentage token.
		*/
		public static const PERCENTAGE:int = 9;
		
		/**
		* 	The identifier for a dimension token.
		*/
		public static const DIMENSION:int = 10;
		
		/**
		* 	The identifier for a uri token.
		*/
		public static const URI:int = 11;
		
		/**
		* 	The identifier for a unicode range token.
		*/
		public static const UNICODE_RANGE:int = 12;
		
		/**
		* 	The identifier for a comment data open token.
		*/
		public static const CDO:int = 13;
		
		/**
		* 	The identifier for a comment data close token.
		*/
		public static const CDC:int = 14;

		/**
		* 	The identifier for a colon token.
		*/
		public static const COLON:int = 15;
		
		/**
		* 	The identifier for a semi colon token.
		*/
		public static const SEMI_COLON:int = 16;
		
		/**
		* 	The identifier for a left brace token.
		*/
		public static const LEFT_BRACE:int = 17;
		
		/**
		* 	The identifier for a right brace token.
		*/
		public static const RIGHT_BRACE:int = 18;
		
		/**
		* 	The identifier for a left parentheses token.
		*/
		public static const LEFT_PARENTHESES:int = 19;
		
		/**
		* 	The identifier for a right parentheses token.
		*/
		public static const RIGHT_PARENTHESES:int = 20;
		
		/**
		* 	The identifier for a left bracket token.
		*/
		public static const LEFT_BRACKET:int = 21;
		
		/**
		* 	The identifier for a right bracket token.
		*/
		public static const RIGHT_BRACKET:int = 22;
		
		/**
		* 	The identifier for a space token.
		*/
		public static const S:int = 23;
		
		/**
		* 	The identifier for a function token.
		*/
		public static const FUNCTION:int = 24;
		
		/**
		* 	The identifier for a comment token.
		*/
		public static const COMMENT:int = 25;		
		
		/**
		* 	The identifier for an includes token.
		*/
		public static const INCLUDES:int = 26;
		
		/**
		* 	The identifier for a dashmatch token.
		*/
		public static const DASHMATCH:int = 27;
		
		/**
		* 	The identifier for a prefixmatch token.
		*/
		public static const PREFIXMATCH:int = 28;
		
		/**
		* 	The identifier for a suffixmatch token.
		*/
		public static const SUFFIXMATCH:int = 29;
		
		/**
		* 	The identifier for a substringmatch token.
		*/
		public static const SUBSTRINGMATCH:int = 30;
		
		/**
		* 	The identifier for a char token.
		*/
		public static const CHAR:int = 100;

		/**
		* 	Creates a <code>CssTokenizer</code> instance.
		*/
		public function CssTokenizer()
		{
			super();
		}
		
		override protected function configure():void
		{
			//**************************** MACRO EXPRESSIONS ****************************//
						
			//nonascii			[^\0-\237]
			const NONASCII_EXP:String
				= "[" + String.fromCharCode( 0x0080 )
				+ "-" + String.fromCharCode( 0xFFFF ) + "]";
				
			//const NONASCII_EXP:String = "[\\u0080-\\uFFFF]";
			//const NONASCII_EXP:String = "[^\\\\x00-\\\\xED]";
			
			//num				[0-9]+|[0-9]*\.[0-9]+
			const NUM_EXP:String = "([0-9]*\\.)?[0-9]+";
			
			//const NUM_EXP:String = "[0-9]+|[0-9]*\\.[0-9]+";
			
			//nl				\n|\r\n|\r|\f
			const NL_EXP:String = "\n|\r\n|\r|\f";
			
			//w					[ \t\r\n\f]*
			const W_EXP:String = "[ \t\r\n\f]*";
			
			//unicode			\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?
			const UNICODE_EXP:String =
				"\\\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?";
				
			//escape			{unicode}|\\[^\n\r\f0-9a-f]
			const ESCAPE_EXP:String =
				UNICODE_EXP + "|\\\\[^\n\r\f0-9a-f]";
			
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			const STRING1_EXP:String =
				"\"([^\n\r\f\\\"]" + "|\\\\" + NL_EXP + "|" + ESCAPE_EXP + ")*\"";
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"'([^\n\r\f\\']" + "|\\\\" + NL_EXP + "|" + ESCAPE_EXP + ")*'";
			
			//string			{string1}|{string2}
			const STRING_EXP:String =
				"(" + STRING1_EXP + ")|(" + STRING2_EXP + ")";
			
			//badstring1		\"([^\n\r\f\\"]|\\{nl}|{escape})*\\?
			const BAD_STRING1_EXP:String =
				"\"([^\n\r\f\\\"]" + "|\\\\" + NL_EXP + "|" + ESCAPE_EXP + ")*\\\\?";
			
			//badstring2		\'([^\n\r\f\\']|\\{nl}|{escape})*\\?
			const BAD_STRING2_EXP:String =
				"'([^\n\r\f\\']" + "|\\\\" + NL_EXP + "|" + ESCAPE_EXP + ")*\\\\?";
			
			//badstring			{badstring1}|{badstring2}
			const BAD_STRING_EXP:String =
				"(" + BAD_STRING1_EXP + ")|(" + BAD_STRING2_EXP + ")";
			
			//URI				url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
			const URI_EXP:String =
				"url\\("			//open function call (quoted)
				+ W_EXP
				+ "(" + STRING_EXP + ")"
				+ W_EXP
				+ "\\)"				//close function call (quoted)
				+ "|"
				+ "url\\("			//open function call
				+ W_EXP
				+ "([!#$%&*-\\[\\]-~]|"
				+ NONASCII_EXP + "|" + ESCAPE_EXP
				+ ")*"
				+ W_EXP
				+ "\\)";			//close function call

			//baduri1			url\({w}([!#$%&*-~]|{nonascii}|{escape})*{w}
			const BAD_URI1_EXP:String =
				"url\\("
				+ W_EXP
				+ "([!#$%&*-\\[\\]-~]|"
				+ NONASCII_EXP + "|" + ESCAPE_EXP
				+ ")*"
				+ W_EXP;
			
			//baduri2			url\({w}{string}{w}
			const BAD_URI2_EXP:String =
				"url\\("
				+ W_EXP
				+ "(" + STRING_EXP + ")"
				+ W_EXP;
			
			//baduri3			url\({w}{badstring}
			const BAD_URI3_EXP:String =
				"url\\("
				+ W_EXP
				+ "(" + BAD_STRING_EXP + ")";
			
			//baduri			{baduri1}|{baduri2}|{baduri3}	
			const BAD_URI_EXP:String =
				"(" + BAD_URI1_EXP + ")|(" + BAD_URI2_EXP + ")|("  + BAD_URI3_EXP + ")";
				
			//u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			const UNICODE_RANGE_EXP:String =
				"u\\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?";
			
			//nmstart			[_a-z]|{nonascii}|{escape}
			const NMSTART_EXP:String =
				"[_a-z]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP;
				
			//nmchar			[_a-z0-9-]|{nonascii}|{escape}
			const NMCHAR_EXP:String =
				"[_a-z0-9\\-]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP;
				
			//name				{nmchar}+
			const NAME_EXP:String =
				"(" + NMCHAR_EXP + ")+";
			
			//IDENT				{ident}
			//ident				[-]?{nmstart}{nmchar}*	
			const IDENT_EXP:String =
				"-?(" + NMSTART_EXP + ")+" + NMCHAR_EXP + "*";
			
			//ATKEYWORD			@{ident}
			const ATKEYWORD_EXP:String = "@" + IDENT_EXP;
			
			//HASH				#{name}
			const HASH_EXP:String = "#" + NAME_EXP;
			
			//DIMENSION			{num}{ident}
			const DIMENSION_EXP:String = NUM_EXP + IDENT_EXP;
			
			//PERCENTAGE		{num}%
			const PERCENT_EXP:String = NUM_EXP + "%";
			
			//INCLUDES			~=
			const INCLUDES_EXP:String = "~=";
			
			//DASHMATCH			|=
			const DASHMATCH_EXP:String = "\\|=";
			
			//FUNCTION			{ident}\(
			const FUNCTION_EXP:String = IDENT_EXP + "\\(";
			
			//CDO				<!--
			const CDO_EXP:String = "<!--";
			
			//CDC				-->
			const CDC_EXP:String = "-->";

			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			const COMMENT_EXP:String = "/\\*[^*]*\\*+([^/*][^*]*\\*+)*/";
			
			//badcomment1		\/\*[^*]*\*+([^/*][^*]*\*+)*
			const BAD_COMMENT1_EXP:String = "/\\*[^*]*\\*+([^/*][^*]*\\*+)*";

			//badcomment2		\/\*[^*]*(\*+[^/*][^*]*)*
			const BAD_COMMENT2_EXP:String = "/\\*[^*]*(\\*+[^/*][^*]*)*";
			
			//BAD_COMMENT		{badcomment}
			//badcomment		{badcomment1}|{badcomment2}
			const BAD_COMMENT_EXP:String = 
				"("
				+ BAD_COMMENT1_EXP
				+ ")|("
				+ BAD_COMMENT2_EXP
				+ ")";
			
			//CHAR	any other character not matched by the above rules,
			//and neither a single nor a double quote
			const CHAR_EXP:String = "[^'\"]{1}";
			
			//**************************** TOKENS ****************************//

			//IDENT				{ident}
			var ident:Token = new Token(
				IDENT, new RegExp( "^(" + IDENT_EXP + ")", "i" ) );
				
			//ATKEYWORD			@{ident}
			var at:Token = new Token(
				ATKEYWORD, new RegExp( "^(" + ATKEYWORD_EXP + ")", "i" ) );
				
			//STRING			{string}
			var string:Token = new Token(
				STRING, new RegExp( "^(" + STRING_EXP + ")", "i" ) );
				
			//BAD_STRING		{badstring}
			var badString:Token = new Token(
				BAD_STRING, new RegExp( "^(" + BAD_STRING_EXP + ")", "i" ) );

			//BAD_URI			{baduri}
			var badUri:Token = new Token(
				BAD_URI, new RegExp( "^(" + BAD_URI_EXP + ")", "i" ) );
			
			//BAD_COMMENT		{badcomment}
			var badComment:Token = new Token(
				BAD_COMMENT, new RegExp( "^(" + BAD_COMMENT_EXP + ")", "i" ) );
				
			//HASH				#{name}
			var hash:Token = new Token(
				HASH, new RegExp( "^(" + HASH_EXP + ")", "i" ) );
			
			//NUMBER			{num}
			var num:Token = new Token( NUMBER,
				new RegExp( "^(" + NUM_EXP + ")" ) );
				
			//PERCENTAGE		{num}%
			var percent:Token = new Token( PERCENTAGE,
				new RegExp( "^(" + PERCENT_EXP + ")" ) );
			
			//DIMENSION			{num}{ident}
			var dimension:Token = new Token( DIMENSION,
				new RegExp( "^(" + DIMENSION_EXP + ")" ) );				
			
			//URI				url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
			var uri:Token = new Token( URI,
				new RegExp( "^(" + URI_EXP + ")", "i" ) );
			
			//UNICODE-RANGE		u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			var range:Token = new Token( UNICODE_RANGE,
				new RegExp( "^(" + UNICODE_RANGE_EXP + ")", "i" ) );
			
			//CDO				<!--
			var cdo:Token = new Token(
				CDO, new RegExp( "^(" + CDO_EXP + ")" ) );
			
			//CDC				-->
			var cdc:Token = new Token(
				CDC, new RegExp( "^(" + CDC_EXP + ")" ) );

			//S					[ \t\r\n\f]+
			var s:Token = new Token( S, /^([ \t\r\n\f]+)/ );				
			
			//INCLUDES			~=
			var includes:Token = new Token( INCLUDES,
				new RegExp( "^(" + INCLUDES_EXP + ")" ) );
			
			//DASHMATCH			|=
			var dashmatch:Token = new Token( DASHMATCH,
				new RegExp( "^(" + DASHMATCH_EXP + ")" ) );	
			
			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			var comment:Token = new Token(
				COMMENT, new RegExp( "^(" + COMMENT_EXP + ")" ) );				
				
			//FUNCTION			{ident}\(
			var method:Token = new Token(
				FUNCTION, new RegExp( "^(" + FUNCTION_EXP + ")" ) );
							
			//CHAR	any other character not matched by the above rules,
			//and neither a single nor a double quote
			var char:Token = new Token(
				CHAR, new RegExp( "^(" + CHAR_EXP + ")" ) );
			
			//**************************** TOKEN DEFINITIONS ****************************//
			
			//whitespace token - match early as it's such a common token
			tokens.push( s );			
			
			//match a uri function expression first
			tokens.push( uri );	
			
			//match {baduri} before {ident}
			tokens.push( badUri );
			
			//unicode range  - must match before {ident}
			tokens.push( range );		
			
			tokens.push( at );			
			
			tokens.push( ident );

			tokens.push( string );
			
			tokens.push( badString );
			
			tokens.push( hash );			
			
			//numeric values must be matched in this order
			tokens.push( dimension );
			tokens.push( percent );
			tokens.push( num );
			
			//xml style comments
			tokens.push( cdo );
			tokens.push( cdc );
			
			//code style multiline comment
			tokens.push( comment );
			
			//match bad comments after good ones
			tokens.push( badComment ); 
			
			//function expression: method()
			tokens.push( method );
			
			//includes operator ~=
			tokens.push( includes );
			
			//dashmatch operator |=
			tokens.push( dashmatch );
			
			//final catch all char
			tokens.push( char );	
		}
	}
}
	
/*
	//TOKENS
	
	Token			Definition
	
	IDENT			{ident}
	ATKEYWORD		@{ident}
	STRING			{string}
	BAD_STRING		{badstring}
	BAD_URI			{baduri}
	BAD_COMMENT		{badcomment}
	HASH			#{name}
	NUMBER			{num}
	PERCENTAGE		{num}%
	DIMENSION		{num}{ident}
	URI				url\({w}{string}{w}\)
					|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
	UNICODE-RANGE	u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
	CDO	<!--
	CDC	-->
	:	:
	;	;
	{	\{
	}	\}
	(	\(
	)	\)
	[	\[
	]	\]
	S	[ \t\r\n\f]+
	COMMENT	\/\*[^*]*\*+([^/*][^*]*\*+)*\/
	FUNCTION	{ident}\(
	INCLUDES	~=
	DASHMATCH	|=
	DELIM	any other character not matched by the above rules, and neither a single nor a double quote

	//MACROS
	
	ident			[-]?{nmstart}{nmchar}*
	name			{nmchar}+
	nmstart			[_a-z]|{nonascii}|{escape}
	nonascii		[^\0-\237]
	unicode			\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?
	escape			{unicode}|\\[^\n\r\f0-9a-f]
	nmchar			[_a-z0-9-]|{nonascii}|{escape}
	num				[0-9]+|[0-9]*\.[0-9]+
	string			{string1}|{string2}
	string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
	string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
	badstring		{badstring1}|{badstring2}
	badstring1		\"([^\n\r\f\\"]|\\{nl}|{escape})*\\?
	badstring2		\'([^\n\r\f\\']|\\{nl}|{escape})*\\?
	badcomment		{badcomment1}|{badcomment2}
	badcomment1		\/\*[^*]*\*+([^/*][^*]*\*+)*
	badcomment2		\/\*[^*]*(\*+[^/*][^*]*)*
	baduri			{baduri1}|{baduri2}|{baduri3}

	baduri1			url\({w}([!#$%&*-~]|{nonascii}|{escape})*{w}
	baduri2			url\({w}{string}{w}
	baduri3			url\({w}{badstring}
	nl				\n|\r\n|\r|\f
	w				[ \t\r\n\f]*

	//RULES
	
	stylesheet  : [ CDO | CDC | S | statement ]*;
	statement   : ruleset | at-rule;
	at-rule     : ATKEYWORD S* any* [ block | ';' S* ];
	block       : '{' S* [ any | block | ATKEYWORD S* | ';' S* ]* '}' S*;
	ruleset     : selector? '{' S* declaration? [ ';' S* declaration? ]* '}' S*;
	selector    : any+;
	declaration : property S* ':' S* value;
	property    : IDENT;
	value       : [ any | block | ATKEYWORD S* ]+;
	any         : [ IDENT | NUMBER | PERCENTAGE | DIMENSION | STRING
	              | DELIM | URI | HASH | UNICODE-RANGE | INCLUDES
	              | DASHMATCH | ':' | FUNCTION S* [any|unsused]* ')'
	              | '(' S* [any|unused]* ')' | '[' S* [any|unused]* ']'
	              ] S*;
	unused      : block | ATKEYWORD S* | ';' S* | CDO S* | CDC S*;
	
	
	
	
	G.1 Grammar

	The grammar below is LALR(1) (but note that most UA's should not use it directly, since it does not express the parsing conventions, only the CSS 2.1 syntax). The format of the productions is optimized for human consumption and some shorthand notation beyond Yacc (see [YACC]) is used:

	*: 0 or more
	+: 1 or more
	?: 0 or 1
	|: separates alternatives
	[ ]: grouping
	The productions are:

	stylesheet
	  : [ CHARSET_SYM STRING ';' ]?
	    [S|CDO|CDC]* [ import [ CDO S* | CDC S* ]* ]*
	    [ [ ruleset | media | page ] [ CDO S* | CDC S* ]* ]*
	  ;
	import
	  : IMPORT_SYM S*
	    [STRING|URI] S* media_list? ';' S*
	  ;
	media
	  : MEDIA_SYM S* media_list LBRACE S* ruleset* '}' S*
	  ;
	media_list
	  : medium [ COMMA S* medium]*
	  ;
	medium
	  : IDENT S*
	  ;
	page
	  : PAGE_SYM S* pseudo_page?
	    '{' S* declaration? [ ';' S* declaration? ]* '}' S*
	  ;
	pseudo_page
	  : ':' IDENT S*
	  ;
	operator
	  : '/' S* | ',' S*
	  ;
	combinator
	  : '+' S*
	  | '>' S*
	  ;
	unary_operator
	  : '-' | '+'
	  ;
	property
	  : IDENT S*
	  ;
	ruleset
	  : selector [ ',' S* selector ]*
	    '{' S* declaration? [ ';' S* declaration? ]* '}' S*
	  ;
	selector
	  : simple_selector [ combinator selector | S+ [ combinator? selector ]? ]?
	  ;
	simple_selector
	  : element_name [ HASH | class | attrib | pseudo ]*
	  | [ HASH | class | attrib | pseudo ]+
	  ;
	class
	  : '.' IDENT
	  ;
	element_name
	  : IDENT | '*'
	  ;
	attrib
	  : '[' S* IDENT S* [ [ '=' | INCLUDES | DASHMATCH ] S*
	    [ IDENT | STRING ] S* ]? ']'
	  ;
	pseudo
	  : ':' [ IDENT | FUNCTION S* [IDENT S*]? ')' ]
	  ;
	declaration
	  : property ':' S* expr prio?
	  ;
	prio
	  : IMPORTANT_SYM S*
	  ;
	expr
	  : term [ operator? term ]*
	  ;
	term
	  : unary_operator?
	    [ NUMBER S* | PERCENTAGE S* | LENGTH S* | EMS S* | EXS S* | ANGLE S* |
	      TIME S* | FREQ S* ]
	  | STRING S* | IDENT S* | URI S* | hexcolor | function
	  ;
	function
	  : FUNCTION S* expr ')' S*
	  ;
	
	 //* There is a constraint on the color that it must
	 //* have either 3 or 6 hex-digits (i.e., [0-9a-fA-F])
	 //* after the "#"; e.g., "#000" is OK, but "#abcd" is not.
	 
	hexcolor
	  : HASH S*
	  ;	
	
	
	
	//FLEX LEXICAL NOTATION
	
	%option case-insensitive

	h						[0-9a-f]
	nonascii				[\200-\377]
	unicode					\\{h}{1,6}(\r\n|[ \t\r\n\f])?
	escape					{unicode}|\\[^\r\n\f0-9a-f]
	nmstart					[_a-z]|{nonascii}|{escape}
	nmchar					[_a-z0-9-]|{nonascii}|{escape}
	string1					\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
	string2					\'([^\n\r\f\\']|\\{nl}|{escape})*\'
	badstring1      		\"([^\n\r\f\\"]|\\{nl}|{escape})*\\?
	badstring2      		\'([^\n\r\f\\']|\\{nl}|{escape})*\\?
	badcomment1     		\/\*[^*]*\*+([^/*][^*]*\*+)*
	badcomment2     		\/\*[^*]*(\*+[^/*][^*]*)*
	baduri1       			url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}
	baduri2         		url\({w}{string}{w}
	baduri3         		url\({w}{badstring}
	comment					\/\*[^*]*\*+([^/*][^*]*\*+)*\/
	ident					-?{nmstart}{nmchar}*
	name					{nmchar}+
	num						[0-9]+|[0-9]*"."[0-9]+
	string					{string1}|{string2}
	badstring       		{badstring1}|{badstring2}
	badcomment      		{badcomment1}|{badcomment2}
	baduri          		{baduri1}|{baduri2}|{baduri3}
	url						([!#$%&*-~]|{nonascii}|{escape})*
	s						[ \t\r\n\f]+
	w						{s}?
	nl						\n|\r\n|\r|\f

	A						a|\\0{0,4}(41|61)(\r\n|[ \t\r\n\f])?
	C						c|\\0{0,4}(43|63)(\r\n|[ \t\r\n\f])?
	D						d|\\0{0,4}(44|64)(\r\n|[ \t\r\n\f])?
	E						e|\\0{0,4}(45|65)(\r\n|[ \t\r\n\f])?
	G						g|\\0{0,4}(47|67)(\r\n|[ \t\r\n\f])?|\\g
	H						h|\\0{0,4}(48|68)(\r\n|[ \t\r\n\f])?|\\h
	I						i|\\0{0,4}(49|69)(\r\n|[ \t\r\n\f])?|\\i
	K						k|\\0{0,4}(4b|6b)(\r\n|[ \t\r\n\f])?|\\k
	L               		l|\\0{0,4}(4c|6c)(\r\n|[ \t\r\n\f])?|\\l
	M						m|\\0{0,4}(4d|6d)(\r\n|[ \t\r\n\f])?|\\m
	N						n|\\0{0,4}(4e|6e)(\r\n|[ \t\r\n\f])?|\\n
	O						o|\\0{0,4}(4f|6f)(\r\n|[ \t\r\n\f])?|\\o
	P						p|\\0{0,4}(50|70)(\r\n|[ \t\r\n\f])?|\\p
	R						r|\\0{0,4}(52|72)(\r\n|[ \t\r\n\f])?|\\r
	S						s|\\0{0,4}(53|73)(\r\n|[ \t\r\n\f])?|\\s
	T						t|\\0{0,4}(54|74)(\r\n|[ \t\r\n\f])?|\\t
	U               		u|\\0{0,4}(55|75)(\r\n|[ \t\r\n\f])?|\\u
	X						x|\\0{0,4}(58|78)(\r\n|[ \t\r\n\f])?|\\x
	Z						z|\\0{0,4}(5a|7a)(\r\n|[ \t\r\n\f])?|\\z

	%%

	{s}			{return S;}

	\/\*[^*]*\*+([^/*][^*]*\*+)*\/			//ignore comments
	{badcomment}                         	//unclosed comment at EOF

	"<!--"					{return CDO;}
	"-->"					{return CDC;}
	"~="					{return INCLUDES;}
	"|="					{return DASHMATCH;}

	{string}				{return STRING;}
	{badstring}             {return BAD_STRING);}

	{ident}					{return IDENT;}

	"#"{name}				{return HASH;}

	@{I}{M}{P}{O}{R}{T}		{return IMPORT_SYM;}
	@{P}{A}{G}{E}			{return PAGE_SYM;}
	@{M}{E}{D}{I}{A}		{return MEDIA_SYM;}
	"@charset "				{return CHARSET_SYM;}

	"!"({w}|{comment})*{I}{M}{P}{O}{R}{T}{A}{N}{T}	{return IMPORTANT_SYM;}

	{num}{E}{M}				{return EMS;}
	{num}{E}{X}				{return EXS;}
	{num}{P}{X}				{return LENGTH;}
	{num}{C}{M}				{return LENGTH;}
	{num}{M}{M}				{return LENGTH;}
	{num}{I}{N}				{return LENGTH;}
	{num}{P}{T}				{return LENGTH;}
	{num}{P}{C}				{return LENGTH;}
	{num}{D}{E}{G}			{return ANGLE;}
	{num}{R}{A}{D}			{return ANGLE;}
	{num}{G}{R}{A}{D}		{return ANGLE;}
	{num}{M}{S}				{return TIME;}
	{num}{S}				{return TIME;}
	{num}{H}{Z}				{return FREQ;}
	{num}{K}{H}{Z}			{return FREQ;}
	{num}{ident}			{return DIMENSION;}

	{num}%					{return PERCENTAGE;}
	{num}					{return NUMBER;}

	{U}{R}{L}"("{w}{string}{w}")"		{return URI;}
	{U}{R}{L}"("{w}{url}{w}")"			{return URI;}
	{baduri}                        	{return BAD_URI);}

	{ident}"("							{return FUNCTION;}

	.			{return *yytext;}	
*/