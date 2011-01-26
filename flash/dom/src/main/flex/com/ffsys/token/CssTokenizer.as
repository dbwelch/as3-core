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
		* 	The identifier for a delim token.
		*/
		public static const DELIM:int = 100;

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
				+ "-" + String.fromCharCode( 0xFFFFF ) + "]";
			
			//num				[0-9]+|[0-9]*\.[0-9]+
			const NUM_EXP:String = "([0-9]+\.)?[0-9]+";
			
			//nl				\n|\r\n|\r|\f
			const NL_EXP:String = "\n|\r\n|\r|\f";
			
			//w					[ \t\r\n\f]*
			const W_EXP:String = "[ \t\r\n\f]*";
			
			//unicode			\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?
			const UNICODE_EXP:String =
				"\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?";
				
			//escape			{unicode}|\\[^\n\r\f0-9a-f]
			const ESCAPE_EXP:String =
				UNICODE_EXP + "|\\[^\n\r\f0-9a-f]";
			
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			const STRING1_EXP:String =
				"\"([^\n\r\f\\\"]" + "|\\" + NL_EXP + "|" + ESCAPE_EXP + ")*\"";
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"'([^\n\r\f\\']" + "|\\" + NL_EXP + "|" + ESCAPE_EXP + ")*'";
			
			//url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)	
			const URI_EXP:String =
				"url\\("			//open function call (quoted)
				+ W_EXP
				+ "((" + STRING1_EXP + ")|(" + STRING2_EXP + "))"
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
				
			//u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			const UNICODE_RANGE_EXP:String =
				"u\\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?";
			
			//nmstart			[_a-z]|{nonascii}|{escape}
			const NMSTART_EXP:String =
				"(" + "[_a-zA-Z]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP + ")";
				
			//nmchar			[_a-z0-9-]|{nonascii}|{escape}
			const NMCHAR_EXP:String =
				"(" + "[_a-zA-Z0-9-]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP + ")";
				
			//name				{nmchar}+
			const NAME_EXP:String =
				"(" + NMCHAR_EXP + "+" + ")";
				
			//TOOD: match the specification
			
			//ident				[-]?{nmstart}{nmchar}*
			const IDENT_EXP:String =
				"[\-]?[_a-zA-Z]+[_a-zA-Z0-9\-]*";
			
			const ATKEYWORD_EXP:String = "@" + IDENT_EXP;
			const HASH_EXP:String = "#" + NAME_EXP;
			const DIMENSION_EXP:String = NUM_EXP + IDENT_EXP;
			const PERCENT_EXP:String = NUM_EXP + "%";
			const INCLUDES_EXP:String = "~=";
			const DASHMATCH_EXP:String = "\\|=";
			const FUNCTION_EXP:String = IDENT_EXP + "\\(";
			const DELIM_EXP:String = "[^'\"]";
			const CDO_EXP:String = "<!--";
			const CDC_EXP:String = "-->";
			
			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			const COMMENT_EXP:String = "/\\*[^*]*\\*+([^/*][^*]*\\*+)*/";
			
			//**************************** TOKENS ****************************//

			//IDENT				{ident}
			var ident:Token = new Token(
				IDENT, new RegExp( "^(" + IDENT_EXP + ")" ) );
				
			//ATKEYWORD			@{ident}
			var at:Token = new Token(
				ATKEYWORD, new RegExp( "^(" + ATKEYWORD_EXP + ")" ) );
				
			//STRING			{string}
			var string1:Token = new Token( STRING,
				new RegExp( "^(" + STRING1_EXP + ")" ) );
			var string2:Token = new Token( STRING,
				new RegExp( "^(" + STRING2_EXP + ")" ) );
				
			//bad values - TODO
			
			//BAD_STRING		{badstring}
			var badString:Token = new Token( BAD_STRING );
			
			//BAD_URI			{baduri}
			var badUri:Token = new Token( BAD_URI );
			
			//BAD_COMMENT		{badcomment}
			var badComment:Token = new Token( BAD_COMMENT );
				
			//HASH				#{name}
			var hash:Token = new Token(
				HASH, new RegExp( "^(" + HASH_EXP + ")" ) );
			
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
				new RegExp( "^(" + URI_EXP + ")" ) );
			
			trace("CssTokenizer::uri()", uri.match );
			
			//UNICODE-RANGE		u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			var range:Token = new Token( UNICODE_RANGE,
				new RegExp( "^(" + UNICODE_RANGE_EXP + ")" ) );
			
			//CDO				<!--
			var cdo:Token = new Token(
				CDO, new RegExp( "^(" + CDO_EXP + ")" ) );
			
			//CDC				-->
			var cdc:Token = new Token(
				CDC, new RegExp( "^(" + CDC_EXP + ")" ) );
			
			//COLON				:
			var colon:Token = new Token(
				COLON, /^(:)/ );
			
			//SEMI_COLON		;
			var semiColon:Token = new Token(
				SEMI_COLON, /^(;)/ );
				
			//LEFT_BRACE		\{
			var leftBrace:Token = new Token(
				LEFT_BRACE, /^(\{)/ );
			
			//RIGHT_BRACE		\}
			var rightBrace:Token = new Token(
				RIGHT_BRACE, /^(\})/ );
				
			//LEFT_PARENTHESES	\(
			var leftParentheses:Token = new Token(
				LEFT_PARENTHESES, /^(\()/ );
				
			//RIGHT_PARENTHESES	\)
			var rightParentheses:Token = new Token(
				RIGHT_PARENTHESES, /^(\))/ );
				
			//LEFT_BRACKET		\[
			var leftBracket:Token = new Token(
				LEFT_BRACKET, /^(\[)/ );
			
			//RIGHT_BRACKET		\]
			var rightBracket:Token = new Token(
				RIGHT_BRACKET, /^(\])/ );

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
							
			//DELIM	any other character not matched by the above rules,
			//and neither a single nor a double quote
			var delim:Token = new Token(
				DELIM, new RegExp( "^(" + DELIM_EXP + ")" ) );
			
			//**************************** TOKEN DEFINITIONS ****************************//
			
			//match a uri function expression first
			tokens.push( uri );			
			
			//unicode range  - must match before {ident}
			tokens.push( range );
			
			//function expression: method() - must match before {ident}
			tokens.push( method );			
			
			tokens.push( at );			
			
			tokens.push( ident );
			tokens.push( string1 );
			tokens.push( string2 );
			
			//todo
			tokens.push( badString );
			tokens.push( badUri );
			tokens.push( badComment );
			
			tokens.push( hash );			
			
			//numeric values must be matched in this order
			tokens.push( dimension );
			tokens.push( percent );
			tokens.push( num );
			
			//xml style comments
			tokens.push( cdo );
			tokens.push( cdc );
			
			//character tokens
			tokens.push( colon );
			tokens.push( semiColon );
			tokens.push( leftBrace );
			tokens.push( rightBrace );
			tokens.push( leftParentheses );
			tokens.push( rightParentheses );
			tokens.push( leftBracket );
			tokens.push( rightBracket );	
			
			//whitespace token
			tokens.push( s );
			
			//code style multiline comment
			tokens.push( comment );
			
			//includes operator ~=
			tokens.push( includes );
			
			//dashmatch operator |=
			tokens.push( dashmatch );
			
			//final catch all delimiter
			tokens.push( delim );
			
			/*
			
			IDENT		{ident}
			ATKEYWORD	@{ident}
			STRING		{string}
			
			//todo			
			BAD_STRING	{badstring}
			BAD_URI		{baduri}
			BAD_COMMENT	{badcomment}
			
			HASH		#{name}
			NUMBER		{num}
			PERCENTAGE	{num}%
			DIMENSION	{num}{ident}
			
			//todo
			URI			url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
		
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
			
			*/		
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
*/