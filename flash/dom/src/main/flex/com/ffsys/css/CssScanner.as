package com.ffsys.css
{
	import com.ffsys.scanner.*;
	
	/**
	*	A lexical scanner for css text.
	* 
	* 	This scanner implementation attempts to
	* 	adhere to the <code>CSS3</code> grammar specification.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	public class CssScanner extends Scanner
	{		
		/**
		* 	A prefix used when building token names.
		*/
		public static const NAME_PREFIX:String = ":";
		
		/**
		* 	The identifier for a BOM token.
		*/
		public static const BOM:int = 0;	
		
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
		* 	The identifier for a uri token.
		*/
		public static const URI:int = 8;
		
		/**
		* 	The identifier for a unicode range token.
		*/
		public static const UNICODE_RANGE:int = 9;
		
		/**
		* 	The identifier for a comment data open token.
		*/
		public static const CDO:int = 10;
		
		/**
		* 	The identifier for a comment data close token.
		*/
		public static const CDC:int = 11;
		
		/**
		* 	The identifier for a space token.
		*/
		public static const S:int = 12;
		
		/**
		* 	The identifier for a function token.
		*/
		public static const FUNCTION:int = 13;
		
		/**
		* 	The identifier for a comment token.
		*/
		public static const COMMENT:int = 14;		
		
		/**
		* 	The identifier for an includes token.
		*/
		public static const INCLUDES:int = 15;
		
		/**
		* 	The identifier for a dashmatch token.
		*/
		public static const DASHMATCH:int = 16;
		
		/**
		* 	The identifier for a prefixmatch token.
		*/
		public static const PREFIXMATCH:int = 17;
		
		/**
		* 	The identifier for a suffixmatch token.
		*/
		public static const SUFFIXMATCH:int = 18;
		
		/**
		* 	The identifier for a substringmatch token.
		*/
		public static const SUBSTRINGMATCH:int = 19;
		
		//GRAMMAR PRODUCT TOKENS
		
		/**
		* 	The identifier for a stylesheet token.
		*/
		public static const STYLESHEET:int = 100;
		
		/**
		* 	The identifier for a charset token.
		*/
		public static const CHARSET:int = 101;
		
		/**
		* 	The identifier for an import token.
		*/
		public static const IMPORT:int = 102;
		
		/**
		* 	The identifier for a namespace token.
		*/
		public static const NAMESPACE:int = 103;
		
		/**
		* 	The identifier for a media token.
		*/
		public static const MEDIA:int = 104;
		
		/**
		* 	The identifier for a page token.
		*/
		public static const PAGE:int = 105;
		
		/**
		* 	The identifier for a font-face token.
		*/
		public static const FONT_FACE:int = 106;
		
		/**
		* 	The identifier for a medium token.
		*/
		public static const MEDIUM:int = 107;		
		
		/**
		* 	The identifier for a pseudo page token.
		*/
		public static const PSEUDO_PAGE:int = 108;
		
		/**
		* 	The identifier for an operator token.
		*/
		public static const OPERATOR:int = 109;
		
		/**
		* 	The identifier for a combinator token.
		*/
		public static const COMBINATOR:int = 110;
		
		/**
		* 	The identifier for a unary operator token.
		*/
		public static const UNARY_OPERATOR:int = 111;
		
		/**
		* 	The identifier for a property token.
		*/
		public static const PROPERTY:int = 112;
		
		/**
		* 	The identifier for a ruleset token.
		*/
		public static const RULSESET:int = 113;
		
		/**
		* 	The identifier for a selector token.
		*/
		public static const SELECTOR:int = 114;
		
		/**
		* 	The identifier for a simple selector token.
		*/
		public static const SIMPLE_SELECTOR:int = 115;
		
		/**
		* 	The identifier for a class token.
		*/
		public static const CLASS:int = 116;
		
		/**
		* 	The identifier for an element name token.
		*/
		public static const ELEMENT_NAME:int = 117;
		
		/**
		* 	The identifier for an attrib token.
		*/
		public static const ATTRIB:int = 118;
		
		/**
		* 	The identifier for a pseudo token.
		*/
		public static const PSEUDO:int = 119;
		
		/**
		* 	The identifier for a declaration token.
		*/
		public static const DECLARATION:int = 120;
		
		/**
		* 	The identifier for a prio token.
		*/
		public static const PRIO:int = 121;
		
		/**
		* 	The identifier for an expr token.
		*/
		public static const EXPR:int = 122;
		
		/**
		* 	The identifier for a term token.
		*/
		public static const TERM:int = 123;
		
		/**
		* 	The identifier for a method (function) token.
		*/
		public static const METHOD:int = 124;
		
		/**
		* 	The identifier for a hexcolor token.
		*/
		public static const HEXCOLOR:int = 125;
		
		/**
		* 	The identifier for an important token.
		*/
		public static const IMPORTANT:int = 126;
		
		/**
		* 	The identifier for a namespace prefix token.
		*/
		public static const NAMESPACE_PREFIX:int = 127;	
		
		//UNIT/NUMERIC TOKENS
		
		/**
		* 	The identifier for a number token.
		*/
		public static const NUMBER:int = 200;
		
		/**
		* 	The identifier for a percentage token.
		*/
		public static const PERCENTAGE:int = 201;		
		
		/**
		* 	The identifier for an ems token.
		*/
		public static const EMS:int = 202;
		
		/**
		* 	The identifier for an exs token.
		*/
		public static const EXS:int = 203;
		
		/**
		* 	The identifier for a length token.
		*/
		public static const LENGTH:int = 204;
		
		/**
		* 	The identifier for an angle token.
		*/
		public static const ANGLE:int = 205;
		
		/**
		* 	The identifier for a time token.
		*/
		public static const TIME:int = 206;
		
		/**
		* 	The identifier for a freq token.
		*/
		public static const FREQ:int = 207;
		
		/**
		* 	The identifier for a dimension token.
		*/
		public static const DIMENSION:int = 208;
		
		//DEFAULT TOKEN	
		
		/**
		* 	The identifier for a char token.
		*/
		public static const CHAR:int = 500;
		
		//ADDITIONAL SYMBOLS
		
		/**
		* 	The symbol for a <code>important</code> statement.
		*/
		public static const IMPORTANT_SYM:String = "!important";
		
		private var _whitespace:Boolean = false;
		private var _comments:Boolean = false;

		/**
		* 	Creates a <code>CssScanner</code> instance.
		*/
		public function CssScanner()
		{
			super();
		}
		
		/**
		* 	Determines whether whitespace is preserved,
		* 	the default value is <code>false</code>.
		* 
		* 	Whitespace is ignored by default.
		*/
		public function get whitespace():Boolean
		{
			return _whitespace;
		}
		
		public function set whitespace( value:Boolean ):void
		{
			_whitespace = value;
		}
		
		/**
		* 	Determines whether multiline comments are preserved,
		* 	the default value is <code>false</code>.
		*/
		public function get comments():Boolean
		{
			return _comments;
		}
		
		public function set comments( value:Boolean ):void
		{
			_comments = value;
		}
		
		override protected function configure():void
		{
			//**************************** MACRO EXPRESSIONS ****************************//
			
			//
			const BOM_EXP:String = "[\\uFEFF]{1}";
			
			//h					[0-9a-f]
			const H_EXP:String
				= "[0-9a-fA-F]";

			//const NONASCII_EXP:String = "[\\u0080-\\uFFFF]";
			//const NONASCII_EXP:String = "[^\\\\x00-\\\\xED]";		
				
			//nonascii			[\200-\377] (3) - TODO | \\\\xC8-\\\\x179 | \\u00C8-\\uFFFF
			//= "[\\u0080-\\uD7FF\\uE000-\\uFFFD\\u10000-\\u10FFFF]";
			
			/*
			const NONASCII_EXP:String				
				= "[" + String.fromCharCode( 0x0080 )
				+ "-" + String.fromCharCode( 0xD7FF )
				+ String.fromCharCode( 0xE000 )
				+ "-" + String.fromCharCode( 0xFFFD ) + "]";
			*/
			
			//const NONASCII_EXP:String = "[\\u0080-\\uD7FF\\uE000-\\uFFFD\\u10000-\\u10FFFF]";
			
				/*
				= String.fromCharCode( 0x0080 )
				+ "-" + String.fromCharCode( 0xD7FF )
				+ String.fromCharCode( 0xE000 )
				+ "-" + String.fromCharCode( 0xFFFD );
				*/	
				

			//nonascii			[^\0-\237] (2.1)
			const NONASCII_EXP:String
				= "[" + String.fromCharCode( 0x0080 )
				+ "-" + String.fromCharCode( 0xFFFF ) + "]";				
				
			//num					[0-9]+|[0-9]*\.[0-9]+
			const NUM_EXP:String = "([0-9]*\\.?[0-9]+)";
			
			//nl					\n|\r\n|\r|\f
			const NL_EXP:String = "\n|\r\n|\r|\f";
			
			//wc					[ \t\r\n\f]
			const WC_EXP:String = "[ \t\r\n\f]";
			
			//w						{wc}*
			const W_EXP:String = "(" + WC_EXP + "*)";
			
			//unicode				'\' [0-9a-fA-F]{1,6} {wc}?
			const UNICODE_EXP:String =
				"(\\\\" + H_EXP + "{1,6})";
			
			//escape				{unicode} | '\' [^\n\r\f0-9a-f] (2.1)
			//escape				{unicode} | '\' [] (3)			
			const ESCAPE_EXP:String =
				UNICODE_EXP;// + "|\\\\[^\n\r\f0-9a-f]";			

				//UNICODE_EXP + "|\\\\[\\\\x0020-\\\\x007E\\\\x0080-\\\\xD7FF\\\\xE000-\\\\xFFFD]";
			
			//nmstart				[_a-z]|{nonascii}|{escape}			(2.1)
			const NMSTART_EXP:String =
				"[_a-z\\-]" ;//+ "|" + NONASCII_EXP;//+ "|" + NONASCII_EXP + "|" + ESCAPE_EXP;

			//nmchar				[_a-z0-9-]|{nonascii}|{escape} 		(2.1)
			const NMCHAR_EXP:String =
				"[_a-zA-Z0-9\\-]" ;//+ "|" + NONASCII_EXP;//+ "|" + NONASCII_EXP + "|" + ESCAPE_EXP;
				

			//name					{nmchar}+
			const NAME_EXP:String =
				"(?:" + NMCHAR_EXP + ")+";

			//IDENT					{ident}
			//ident					[-]?{nmstart}{nmchar}*	
			const IDENT_EXP:String =
				"-?" + NMSTART_EXP + "+" + NMCHAR_EXP + "*";
			
			//urlchar				[#x9#x21#x23-#x26#x27-#x7E] | {nonascii} | {escape}
			const URLCHAR_EXP:String =
				"[\\u0009\\u0021\\u0023-\\u0026\\u0027-\\u007E]"
				+ "|" + NONASCII_EXP + "|" + ESCAPE_EXP;
				
			//stringchar			{urlchar} | #x20 | '\' {nl}
			const STRINGCHAR_EXP:String =
				URLCHAR_EXP
				+ "|\\u0020|\\\\" + NL_EXP;
			
			/*
			//escape			{unicode}|\\[ -~\200-\377] (3) - TODO
			const ESCAPE_EXP:String =
				UNICODE_EXP + "|\\\\[ -~]|" + NONASCII_EXP;
			*/
			
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			const STRING1_EXP:String =
				"\"((?:[^\"\n\r\f]"
				+ "|\\\\" + NL_EXP
				+ "|"
				+ ESCAPE_EXP + ")*)\"";
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"'((?:[^'\n\r\f]*"
				+ "|\\\\" + NL_EXP
				+ "*|" + ESCAPE_EXP + ")*)'";
			
			/*
			//string1			\"([^\n\r\f\\"]|\\{nl}|{escape})*\"
			const STRING1_EXP:String =
				"\"(" + STRINGCHAR_EXP + "|')*\"";

			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"'(" + STRINGCHAR_EXP + "|\")*'";			
			*/
			
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
				
			//UNICODE-RANGE		U\+[0-9A-F?]{1,6}(-[0-9A-F]{1,6})?
			const UNICODE_RANGE_EXP:String =
				"U\\+([0-9A-F?]{1,6})(?:-)([0-9A-F]{1,6})?";
			
			//ATKEYWORD			@{ident}
			const ATKEYWORD_EXP:String = "@" + IDENT_EXP;
			
			//HASH				#{name}
			const HASH_EXP:String = "#" + NAME_EXP;
			
			//DIMENSION			{num}{ident}
			const DIMENSION_EXP:String = NUM_EXP + IDENT_EXP;
			
			//PERCENTAGE		{num}%
			const PERCENT_EXP:String = NUM_EXP + StyleUnit.PERCENTAGE_EXP;
			
			//EQUALITY			=
			const EQUALITY_EXP:String = "=";
			
			//INCLUDES			~=
			const INCLUDES_EXP:String = "~=";
			
			//DASHMATCH			|=
			const DASHMATCH_EXP:String = "\\|=";
			
			//PREFIXMATCH		^=
			const PREFIXMATCH_EXP:String = "\\^=";
			
			//SUFFIXMATCH		$=
			const SUFFIXMATCH_EXP:String = "\\$=";
			
			//SUBSTRINGMATCH	*=
			const SUBSTRINGMATCH_EXP:String = "\\*=";
			
			//ATTRIB			'|=' | '^=' | '$=' | '*=' | '='
			const ATTRIB_OPERATOR:String =
				"("
				+ INCLUDES_EXP
				+ "|" + DASHMATCH_EXP
				+ "|" + PREFIXMATCH_EXP
				+ "|" + SUFFIXMATCH_EXP
				+ "|" + SUBSTRINGMATCH_EXP								
				+ "|" + EQUALITY_EXP				
				+ ")";
			
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
			
			//WHITESPACE MATCH
			const S_EXP:String = "([ \\t\\r\\n\\f]+)";
			
			//PRIO/IMPORTANT				!important
			const PRIO_EXP:String = "!(" + W_EXP + ")?important";
			
			//HEXCOLOR						#000000 | #000
			const HEXCOLOR_EXP:String = "#(" + H_EXP + "{6}|" + H_EXP + "{3})"
			
			//**************************** TOKENS ****************************//
			
			//BOM				#xFEFF
			var bom:Token = new Token(
				BOM, new RegExp( "^(" + BOM_EXP + ")" ) );
			bom.name = NAME_PREFIX + "bom";
				
			//TODO: add single functionality to the BOM token as it should only be
			//specified once and can be removed after a match

			//IDENT				{ident}
			var ident:Token = new Token(
				IDENT, new RegExp( "^(" + IDENT_EXP + ")", "i" ) );
			ident.name = NAME_PREFIX + "ident";
				
			//ATKEYWORD			@{ident}
			var at:Token = new Token(
				ATKEYWORD, new RegExp( "^(" + ATKEYWORD_EXP + ")", "i" ) );
			at.name = NAME_PREFIX + "at";
				
			//STRING			{string}
			var string:Token = new Token(
				STRING, new RegExp( "^(" + STRING_EXP + ")", "i" ) );
			string.name = NAME_PREFIX + "string";
				
			//BAD_STRING		{badstring}
			var badString:Token = new Token(
				BAD_STRING, new RegExp( "^(" + BAD_STRING_EXP + ")", "i" ) );
			badString.name = NAME_PREFIX + "badstring";				

			//BAD_URI			{baduri}
			var badUri:Token = new Token(
				BAD_URI, new RegExp( "^(" + BAD_URI_EXP + ")", "i" ) );
			badUri.name = NAME_PREFIX + "baduri";				
			
			//BAD_COMMENT		{badcomment}
			var badComment:Token = new Token(
				BAD_COMMENT, new RegExp( "^(" + BAD_COMMENT_EXP + ")", "i" ) );
			badComment.name = NAME_PREFIX + "badcomment";				
				
			//HASH				#{name}
			var hash:Token = new Token(
				HASH, new RegExp( "^(" + HASH_EXP + ")", "i" ) );
			hash.name = NAME_PREFIX + "hash";
			
			//URI				url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
			var uri:Token = new Token( URI,
				new RegExp( "^(" + URI_EXP + ")", "i" ) );
			uri.name = NAME_PREFIX + "uri";				
			
			//UNICODE-RANGE		u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			var range:Token = new Token( UNICODE_RANGE,
				new RegExp( "^(" + UNICODE_RANGE_EXP + ")", "i" ) );
			range.name = NAME_PREFIX + "unicode-range";				
			
			//CDO				<!--
			var cdo:Token = new Token(
				CDO, new RegExp( "^(" + CDO_EXP + ")" ) );
			cdo.name = NAME_PREFIX + "cdo";				
			
			//CDC				-->
			var cdc:Token = new Token(
				CDC, new RegExp( "^(" + CDC_EXP + ")" ) );
			cdc.name = NAME_PREFIX + "cdc";				

			//S					[ \t\r\n\f]+
			var s:Token = new Token(
				S, new RegExp( "^(" + S_EXP + ")" ) );
			s.capture = whitespace;
			s.name = NAME_PREFIX + "whitespace";				
			
			//INCLUDES			~=
			var includes:Token = new Token(
				INCLUDES,
				new RegExp( "^(" + INCLUDES_EXP + ")" ) );
			includes.name = NAME_PREFIX + "includes";				
			
			//DASHMATCH			|=
			var dashmatch:Token = new Token(
				DASHMATCH,
				new RegExp( "^(" + DASHMATCH_EXP + ")" ) );	
			dashmatch.name = NAME_PREFIX + "dashmatch";				
				
			//PREFIXMATCH		^=
			var prefixmatch:Token = new Token(
				PREFIXMATCH,
				new RegExp( "^(" + PREFIXMATCH_EXP + ")" ) );
			prefixmatch.name = NAME_PREFIX + "prefixmatch";				
				
			//SUFFIXMATCH		$=
			var suffixmatch:Token = new Token(
				SUFFIXMATCH,
				new RegExp( "^(" + SUFFIXMATCH_EXP + ")" ) );
			suffixmatch.name = NAME_PREFIX + "suffixmatch";				
				
			//SUBSTRINGMATCH	$=
			var substringmatch:Token = new Token(
				SUBSTRINGMATCH,
				new RegExp( "^(" + SUBSTRINGMATCH_EXP + ")" ) );
			substringmatch.name = NAME_PREFIX + "substringmatch";								
			
			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			var comment:Token = new Token(
				COMMENT, new RegExp( "^(" + COMMENT_EXP + ")" ) );	
			comment.capture = comments;
			comment.name = NAME_PREFIX + "comment";
				
			//FUNCTION			{ident}\(
			var method:Token = new Token(
				FUNCTION, new RegExp( "^(" + FUNCTION_EXP + ")" ) );
			method.name = NAME_PREFIX + "function";				
							
			//CHAR	any other character not matched by the above rules,
			//and neither a single nor a double quote
			var char:Token = new Token(
				CHAR, new RegExp( "^(" + CHAR_EXP + ")" ) );
			char.name = NAME_PREFIX + "char";
				
			//**************************** GRAMMAR TOKENS ****************************//
			
			//CHARSET			@charset
			var charset:Token = new Token(
				CHARSET,
				new RegExp( "^(" + AtRule.CHARSET_SYM + ")" ) );
			charset.name = NAME_PREFIX + "charset";
			
			//IMPORT			@import
			var css:Token = new Token(
				IMPORT,
				new RegExp( "^(" + AtRule.IMPORT_SYM + ")" ) );
			css.name = NAME_PREFIX + "import";
			
			//NAMESPACE-PREFIX	[ IDENT ] '|'
			const NAMESPACE_PREFIX_EXP:String = IDENT_EXP;
			var nsprefix:Token = new Token(
				NAMESPACE_PREFIX,
				new RegExp( "^(" + NAMESPACE_PREFIX_EXP + ")" + "\\|" ) );
			nsprefix.name = NAME_PREFIX + "prefix";			
				
			//NAMESPACE			@namespace
			const NAMESPACE_EXP:String = 
				AtRule.NAMESPACE_SYM
				+ W_EXP
				+ "("
				+ NAMESPACE_PREFIX_EXP
				+ ")?"
				+ W_EXP				
				+ "("
				+ "(" + URI_EXP + ")"
				+ "|(" + STRING_EXP + ")"
				+ ")"
				+ W_EXP
				+ "(;)";
			var ns:Token = new Token(
				NAMESPACE,
				new RegExp( "^("
					+ NAMESPACE_EXP
					+ ")" + W_EXP ) );
			ns.name = NAME_PREFIX + "namespace";
				
			//PAGE				@page
			var page:Token = new Token(
				PAGE,
				new RegExp( "^(" + AtRule.PAGE_SYM + ")" ) );
			page.name = NAME_PREFIX + "page";
				
			//MEDIA				@media
			var media:Token = new Token(
				MEDIA,
				new RegExp( "^(" + AtRule.MEDIA_SYM + ")" ) );
			media.name = NAME_PREFIX + "media";
				
			//FONT-FACE			@font-face
			var fontface:Token = new Token(
				FONT_FACE,
				new RegExp( "^(" + AtRule.FONT_FACE_SYM + ")" ) );
			fontface.name = NAME_PREFIX + "font-face";
				
			//PRIO				!important
			var prio:Token = new Token(
				PRIO,
				new RegExp( "^(" + PRIO_EXP + ")" + W_EXP ) );
			prio.name = NAME_PREFIX + "important";
				
			//OPERATOR			'/' | ','
			const OPERATOR_EXP:String = Selector.OPTIONAL + "|" + Selector.DELIMITER;
			var operator:Token = new Token(
				OPERATOR, new RegExp( "^("
					+ OPERATOR_EXP + ")" + W_EXP ) );
			operator.name = NAME_PREFIX + "operator";					
								
			//COMBINATOR		'+' | '>' | '~'
			const COMBINATOR_EXP:String =
				"(\\" + Selector.ADJACENT_SIBLING
				+ "|" + Selector.CHILD
				+ "|" + Selector.GENERAL_SIBLING + ")";
			var combinator:Token = new Token(
				COMBINATOR, new RegExp( "^("
					+ COMBINATOR_EXP
					+ ")" + W_EXP ) );
			combinator.name = NAME_PREFIX + "combinator";					
				
			//UNARY-OPERATOR	'-' | '+'
			const UNARY_OPERATOR_EXP:String = "(\\+|-)";
			var unary:Token = new Token(
				UNARY_OPERATOR, new RegExp( "^(" + UNARY_OPERATOR_EXP + ")" + W_EXP + NUM_EXP ) );
			unary.name = NAME_PREFIX + "unary";
				
			//CLASS				'.' IDENT
			const CLASS_EXP:String = "\\." + IDENT_EXP;
			var clazz:Token = new Token(
				CLASS, new RegExp( "^(" + CLASS_EXP + ")" ) );
			clazz.name = NAME_PREFIX + "class";		
				
			//ELEMENT-NAME		IDENT | '*'
			const ELEMENT_NAME_EXP:String = "(\\" + Selector.UNIVERSAL + "|" + IDENT_EXP + ")";
			var element:Token = new Token(
				ELEMENT_NAME, new RegExp( "^(" + ELEMENT_NAME_EXP + ")" ) );
			element.name = NAME_PREFIX + "element-name";
			
			//SIMPLE-SELECTOR	element_name? [HASH|class|attrib|pseudo]* S*
			const SIMPLE_SELECTOR_EXP:String =
				"(" + ELEMENT_NAME_EXP + ")?"
				+ "("
				+ ATTRIB_EXP
				+ "|" + PSEUDO_EXP
				+ "|" + CLASS_EXP				
				+ "|" + HASH_EXP
				+ ")";
				
			var simpleSelector:Token = new Token(
				SIMPLE_SELECTOR, new RegExp(
					"^("
					+ SIMPLE_SELECTOR_EXP
					+ ")", "i" ) );
			simpleSelector.name = NAME_PREFIX + "simple-selector";	
			
			//SELECTOR		element_name? [HASH|class|attrib|pseudo]* S*
			const SELECTOR_EXP:String = 
				SIMPLE_SELECTOR_EXP
				+ "("
				+ COMBINATOR_EXP
				+ SIMPLE_SELECTOR_EXP
				+ ")*";
				
			var selector:Token = new Token(
				SELECTOR, new RegExp(
					"^("
					+ SELECTOR_EXP
					+ ")", "i" ) );
			selector.name = NAME_PREFIX + "selector";
			
			//RULSESET		selector [ ',' S* selector ]*
			const RULSESET_EXP:String =
				SELECTOR_EXP
				+ "(,"
				+ W_EXP
				+ SELECTOR_EXP
				+ ")*";
			var ruleset:Token = new Token(
				RULSESET, new RegExp(
					"^("
					+ RULSESET_EXP
					+ ")", "i" ) );
			ruleset.name = NAME_PREFIX + "ruleset";								
				
			//PROPERTY			IDENT S*
			var property:Token = new Token(
				PROPERTY, new RegExp( "^(" + IDENT_EXP + ")" + W_EXP + ":" + W_EXP ) );
			property.name = NAME_PREFIX + "property";
						
			//ATTRIB
			//[href] | [attr='text'] | [attr="text"] | [attr~=match] | [attr|=match] | [attr^=match] | [attr$=match] | [attr*=match]
			//'[' S* IDENT S* [ '=' | INCLUDES | DASHMATCH | PREFIXMATCH | SUFFIXMATCH | SUBSTRINGMATCH ] S*
			// [ [ STRING | IDENT ] S* ]? ']'
			const ATTRIB_EXP:String =
				"\\["
				+ W_EXP
				+ "("
				+ IDENT_EXP					//wrap the attribute name in a group
				+ ")"
				+ W_EXP
				+ "("
				+ ATTRIB_OPERATOR			
				+ ")"
				+ W_EXP
				+ "("
				+ STRING_EXP
				+ "|" + IDENT_EXP
				+ ")?"
				+ W_EXP
				+ "\\]";
			var attrib:Token = new Token(
				ATTRIB, new RegExp( "^(" + ATTRIB_EXP + ")" ) );
			attrib.name = NAME_PREFIX + "attrib";
			
			//PSEUDO				':' [ FUNCTION S* IDENT S* ')' | IDENT ]
			const PSEUDO_EXP:String =
				":("
				+ IDENT_EXP
				+ ")|("
				+ FUNCTION_EXP
				+ W_EXP				
				+ IDENT_EXP				
				+ W_EXP
				+ "\\)"				//close function call				
				+ ")";
			var pseudo:Token = new Token(
				PSEUDO, new RegExp( "^(" + PSEUDO_EXP + ")" ) );
			pseudo.name = NAME_PREFIX + "pseudo";
			
			//TODO
			const TERM_EXP:String = "((" + UNARY_OPERATOR_EXP + ")?"
				+ "("
				+ StyleUnit.ANGLE_EXP + W_EXP
				+ "|" + StyleUnit.FREQUENCY_EXP + W_EXP
				+ "|" + StyleUnit.LENGTH_EXP + W_EXP
				+ "|" + StyleUnit.TIME_EXP + W_EXP
				+ "|" + StyleUnit.EMS_EXP + W_EXP	
				+ "|" + StyleUnit.EXS_EXP + W_EXP
				+ "|" + PERCENT_EXP + W_EXP
				+ "|" + DIMENSION_EXP + W_EXP
				+ "|" + NUM_EXP + W_EXP
				//TODO: function
				+ ")";
				
				/*
				+ "|" + STRING_EXP + W_EXP
				+ "|" + URI_EXP + W_EXP
				+ "|" + UNICODE_RANGE_EXP + W_EXP
				+ "|" + IDENT_EXP + W_EXP
				+ "|" + HEXCOLOR_EXP + ")";
				*/
			
			//TODO
			const EXPR_EXP:String =
				TERM_EXP + "(" + OPERATOR_EXP + TERM_EXP + ")*";
			
			//DECLARATION		property ':' S* expr prio?
			var declaration:Token = new Token(
				DECLARATION, new RegExp(
					"^("
					+ IDENT_EXP + W_EXP
					+ ":"
					+ W_EXP + TERM_EXP
					+ ")", "i" ) );
			declaration.name = NAME_PREFIX + "declaration";
				
			//HEXCOLOR			#000 | #000000
			var hexcolor:Token = new Token(
				HEXCOLOR, new RegExp( "^(" + HEXCOLOR_EXP + ")" + W_EXP ) );
			hexcolor.name = NAME_PREFIX + "hexcolor";					
				
			//**************************** NUMBER/UNIT TOKENS ****************************//			
			
			//EMS				em
			var ems:Token = new Token(
				EMS, new RegExp( "^(" + NUM_EXP + StyleUnit.EMS_EXP + ")", "i" ) );
			ems.name = NAME_PREFIX + "ems";			
				
			//EXS				ex
			var exs:Token = new Token(
				EXS, new RegExp( "^(" + NUM_EXP + StyleUnit.EXS_EXP + ")", "i" ) );	
			exs.name = NAME_PREFIX + "exs";			
				
			//LENGTH			px|cm|mm|in|pt|pc
			var length:Token = new Token(
				LENGTH,
				new RegExp( "^(" + NUM_EXP + StyleUnit.LENGTH_EXP + ")", "i" ) );
			length.name = NAME_PREFIX + "length";				
				
			//ANGLE				deg|rad|grad
			var angle:Token = new Token(
				ANGLE,
				new RegExp( "^(" + NUM_EXP + StyleUnit.ANGLE_EXP + ")", "i" ) );
			angle.name = NAME_PREFIX + "angle";				
				
			//TIME				ms|s
			var time:Token = new Token(
				TIME,
				new RegExp( "^(" + NUM_EXP + StyleUnit.TIME_EXP + ")", "i" ) );
			time.name = NAME_PREFIX + "time";				
				
			//FREQUENCY			kHz|Hz
			var frequency:Token = new Token(
				FREQ,
				new RegExp( "^(" + NUM_EXP + StyleUnit.FREQUENCY_EXP + ")", "i" ) );
			frequency.name = NAME_PREFIX + "frequency";				
				
			//PERCENTAGE		{num}%
			var percent:Token = new Token(
				PERCENTAGE,
				new RegExp( "^(" + PERCENT_EXP + ")", "i" ) );
			percent.name = NAME_PREFIX + "percent";				
			
			//DIMENSION			{num}{ident}
			var dimension:Token = new Token(
				DIMENSION,
				new RegExp( "^(" + DIMENSION_EXP + ")", "i" ) );
			dimension.name = NAME_PREFIX + "dimension";				
			
			//NUMBER			{num}
			var num:Token = new Token(
				NUMBER,
				new RegExp( "^(" + NUM_EXP + ")" ) );	
			num.name = NAME_PREFIX + "number";
			
			//**************************** TOKEN DEFINITIONS ****************************//
			
			//byte order mark first
			tokens.push( bom );
			
			//whitespace token - match early as it's such a common token
			tokens.push( s );
			
			//code style multiline comment - must be before the operators
			tokens.push( comment );
			
			//match a uri function expression early
			tokens.push( uri );			
			
			//hexcolor before other hash variants
			tokens.push( hexcolor );
			
			//xml style comments
			tokens.push( cdo );
			tokens.push( cdc );
			
			//unicode range  - must match before {ident}
			tokens.push( range );			
			
			//property/expr declaration
			tokens.push( declaration );
			
			//namespace
			tokens.push( ns );				//	@namespace			
			//namespace prefix
			tokens.push( nsprefix );
			
			//property is a priority match
			tokens.push( property );
			
			//ruleset
			tokens.push( ruleset );
			
			//selectors
			tokens.push( selector );
			tokens.push( simpleSelector );
			
			//operators need to take precedence
			tokens.push( operator );			//	'/' | ','
			tokens.push( unary );				//	'-' | '+'			
			
			//attribute match
			tokens.push( attrib );
			
			tokens.push( string );			
			
			//combinator after selectors
			tokens.push( combinator );			//	'+' | '>'
			
			//specific at rules before the generic at rule - before the element name match
			tokens.push( charset );			//	@charset
			tokens.push( css );				//	@import
			tokens.push( page );			//	@page
			tokens.push( media );			//	@media
			tokens.push( fontface );		//	@font-face
			tokens.push( at );				//	@unknown-rule					
			
			//pseudo class selector
			tokens.push( pseudo );				//	:link
			
			//ident based
			tokens.push( clazz );				//	.class
			
			//element name						//	h1 etc.
			tokens.push( element );
			
			//match {baduri} before {ident}
			tokens.push( badUri );		
			
			tokens.push( prio );			//	!important

			tokens.push( ident );
			tokens.push( hash );		
			
			//numeric/unit values should be matched in this order
			tokens.push( angle );
			tokens.push( frequency );
			tokens.push( length );
			tokens.push( time );
			tokens.push( ems );
			tokens.push( exs );
			tokens.push( dimension );
			tokens.push( percent );
			tokens.push( num );
			
			//match bad comments after good ones
			tokens.push( badComment ); 
			
			tokens.push( badString );
			
			//function expression: method()
			tokens.push( method );
			
			//includes operator ~=
			tokens.push( includes );
			
			//dashmatch operator |=
			tokens.push( dashmatch );
			
			//prefixmatch operator ^=
			tokens.push( prefixmatch );
			
			//suffixmatch operator $=
			tokens.push( suffixmatch );
			
			//substringmatch operator *=
			tokens.push( substringmatch );
			
			//final catch all char
			tokens.push( char );	
		}
		
		/**
		* 	Invoked when a token is created from
		* 	a successful match.
		* 
		* 	@param token The matched token.
		*/
		override protected function beginToken( token:Token ):void
		{
			//trace("[CSS START]", token );
		}
		
		/**
		* 	Invoked while a token type has consecutive matches.
		* 
		* 	@param token The matched token.
		*/
		override protected function token( token:Token ):void
		{
			//trace("[CSS TOKEN]", token );
		}
		
		/**
		* 	Invoked when the scanned proceeds to a different token.
		* 
		* 	@param token The matched token.
		*/
		override protected function endToken( token:Token ):void
		{
			trace("[CSS END]", token + ' | ' + token.results );
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