package com.ffsys.token
{

	public class CssTokenizer extends Tokenizer
	{
		/**
		* 	The identifier for a stylesheet token.
		*/
		public static const STYLESHEET:int = 0;
		
		/**
		* 	The identifier for a comment data open token.
		*/
		public static const CDO:int = 1;
		
		/**
		* 	The identifier for a comment data close token.
		*/
		public static const CDC:int = 2;
		
		/**
		* 	The identifier for a space token.
		*/
		public static const S:int = 3;
		
		/**
		* 	The identifier for a statement token.
		*/
		public static const STATEMENT:int = 4;
		
		/**
		* 	The identifier for a block token.
		*/
		public static const BLOCK:int = 5;
		
		/**
		* 	The identifier for a ident token.
		*/
		public static const IDENT:int = 6;
		
		/**
		* 	The identifier for an atkeyword token.
		*/
		public static const ATKEYWORD:int = 7;
		
		/**
		* 	The identifier for a string token.
		*/
		public static const STRING:int = 8;
		
		/**
		* 	The identifier for a badstring token.
		*/
		public static const BAD_STRING:int = 9;
		
		/**
		* 	The identifier for a baduri token.
		*/
		public static const BAD_URI:int = 10;
		
		/**
		* 	The identifier for a badcomment token.
		*/
		public static const BAD_COMMENT:int = 11;
		
		/**
		* 	The identifier for a hash token.
		*/
		public static const HASH:int = 12;
		
		/**
		* 	The identifier for a number token.
		*/
		public static const NUMBER:int = 13;
		
		/**
		* 	The identifier for a percentage token.
		*/
		public static const PERCENTAGE:int = 14;
		
		/**
		* 	The identifier for a dimension token.
		*/
		public static const DIMENSION:int = 15;
		
		/**
		* 	The identifier for a comment token.
		*/
		public static const COMMENT:int = 16;
		
		/**
		* 	The identifier for a semi colon token.
		*/
		public static const SEMI_COLON:int = 17;
		
		/**
		* 	The identifier for a colon token.
		*/
		public static const COLON:int = 18;
		
		/**
		* 	The identifier for a left brace token.
		*/
		public static const LEFT_BRACE:int = 19;
		
		/**
		* 	The identifier for a right brace token.
		*/
		public static const RIGHT_BRACE:int = 20;
		
		/**
		* 	The identifier for a left parentheses token.
		*/
		public static const LEFT_PARENTHESES:int = 21;
		
		/**
		* 	The identifier for a right parentheses token.
		*/
		public static const RIGHT_PARENTHESES:int = 22;
		
		/**
		* 	The identifier for a left bracket token.
		*/
		public static const LEFT_BRACKET:int = 23;
		
		/**
		* 	The identifier for a right bracket token.
		*/
		public static const RIGHT_BRACKET:int = 24;
		
		//////
		
		
		/**
		* 	The identifier for an ident macro.
		*/
		public static const IDENT_MACRO:int = 100;
		
		/**
		* 	The identifier for a name macro.
		*/
		public static const NAME_MACRO:int = 101;
		
		/**
		* 	The identifier for a nmstart macro.
		*/
		public static const NMSTART_MACRO:int = 102;
		
		/**
		* 	The identifier for a nonascii macro.
		*/
		public static const NONASCII_MACRO:int = 103;
		
		/**
		* 	The identifier for a unicode macro.
		*/
		public static const UNICODE_MACRO:int = 104;
		
		/**
		* 	The identifier for an escape macro.
		*/
		public static const ESCAPE_MACRO:int = 105;
		
		/**
		* 	The identifier for a nmchar macro.
		*/
		public static const NMCHAR_MACRO:int = 106;
		
		/**
		* 	The identifier for a num macro.
		*/
		public static const NUM_MACRO:int = 107;
		
		/**
		* 	The identifier for a string macro.
		*/
		public static const STRING_MACRO:int = 108;
		
		/**
		* 	The identifier for a string1 macro.
		*/
		public static const STRING1_MACRO:int = 109;
		
		/**
		* 	The identifier for a string2 macro.
		*/
		public static const STRING2_MACRO:int = 110;
		
		/**
		* 	The identifier for a badstring macro.
		*/
		public static const BADSTRING_MACRO:int = 111;
		
		/**
		* 	The identifier for a badstring1 macro.
		*/
		public static const BADSTRING1_MACRO:int = 112;
		
		/**
		* 	The identifier for a badstring2 macro.
		*/
		public static const BADSTRING2_MACRO:int = 113;
		
		/**
		* 	The identifier for a badcomment macro.
		*/
		public static const BADCOMMENT_MACRO:int = 114;
		
		/**
		* 	The identifier for a badcomment1 macro.
		*/
		public static const BADCOMMENT1_MACRO:int = 115;
		
		/**
		* 	The identifier for a badcomment2 macro.
		*/
		public static const BADCOMMENT2_MACRO:int = 116;
		
		/**
		* 	The identifier for a baduri macro.
		*/
		public static const BADURI_MACRO:int = 117;
		
		/**
		* 	The identifier for a baduri1 macro.
		*/
		public static const BADURI1_MACRO:int = 118;
		
		/**
		* 	The identifier for a baduri2 macro.
		*/
		public static const BADURI2_MACRO:int = 119;
		
		/**
		* 	The identifier for a baduri3 macro.
		*/
		public static const BADURI3_MACRO:int = 120;
		
		/**
		* 	The identifier for a nl macro.
		*/
		public static const NL_MACRO:int = 121;
		
		/**
		* 	The identifier for a w macro.
		*/
		public static const W_MACRO:int = 122;

		/**
		* 	Creates a <code>CssTokenizer</code> instance.
		*/
		public function CssTokenizer()
		{
			super();
		}
		
		override protected function configure():void
		{
			//MACROS
			//ident			[-]?{nmstart}{nmchar}*
			var ident:Token = new Token( IDENT_MACRO, /^[\-]?([_a-z])+([_a-z0-9\-])*$/ );
			
			//name			{nmchar}+
			var name:Token = new Token( NAME_MACRO, /[_a-z0-9-]+/ );
			
			//nmstart		[_a-z]|{nonascii}|{escape}
			var nmstart:Token = new Token( NMSTART_MACRO, /[_a-z]/ );
			
			//nonascii		[^\0-\237]
			var nonascii:Token = new Token( NONASCII_MACRO, /[^\0-\237]/ );
			
			//unicode			\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?
			var unicode:Token = new Token( UNICODE_MACRO, /\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?/ );
			
			//escape			{unicode}|\\[^\n\r\f0-9a-f]
			var escape:Token = new Token( ESCAPE_MACRO, /\\[^\n\r\f0-9a-f]/ );
			
			//nmchar			[_a-z0-9-]|{nonascii}|{escape}
			var nmchar:Token = new Token( NMCHAR_MACRO, /[_a-z0-9-]/ );
			
			//num				[0-9]+|[0-9]*\.[0-9]+
			var num:Token = new Token( NUM_MACRO, /[0-9]+|[0-9]*\.[0-9]+/ );			
			
			//string			{string1}|{string2}
			var string:Token = new Token( STRING_MACRO, /[^\0-\237]/ );			
			
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			var string1:Token = new Token( STRING1_MACRO );
			string1.start = /^[^\\]"/;
			string1.end = /[^\\]"$/;
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			var string2:Token = new Token( STRING2_MACRO, /[^\0-\237]/ );
			
			//badstring		{badstring1}|{badstring2}
			var badstring:Token = new Token( BADSTRING_MACRO, /[^\0-\237]/ );			
			
			//badstring1		\"([^\n\r\f\\"]|\\{nl}|{escape})*\\?
			var badstring1:Token = new Token( BADSTRING1_MACRO, /[^\0-\237]/ );
			
			//badstring2		\'([^\n\r\f\\']|\\{nl}|{escape})*\\?
			var badstring2:Token = new Token( BADSTRING2_MACRO, /[^\0-\237]/ );
			
			//badcomment		{badcomment1}|{badcomment2}
			var badcomment:Token = new Token( BADCOMMENT_MACRO, /[^\0-\237]/ );			
			
			//badcomment1		\/\*[^*]*\*+([^/*][^*]*\*+)*
			var badcomment1:Token = new Token( BADCOMMENT1_MACRO, /[^\0-\237]/ );
			
			//badcomment2		\/\*[^*]*(\*+[^/*][^*]*)*
			var badcomment2:Token = new Token( BADCOMMENT2_MACRO, /[^\0-\237]/ );
			
			//baduri			{baduri1}|{baduri2}|{baduri3}
			var baduri:Token = new Token( BADCOMMENT_MACRO, /[^\0-\237]/ );			
			
			//baduri1			url\({w}([!#$%&*-~]|{nonascii}|{escape})*{w}
			var baduri1:Token = new Token( BADCOMMENT1_MACRO, /[^\0-\237]/ );
			
			//baduri2			url\({w}{string}{w}
			var baduri2:Token = new Token( BADCOMMENT2_MACRO, /[^\0-\237]/ );
			
			//baduri3			url\({w}{badstring}	
			var baduri3:Token = new Token( BADCOMMENT2_MACRO, /[^\0-\237]/ );
			
			//nl				\n|\r\n|\r|\f
			var nl:Token = new Token( NL_MACRO, /\n|\r\n|\r|\f/ );
			
			//w				[ \t\r\n\f]*
			var w:Token = new Token( W_MACRO, /[ \t\r\n\f]*/ );
			
			//build macro relationships - TODO: QUALIFIERS * | +
			//ident.combinations.push( nmstart, nmchar );
			name.combinations.push( nmchar );
			
			//alteratives for matching						
			nmstart.alternatives.push( nonascii, escape );
			nmchar.alternatives.push( nonascii, escape );
			escape.alternatives.push( unicode );
			
			badstring.alternatives.push(
				badstring1, badstring2 );
			badcomment.alternatives.push(
				badcomment1, badcomment2 );
			baduri.alternatives.push(
				baduri1, baduri2, baduri3 );
			
			
			//STATEMENTS
			var stylesheet:Token = new Token( STYLESHEET );
			
			//TOKENS
			var cdo:Token = new Token( CDO, /^(<\!\-\-)/ );
			var cdc:Token = new Token( CDC, /^(\-\->)/ );
			var s:Token = new Token( S, /^([ \t\r\n\f]+)/ );
			
			var identToken:Token = new Token(
				IDENT, /^([\-]?[_a-zA-Z]+[_a-zA-Z0-9\-]*)/ );
			
			//identToken.combinations.push( ident );
			
			var at:Token = new Token(
				ATKEYWORD, /^(@[\-]?[_a-z]+[_a-z0-9\-]*)/ );
			
			var badStringToken:Token = new Token( BAD_STRING );
			badStringToken.alternatives.push( badstring );
			
			var badUriToken:Token = new Token( BAD_URI );
			badUriToken.alternatives.push( baduri );
			
			var badCommentToken:Token = new Token( BAD_COMMENT );
			badCommentToken.alternatives.push( badcomment );
			
			var semiColonToken:Token = new Token( SEMI_COLON, /^(;)/ );
			var colonToken:Token = new Token( COLON, /^(:)/ );
			
			var leftBrace:Token = new Token( LEFT_BRACE, /^(\{)/ );
			var rightBrace:Token = new Token( RIGHT_BRACE, /^(\})/ );
			
			var leftParentheses:Token = new Token( LEFT_PARENTHESES, /^(\()/ );
			var rightParentheses:Token = new Token( RIGHT_PARENTHESES, /^(\))/ );
			
			var leftBracket:Token = new Token( LEFT_BRACKET, /^(\[)/ );
			var rightBracket:Token = new Token( RIGHT_BRACKET, /^(\])/ );
			
			var hashToken:Token = new Token( HASH, /^(#[_a-z0-9-]+)/ );
			
			var numberToken:Token = new Token( NUMBER, /^([0-9]*\.?[0-9]+)/ );
			
			var percentToken:Token = new Token( PERCENTAGE );
			percentToken.combinations.push( num, "%" );
			
			var dimensionToken:Token = new Token( DIMENSION );
			dimensionToken.combinations.push( num, ident );
			
			var commentToken:Token = new Token( COMMENT, /^\/\*[^\/][^\*]*\*\/$/ );
			commentToken.start = /\/\*/;
			commentToken.end = /\*\//;
			
			/*/\/\*[^*]*\*+([^/*][^*]*\*+)*\/*/
			
			
			//|\\{nl}|{escape}
			var stringToken:Token = new Token( STRING, /^(\"[^\n\r\f\\"]*\")/ );			
			
			this.tokens.push( stylesheet );	
			
			this.tokens.push( identToken );			
			
			this.tokens.push( at );
			this.tokens.push( stringToken );
			
			this.tokens.push( badStringToken );
			this.tokens.push( badUriToken );
			this.tokens.push( badCommentToken );
			
			this.tokens.push( hashToken );			
			this.tokens.push( numberToken );
			this.tokens.push( percentToken );			
			this.tokens.push( dimensionToken );						
			
			this.tokens.push( cdo );
			this.tokens.push( cdc );
			
			this.tokens.push( semiColonToken );
			this.tokens.push( colonToken );
			
			this.tokens.push( leftBrace );
			this.tokens.push( rightBrace );
			
			this.tokens.push( leftParentheses );
			this.tokens.push( rightParentheses );
			
			this.tokens.push( leftBracket );
			this.tokens.push( rightBracket );						
			
			this.tokens.push( s );
			
			this.tokens.push( commentToken );		
			
			
			/*
			
			IDENT		{ident}
			ATKEYWORD	@{ident}
			STRING		{string}
			BAD_STRING	{badstring}
			BAD_URI		{baduri}
			BAD_COMMENT	{badcomment}
			HASH		#{name}
			NUMBER		{num}
			PERCENTAGE	{num}%
			DIMENSION	{num}{ident}
			URI			url\({w}{string}{w}\)
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
			
			*/
		}
	}










/*



Token	Definition

IDENT		{ident}
ATKEYWORD	@{ident}
STRING		{string}
BAD_STRING	{badstring}
BAD_URI		{baduri}
BAD_COMMENT	{badcomment}
HASH		#{name}
NUMBER		{num}
PERCENTAGE	{num}%
DIMENSION	{num}{ident}
URI			url\({w}{string}{w}\)
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

}

