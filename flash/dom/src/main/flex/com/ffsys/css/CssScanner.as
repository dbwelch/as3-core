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
		public static const NAME_PREFIX:String = "";
		
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
		
		/**
		* 	The identifier for a name token.
		*/
		public static const NAME:int = 20;
		
		/**
		* 	The identifier for a block comment token.
		*/
		public static const BLOCK_COMMENT:int = 21;
		
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
		public static const RULESET:int = 113;
		
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
			const BOM_EXP:String = "(?P<bom>[\\uFEFF]{1})";
			
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
			const NUM_EXP:String = "((?:[0-9]*\\.)?[0-9]+)";
			
			//nl					\n|\r\n|\r|\f
			const NL_EXP:String = "(?:\n|\r\n|\r|\f)";
			
			//wc					[ \t\r\n\f]
			const WC_EXP:String = "(?:[ \t\r\n\f])";
			
			//w						{wc}*
			const W_EXP:String = WC_EXP + "*";
			
			//unicode				'\' [0-9a-fA-F]{1,6} {wc}?
			const UNICODE_EXP:String =
				"(\\\\" + H_EXP + "{1,6})";
			
			//escape				{unicode} | '\' [^\n\r\f0-9a-f] (2.1)
			//escape				{unicode} | '\' [] (3)			
			const ESCAPE_EXP:String =
				"(?:" + UNICODE_EXP + "|\\\\[^\n\r\f0-9a-f]" + ")";

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
				"-?" + NMSTART_EXP + "{1}" + NMCHAR_EXP + "*";
			
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
				"(?:\")((?:[^\"\n\r\f]"
				+ "|\\\\" + NL_EXP
				+ "|"
				+ ESCAPE_EXP + ")*)(?:\")";
			
			//string2			\'([^\n\r\f\\']|\\{nl}|{escape})*\'
			const STRING2_EXP:String =
				"(?:')((?:[^'\n\r\f]"
				+ "|\\\\" + NL_EXP
				+ "|" + ESCAPE_EXP + ")*)(?:')";
			
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
				"(?:" + STRING1_EXP + ")|(?:" + STRING2_EXP + ")";
			
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
				"(?:url\\("			//open function call (quoted)
				+ W_EXP
				+ "(?P<uristring>" + STRING_EXP + ")"
				+ W_EXP
				+ "\\)"						//close function call (quoted)
				+ ")|"
				//unquoted uri
				+ "(?:url\\("				//open function call
				+ W_EXP
				+ "((?:[!#$%&*-\\[\\]-~]|"
				+ NONASCII_EXP + "|" + ESCAPE_EXP
				+ ")*)"
				+ W_EXP
				+ "\\)"						//close function call
				+")";						
				
			//URI				url\({w}{string}{w}\)|url\({w}([!#$%&*-\[\]-~]|{nonascii}|{escape})*{w}\)
			var uri:Token = new Token( URI,
				new RegExp( "^(?P<uri>" + URI_EXP + ")" ) );
			uri.name = "uri";				

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
				+ STRING_EXP
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
				"(?P<unicoderange>U\\+([0-9A-F?]{1,6})(?:-)([0-9A-F]{1,6})?)";
			
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
			
			//FUNCTION			{ident}\(
			const FUNCTION_EXP:String = IDENT_EXP + "\\(";

			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			const COMMENT_EXP:String = "(?P<comment>/\\*[^*]*\\*+([^/*][^*]*\\*+)*/)";
			
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
			const S_EXP:String = "(?P<s>[ \\t\\r\\n\\f]+)";
			
			//**************************** TOKENS ****************************//
			
			//BOM				#xFEFF
			

			//the BOM is dicardable token as it should only be
			//specified once and can be removed after a match
			var bom:Token = new Token(
				BOM, new RegExp( "^" + BOM_EXP ) );
			bom.discardable = true;
			bom.maximum = 1;
			bom.name = "bom";

			//IDENT				{ident}
			var ident:Token = new Token(
				IDENT, new RegExp( "^(?P<ident>" + IDENT_EXP + ")", "i" ) );
			ident.name = "ident";
			
			//NAME				{nmchar}+
			var name:Token = new Token(
				NAME, new RegExp( "^(" + NAME_EXP + ")", "i" ) );
			name.name = "name";
				
			//ATKEYWORD			@{ident}
			const ATKEYWORD_EXP:String = "(?P<at>@" + IDENT_EXP + ")";			
			var at:Token = new Token(
				ATKEYWORD, new RegExp( "^" + ATKEYWORD_EXP, "i" ) );
			at.name = "at";
				
			//STRING			{string}
			var string:Token = new Token(
				STRING,
			new RegExp( "^(?P<string>" + STRING_EXP + ")", "i" ) );
			string.name = "string";
				
			//BAD_STRING		{badstring}
			var badString:Token = new Token(
				BAD_STRING, new RegExp( "^(" + BAD_STRING_EXP + ")", "i" ) );
			badString.name = "badstring";				

			//BAD_URI			{baduri}
			var badUri:Token = new Token(
				BAD_URI, new RegExp( "^(" + BAD_URI_EXP + ")", "i" ) );
			badUri.name = "baduri";				
			
			//BAD_COMMENT		{badcomment}
			var badComment:Token = new Token(
				BAD_COMMENT, new RegExp( "^(" + BAD_COMMENT_EXP + ")", "i" ) );
			badComment.name = "badcomment";				
				
			//HASH				#{name}
			const HASH_EXP:String = "(?P<hash>(#)(" + NAME_EXP + "))";
			var hash:Token = new Token(
				HASH, new RegExp( "^" + HASH_EXP, "i" ) );
			hash.name = "hash";			
			
			//UNICODE-RANGE		u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
			var range:Token = new Token(
				UNICODE_RANGE,
				new RegExp( "^" + UNICODE_RANGE_EXP, "i" ) );
			range.name = "unicoderange";				
			
			//CDO				<!--
			const CDO_EXP:String = "(?P<cdo><!--)";			
			var cdo:Token = new Token(
				CDO, new RegExp( "^" + CDO_EXP ) );
			cdo.name = "cdo";			
			
			//CDC				-->
			const CDC_EXP:String = "(?P<cdc>-->)";			
			var cdc:Token = new Token(
				CDC, new RegExp( "^" + CDC_EXP ) );
			cdc.name = "cdc";
			
			//BLOCK-COMMENT		'<!--' {commentdata} '-->'
			const BLOCK_COMMENT_EXP:String =
				"(?P<blockcomment>"
					+ CDO_EXP + "(?P<commentdata>.*)" + CDC_EXP
				+ ")";
			var blockcomment:Token = new Token(
				BLOCK_COMMENT, new RegExp( "^" + BLOCK_COMMENT_EXP ) );
			blockcomment.name = "blockcomment";

			//S					[ \t\r\n\f]+
			var s:Token = new Token(
				S, new RegExp( "^(" + S_EXP + ")" ) );
			s.capture = whitespace;
			s.name = "whitespace";				
			
			//INCLUDES			~=
			var includes:Token = new Token(
				INCLUDES,
				new RegExp( "^(" + INCLUDES_EXP + ")" ) );
			includes.name = "includes";				
			
			//DASHMATCH			|=
			var dashmatch:Token = new Token(
				DASHMATCH,
				new RegExp( "^(" + DASHMATCH_EXP + ")" ) );	
			dashmatch.name = "dashmatch";				
				
			//PREFIXMATCH		^=
			var prefixmatch:Token = new Token(
				PREFIXMATCH,
				new RegExp( "^(" + PREFIXMATCH_EXP + ")" ) );
			prefixmatch.name = "prefixmatch";				
				
			//SUFFIXMATCH		$=
			var suffixmatch:Token = new Token(
				SUFFIXMATCH,
				new RegExp( "^(" + SUFFIXMATCH_EXP + ")" ) );
			suffixmatch.name = "suffixmatch";				
				
			//SUBSTRINGMATCH	$=
			var substringmatch:Token = new Token(
				SUBSTRINGMATCH,
				new RegExp( "^(" + SUBSTRINGMATCH_EXP + ")" ) );
			substringmatch.name = "substringmatch";								
			
			//COMMENT			\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			var comment:Token = new Token(
				COMMENT, new RegExp( "^" + COMMENT_EXP ) );
			comment.capture = comments;
			comment.name = "comment";
				
			//FUNCTION			{ident}\(
			var method:Token = new Token(
				FUNCTION, new RegExp( "^(" + FUNCTION_EXP + ")" ) );
			method.name = "function";				
			
			//HEXCOLOR						#000000 | #000
			const HEXCOLOR_EXP:String = "(?P<hexcolor>#(" + H_EXP + "{6}|" + H_EXP + "{3}))";
			var hexcolor:Token = new Token(
				HEXCOLOR, new RegExp( "^(?:" + HEXCOLOR_EXP + ")" + W_EXP ) );
			hexcolor.name = "hexcolor";			
							
			//CHAR	any other character not matched by the above rules,
			//and neither a single nor a double quote
			var char:Token = new Token(
				CHAR, new RegExp( "^(" + CHAR_EXP + ")" ) );
			char.name = "char";
				
			//**************************** GRAMMAR TOKENS ****************************//
			
			//CHARSET			@charset
			const CHARSET_EXP:String = 
				"(?P<charset>"
				+ AtRule.CHARSET_SYM
				+ W_EXP
				+ "(?P<string>" + STRING_EXP + ")"
				+ W_EXP
				+ "(?:;)"
				+ ")";
			var charset:Token = new Token(
				CHARSET,
				new RegExp( "^" + CHARSET_EXP ) );
			charset.maximum = 1;
			charset.name = "charset";
			
			const MEDIUM_EXP:String = "all|print|screen";
			
			//IMPORT			@import
			const IMPORT_EXP:String = 
				"(?P<import>"
					+ AtRule.IMPORT_SYM
					+ W_EXP
					+ "(?:(?P<importuri>" + URI_EXP + ")"
					+ "|(?P<importstring>" + STRING_EXP + "))"
					+ W_EXP
					+ "(?:;)"
				+ ")"
				
			var css:Token = new Token(
				IMPORT,
				new RegExp( "^" + IMPORT_EXP ) );
			css.name = "import";
			
			//NAMESPACE-PREFIX	[ IDENT ] '|'
			const NAMESPACE_PREFIX_EXP:String = IDENT_EXP;
			
			var te:RegExp = /^(?P<char>[a-z]{1})$/;
			var me:Array = te.exec( "ab" );
			
			//
			for( var z:String in me )
			{
				trace("CssScanner::call()", z, me );
			}
			
			trace("CssScanner::call()", "a", te.test( "a" ), te.test( "ab" ) );
			
			var nsprefix:Token = new Token(
				NAMESPACE_PREFIX,
				new RegExp( "^(?P<nsprefix>" + IDENT_EXP + ")" + "(?P<nsdelimiter>\\|)" ) );
			nsprefix.name = "prefix";
				
			//NAMESPACE			@namespace
			const NAMESPACE_EXP:String = 
				"(?P<namespace>"
					+ AtRule.NAMESPACE_SYM
					+ W_EXP
					+ "(?P<namespaceprefix>" + IDENT_EXP + ")?"
					+ W_EXP
					+ "(?:(?P<namespaceuri>" + URI_EXP + ")"
					+ "|(?P<namespacestring>" + STRING_EXP + "))"
					+ W_EXP
					+ "(?:;)"
				+ ")";
			var ns:Token = new Token(
				NAMESPACE,
				new RegExp( "^" + NAMESPACE_EXP + W_EXP ) );
			ns.name = "namespace";
						
			//trace("CssScanner::call()", ns.match, ns.match.test( "@namespace fluid url( 'http://example.com' );" ) );
				
			//PAGE				@page
			var page:Token = new Token(
				PAGE,
				new RegExp( "^(" + AtRule.PAGE_SYM + ")" ) );
			page.name = "page";
				
			//MEDIA				@media
			var media:Token = new Token(
				MEDIA,
				new RegExp( "^(" + AtRule.MEDIA_SYM + ")" ) );
			media.name = "media";
				
			//FONT-FACE			@font-face
			var fontface:Token = new Token(
				FONT_FACE,
				new RegExp( "^(" + AtRule.FONT_FACE_SYM + ")" ) );
			fontface.name = "fontface";
				
			//PRIO				!important
			const PRIO_EXP:String = "(?P<prio>\\!(?:" + W_EXP + ")?important)";
			var prio:Token = new Token(
				PRIO,
				new RegExp( "^" + PRIO_EXP + W_EXP ) );
			prio.name = "prio";
				
			//OPERATOR			'/' | ','
  			const OPERATOR_EXP:String = "(?P<operator>" + Selector.OPTIONAL + "|" + Selector.DELIMITER + ")";
			var operator:Token = new Token(
				OPERATOR, new RegExp( "^" + OPERATOR_EXP + W_EXP ) );
			operator.name = "operator";
				
			//UNARY-OPERATOR	'-' | '+'
			const UNARY_OPERATOR_EXP:String = "(?P<unary>\\+|-)";
			var unary:Token = new Token(
				UNARY_OPERATOR, new RegExp( "^" + UNARY_OPERATOR_EXP + W_EXP + NUM_EXP ) );
			unary.name = "unary";
				
			//CLASS				'.' IDENT
			const CLASS_EXP:String = "(?P<class>(\\.)(" + IDENT_EXP + "))";
			var clazz:Token = new Token(
				CLASS, new RegExp( "^" + CLASS_EXP ) );
			clazz.name = "class";		
				
			//ELEMENT-NAME		IDENT | '*'
			const ELEMENT_NAME_EXP:String = "(?P<elementname>(?:\\" + Selector.UNIVERSAL + "|" + IDENT_EXP + "))";
			var element:Token = new Token(
				ELEMENT_NAME, new RegExp( "^" + ELEMENT_NAME_EXP ) );
			element.name = "elementname";
				
			//PROPERTY			IDENT S*
			var property:Token = new Token(
				PROPERTY, new RegExp( "^(" + IDENT_EXP + ")" + W_EXP + ":" + W_EXP ) );
			property.name = "property";
			
			//ATTRIB					'|=' | '^=' | '$=' | '*=' | '='
			const ATTRIB_OPERATOR_EXP:String =
				"(?P<attriboperator>"
				+ INCLUDES_EXP
				+ "|" + DASHMATCH_EXP
				+ "|" + PREFIXMATCH_EXP
				+ "|" + SUFFIXMATCH_EXP
				+ "|" + SUBSTRINGMATCH_EXP								
				+ "|" + EQUALITY_EXP			
				+ ")";			
			
			//ATTRIB-PARAMETER 			[ [ STRING | IDENT ] S* ]? ']'
			const ATTRIB_PARAMETER_EXP:String = "(?:"	+ STRING_EXP + "|(?P<ident>" + IDENT_EXP + "))";
			
			//ATTRIB
			//[href] | [attr='text'] | [attr="text"] | [attr~=match] | [attr|=match] | [attr^=match] | [attr$=match] | [attr*=match]
			//'[' S* IDENT S* [ '=' | INCLUDES | DASHMATCH | PREFIXMATCH | SUFFIXMATCH | SUBSTRINGMATCH ] S*			
			const ATTRIB_EXP:String =
				"(?P<attrib>\\["
				+ W_EXP
				+ IDENT_EXP					
				+ "(?:"
					+ W_EXP
					+ ATTRIB_OPERATOR_EXP
					+ W_EXP
					+ ATTRIB_PARAMETER_EXP
				+ ")?"
				+ W_EXP
				+ "\\])";
			
			var attrib:Token = new Token(
				ATTRIB, new RegExp( "^" + ATTRIB_EXP ) );
			attrib.name = "attrib";
			
			var attriboperator:Token = new Token(
				ATTRIB, new RegExp( "^" + ATTRIB_OPERATOR_EXP ) );
			attriboperator.name = "attriboperator";
			
			//PSEUDO				':' [ FUNCTION S* IDENT S* ')' | IDENT ]
			const PSEUDO_EXP:String =
				"(?P<pseudo>(:)"
				+ IDENT_EXP
				+ "|("
				+ FUNCTION_EXP
				+ W_EXP
				+ IDENT_EXP				
				+ W_EXP
				+ "\\)"				//close function call				
				+ "))";
			var pseudo:Token = new Token(
				PSEUDO, new RegExp( "^" + PSEUDO_EXP ) );
			pseudo.name = "pseudo";
			
			//TODO
			const TERM_EXP:String = "(?P<term>(?:" + UNARY_OPERATOR_EXP + ")?"
				+ "(?:"
					+ URI_EXP
					+ "|" + STRING_EXP
					+ "|" + IDENT_EXP
					+ "|" + UNICODE_RANGE_EXP
					+ "|" + HEXCOLOR_EXP
				+ ")"
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
					"^(?P<declaration>"
					+ IDENT_EXP + W_EXP
					+ ":"
					+ W_EXP + TERM_EXP
					+ ")" ) );
			declaration.name = "declaration";

			//COMBINATOR		'+' | '>' | '~' | ' '
			const COMBINATOR_EXP:String =
				"(?P<combinator>["
					+ Selector.ADJACENT_SIBLING
					+ Selector.CHILD
					+ Selector.GENERAL_SIBLING
					+ Selector.DESCENDANT
				+ "])";
			var combinator:Token = new Token(
				COMBINATOR, new RegExp( "^" + COMBINATOR_EXP ) );
			combinator.name = "combinator";
			
			//SIMPLE-SELECTOR	element_name? [HASH|class|attrib|pseudo]* S*
			const SIMPLE_SELECTOR_EXP:String =
				"" + ELEMENT_NAME_EXP + "?"
				+ "(?:"
				+ PSEUDO_EXP
				+ "|" + CLASS_EXP				
				+ "|" + HASH_EXP
				+ "|" + ATTRIB_EXP	
				+ ")";
				
			var simpleSelector:Token = new Token(
				SIMPLE_SELECTOR, new RegExp(
					"^(?P<simpleselector>" + SIMPLE_SELECTOR_EXP + ")" ) );
			simpleSelector.name = "simpleselector";	
			
			//SELECTOR		element_name? [HASH|class|attrib|pseudo]* S*
			const SELECTOR_EXP:String = 
				"(?P<selector>" + SIMPLE_SELECTOR_EXP
				+ W_EXP
				+ "(?:"
				+ W_EXP
				+ COMBINATOR_EXP
				+ W_EXP
				+ SIMPLE_SELECTOR_EXP
				+ "))";

			var selector:Token = new Token(
				SELECTOR, new RegExp(
					"^" + SELECTOR_EXP, "i" ) );
			selector.name = "selector";
			
			//RULESET		selector [ ',' S* selector ]*
			const RULESET_EXP:String =
				"(?P<ruleset>" + SELECTOR_EXP
				+ "((?:,)"
				+ W_EXP
				+ SELECTOR_EXP
				+ ")*)";
			
			var ruleset:Token = new Token(
				RULESET, new RegExp(
					"^("
					+ RULESET_EXP
					+ ")", "i" ) );
			ruleset.name = "ruleset";					
				
			//**************************** NUMBER/UNIT TOKENS ****************************//			
			
			//EMS				em
			var ems:Token = new Token(
				EMS, new RegExp( "^(" + NUM_EXP + StyleUnit.EMS_EXP + ")", "i" ) );
			ems.name = "ems";			
				
			//EXS				ex
			var exs:Token = new Token(
				EXS, new RegExp( "^(" + NUM_EXP + StyleUnit.EXS_EXP + ")", "i" ) );	
			exs.name = "exs";			
				
			//LENGTH			px|cm|mm|in|pt|pc
			var length:Token = new Token(
				LENGTH,
				new RegExp( "^(" + NUM_EXP + StyleUnit.LENGTH_EXP + ")", "i" ) );
			length.name = "length";				
				
			//ANGLE				deg|rad|grad
			var angle:Token = new Token(
				ANGLE,
				new RegExp( "^(" + NUM_EXP + StyleUnit.ANGLE_EXP + ")", "i" ) );
			angle.name = "angle";				
				
			//TIME				ms|s
			var time:Token = new Token(
				TIME,
				new RegExp( "^(" + NUM_EXP + StyleUnit.TIME_EXP + ")", "i" ) );
			time.name = "time";				
				
			//FREQUENCY			kHz|Hz
			var frequency:Token = new Token(
				FREQ,
				new RegExp( "^(" + NUM_EXP + StyleUnit.FREQUENCY_EXP + ")", "i" ) );
			frequency.name = "frequency";				
				
			//PERCENTAGE		{num}%
			var percent:Token = new Token(
				PERCENTAGE,
				new RegExp( "^(" + PERCENT_EXP + ")", "i" ) );
			percent.name = "percent";				
			
			//DIMENSION			{num}{ident}
			var dimension:Token = new Token(
				DIMENSION,
				new RegExp( "^(" + DIMENSION_EXP + ")", "i" ) );
			dimension.name = "dimension";				
			
			//NUMBER			{num}
			var num:Token = new Token(
				NUMBER,
				new RegExp( "^(?:" + NUM_EXP + ")" ) );	
			num.name = "number";
			
			//**************************** TOKEN DEFINITIONS ****************************//
			
			//byte order mark first
			add( bom );
			
			//code style multiline comment - must be before the operators
			add( comment );
			
			//match a uri function expression early
			add( uri );			
			
			//hexcolor before other hash variants
			add( hexcolor );
			
			//xml style comments
			add( blockcomment );
			add( cdo );
			add( cdc );
			
			//unicode range  - must match before {ident}
			add( range );
			
			//ruleset
			//add( ruleset );
			
			//selectors
			add( selector );
			add( simpleSelector );
			
			//whitespace token - match after the descendant combinator ' '
			add( s );			
			
			//property/expr declaration
			add( declaration );
			
			//namespace
			add( ns );					//	@namespace			
			//namespace prefix
			add( nsprefix );			//	nsprefix|tag
			
			//property is a priority match
			add( property );
			
			//operators need to take precedence
			add( operator );			//	'/' | ','
			add( unary );				//	'-' | '+'			
			
			//attribute match
			add( attrib );
			add( attriboperator );
			
			add( string );			
			
			//combinator after selectors
			add( combinator );			//	'+' | '>'
			
			//specific at rules before the generic at rule - before the element name match
			add( charset );				//	@charset
			add( css );					//	@import
			add( page );				//	@page
			add( media );				//	@media
			add( fontface );			//	@font-face
			add( at );					//	@unknown-rule					
			
			//pseudo class selector
			add( pseudo );				//	:link
			
			//ident based
			add( clazz );				//	.class
			
			//element name						//	h1 etc.
			add( element );
			
			//match {baduri} before {ident}
			add( badUri );		
			
			add( prio );				//	!important
			
			add( hash );
			
			//numeric/unit values should be matched in this order
			add( angle );
			add( frequency );
			add( length );
			add( time );
			add( ems );
			add( exs );
			add( dimension );
			add( percent );
			add( num );	
			
			//function expression: method()
			add( method );
			
			//includes operator ~=
			add( includes );
			
			//dashmatch operator |=
			add( dashmatch );
			
			//prefixmatch operator ^=
			add( prefixmatch );
			
			//suffixmatch operator $=
			add( suffixmatch );
			
			//substringmatch operator *=
			add( substringmatch );								

			//generic name token before ident
			add( name );

			add( ident );
			
			//match bad comments after good ones
			add( badComment ); 
			
			add( badString );
			
			//final catch all char
			add( char );	
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
			trace("[CSS END]", token );
		}
	}
}