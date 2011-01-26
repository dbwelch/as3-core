package com.ffsys.token
{
	
	/*



	Token	Definition

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
		
		/**
		* 	The identifier for an includes token.
		*/
		public static const INCLUDES:int = 25;
		
		/**
		* 	The identifier for a dashmatch token.
		*/
		public static const DASHMATCH:int = 26;
		
		/**
		* 	The identifier for a delim token.
		*/
		public static const DELIM:int = 99;

		/**
		* 	Creates a <code>CssTokenizer</code> instance.
		*/
		public function CssTokenizer()
		{
			super();
		}
		
		override protected function configure():void
		{
			//MACRO EXPRESSIONS
			const NONASCII_EXP:String
				= "[" + String.fromCharCode( 0x0080 )
				+ "-" + String.fromCharCode( 0xFFFFF ) + "]";
			
			const NUM_EXP:String = "([0-9]+\.)?[0-9]+";
			
			//nl				\n|\r\n|\r|\f
			const NL_EXP:String = "\n|\r\n|\r|\f";
			//w					[ \t\r\n\f]*
			const W_EXP:String = "[ \t\r\n\f]*";
			
			const UNICODE_EXP:String =
				"(\\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?)";
				
			const ESCAPE_EXP:String =
				UNICODE_EXP + "|\\[^\n\r\f0-9a-f]";
				
			//  + "|\\" + NL_EXP
			
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			const STRING1_EXP:String =
				"\"([^\n\r\f\\\"]" + "|\\" + NL_EXP + "|" + ESCAPE_EXP + ")*\"";
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"'([^\n\r\f\\']" + "|\\" + NL_EXP + "|" + ESCAPE_EXP + ")*'";
				
			const UNICODE_RANGE_EXP:String =
				"(u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?)";
			const NMSTART_EXP:String =
				"(" + "[_a-zA-Z]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP + ")";
			const NMCHAR_EXP:String =
				"(" + "[_a-zA-Z0-9-]" + "|" + NONASCII_EXP + "|" + ESCAPE_EXP + ")";
			const NAME_EXP:String =
				"(" + NMCHAR_EXP + "+" + ")";
			const IDENT_EXP:String =
				"[\-]?[_a-zA-Z]+[_a-zA-Z0-9\-]*";
			const ATKEYWORD_EXP:String = "@" + IDENT_EXP;
			const HASH_EXP:String = "#" + NAME_EXP;
			const DIMENSION_EXP:String = NUM_EXP + IDENT_EXP;
			const PERCENT_EXP:String = NUM_EXP + "%";
			const INCLUDES_EXP:String = "~=";
			const DASHMATCH_EXP:String = "\\|=";			
			
			//TOKENS
			var stylesheet:Token = new Token( STYLESHEET );	
			var cdo:Token = new Token( CDO, /^(<\!\-\-)/ );
			var cdc:Token = new Token( CDC, /^(\-\->)/ );
			var s:Token = new Token( S, /^([ \t\r\n\f]+)/ );
			
			var at:Token = new Token(
				ATKEYWORD, new RegExp( "^(" + ATKEYWORD_EXP + ")" ) );
			
			var hash:Token = new Token(
				HASH, new RegExp( "^(" + HASH_EXP + ")" ) );
			
			var ident:Token = new Token(
				IDENT, new RegExp( "^(" + IDENT_EXP + ")" ) );								
			
			//single character tokens
			var semiColon:Token = new Token(
				SEMI_COLON, /^(;)/ );
			var colon:Token = new Token(
				COLON, /^(:)/ );
			var leftBrace:Token = new Token(
				LEFT_BRACE, /^(\{)/ );
			var rightBrace:Token = new Token(
				RIGHT_BRACE, /^(\})/ );
			var leftParentheses:Token = new Token(
				LEFT_PARENTHESES, /^(\()/ );
			var rightParentheses:Token = new Token(
				RIGHT_PARENTHESES, /^(\))/ );
			var leftBracket:Token = new Token(
				LEFT_BRACKET, /^(\[)/ );
			var rightBracket:Token = new Token(
				RIGHT_BRACKET, /^(\])/ );
			
			//numeric tokens
			var num:Token = new Token( NUMBER,
				new RegExp( "^(" + NUM_EXP + ")" ) );
			var percent:Token = new Token( PERCENTAGE,
				new RegExp( "^(" + PERCENT_EXP + ")" ) );
			var dimension:Token = new Token( DIMENSION,
				new RegExp( "^(" + DIMENSION_EXP + ")" ) );
			
			//comment token
			var comment:Token = new Token(
				COMMENT, /^(\/\*[^\*]*\*\/)/ );
			comment.start = /\/\*/;
			comment.end = /\*\//;

			var string1:Token = new Token( STRING,
				new RegExp( "^(" + STRING1_EXP + ")" ) );
				
			var string2:Token = new Token( STRING,
				new RegExp( "^(" + STRING2_EXP + ")" ) );				
			
			/*/\/\*[^*]*\*+([^/*][^*]*\*+)*\/*/
			
			//bad values
			var badStringToken:Token = new Token( BAD_STRING );
			var badUriToken:Token = new Token( BAD_URI );
			var badCommentToken:Token = new Token( BAD_COMMENT );	
			
			var includes:Token = new Token( INCLUDES,
				new RegExp( "^(" + INCLUDES_EXP + ")" ) );
									
			var dashmatch:Token = new Token( DASHMATCH,
				new RegExp( "^(" + DASHMATCH_EXP + ")" ) );
			
			//|\\{nl}|{escape}	
			
			this.tokens.push( stylesheet );	
			
			this.tokens.push( ident );
			this.tokens.push( at );
			
			this.tokens.push( badStringToken );
			this.tokens.push( badUriToken );
			this.tokens.push( badCommentToken );
			
			this.tokens.push( hash );			
			
			this.tokens.push( string1 );
			this.tokens.push( string2 );
					
			this.tokens.push( dimension );						
			this.tokens.push( percent );
			this.tokens.push( num );
			
			this.tokens.push( cdo );
			this.tokens.push( cdc );
			
			this.tokens.push( semiColon );
			this.tokens.push( colon );
			this.tokens.push( leftBrace );
			this.tokens.push( rightBrace );
			this.tokens.push( leftParentheses );
			this.tokens.push( rightParentheses );
			this.tokens.push( leftBracket );
			this.tokens.push( rightBracket );						
			
			this.tokens.push( s );
			
			this.tokens.push( comment );
			
			this.tokens.push( includes );
			this.tokens.push( dashmatch );
			
			
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
			URI			url\({w}{string}{w}\)
						|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
			//todo						
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
			
			//todo
			FUNCTION	{ident}\(
			
			INCLUDES	~=
			DASHMATCH	|=
			DELIM	any other character not matched by the above rules, and neither a single nor a double quote			
			
			*/
			
			
			//final catch all
			var delim:Token = new Token( DELIM, /^([^'"])/ );			
			this.tokens.push( delim );			
		}
	}
}