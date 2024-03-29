package com.ffsys.w3c.dom.css.support
{
	import javax.script.scanner.*;
	
	/**
	*	A grammar definition for <code>CSS3</code> text.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.01.2011
	*/
	public class CSS3Grammar extends Grammar
	{	
		
		//
		
		/**
		* 	The delimiter between multiple selectors.
		*/
		public static const DELIMITER:String = ",";
		
		/**
		* 	The delimiter between multiple options.
		*/
		public static const OPTIONAL:String = "/";
		
		/**
		* 	The wildcard selector used to select all elements.
		*/
		public static const UNIVERSAL:String = "*";
		
		/**
		* 	The character that defines an identifier selector.
		*/
		public static const IDENTIFIER:String = "#";
		
		/**
		* 	The character that defines a class level selector.
		*/
		//public static const CLASS:String = ".";
		
		/**
		* 	The character that defines a child selector.
		*/
		public static const CHILD:String = ">";
		
		/**
		* 	The character that defines an adjacent sibling selector.
		*/
		public static const ADJACENT_SIBLING:String = "+";
		
		/**
		* 	The character that defines an adjacent sibling selector.
		*/
		public static const GENERAL_SIBLING:String = "~";
		
		/**
		* 	The character that defines a descendant selector.
		*/
		public static const DESCENDANT:String = " ";		
		
		//
		
		
		//
		
		/**
		* 	The symbol for an <code>import</code> at rule.
		*/
		public static const IMPORT_SYM:String = "@import";
		
		/**
		* 	The symbol for a <code>page</code> at rule.
		*/
		public static const PAGE_SYM:String = "@page";
		
		/**
		* 	The symbol for a <code>media</code> at rule.
		*/
		public static const MEDIA_SYM:String = "@media";
		
		/**
		* 	The symbol for a <code>font-face</code> at rule.
		*/
		public static const FONT_FACE_SYM:String = "@font-face";
		
		/**
		* 	The symbol for a <code>charset</code> at rule.
		*/
		public static const CHARSET_SYM:String = "@charset";
		
		/**
		* 	The symbol for a <code>namespace</code> at rule.
		*/
		public static const NAMESPACE_SYM:String = "@namespace";
		
		//
		
		//
		
		/**
		* 	An expression used to determine the <code>em</code> unit type.
		*/
		public static const EMS_EXP:String = "(?P<emsunit>em)";

		/**
		* 	An expression used to determine the <code>ex</code> unit type.
		*/
		public static const EXS_EXP:String = "(?P<exsunit>ex)";

		/**
		* 	An expression used to determine the <code>length</code> unit type.
		*/
		public static const LENGTH_EXP:String = "(?P<lengthunit>px|cm|mm|in|pt|pc)";

		/**
		* 	An expression used to determine the <code>angle</code> unit type.
		*/
		public static const ANGLE_EXP:String = "(?P<angleunit>grad|deg|rad)";

		/**
		* 	An expression used to determine the <code>time</code> unit type.
		*/
		public static const TIME_EXP:String = "(?P<timeunit>ms|s)";

		/**
		* 	An expression used to determine the <code>frequency</code> unit type.
		*/
		public static const FREQUENCY_EXP:String = "(?P<frequencyunit>kHz|Hz)";

		/**
		* 	An expression used to determine the <code>percentage</code> unit type.
		*/
		public static const PERCENTAGE_EXP:String = "(?P<percentunit>%)";
		
		//
			
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
		
		//NON SPECIFICATION DEFINED CUSTOM TOKENS
		//FOR MORE GRANULAR CONTROL OF CHILD TOKEN MATCHING
		
		/**
		* 	The identifier for a statement end token, ';'.
		*/
		public static const STATEMENT_END:int = 300;
		
		/**
		* 	The identifier for an attribute operator token.
		*/
		public static const ATTRIB_OPERATOR:int = 301;
		
		/**
		* 	The identifier for an attribute name ident token.
		*/
		public static const ATTRIB_NAME_IDENT:int = 302;
		
		/**
		* 	The identifier for a namespace delimiter token.
		*/
		public static const NAMESPACE_DELIMITER:int = 303;
		
		/**
		* 	The identifier for a left brace token.
		*/
		public static const LBRACE:int = 304;
		
		/**
		* 	The identifier for a right brace token.
		*/
		public static const RBRACE:int = 305;
		
		/**
		* 	The identifier for a left parentheses token.
		*/
		public static const LPAREN:int = 306;
		
		/**
		* 	The identifier for a right parentheses token.
		*/
		public static const RPAREN:int = 307;
		
		/**
		* 	The identifier for a ruleset token.
		*/
		public static const BLOCK:int = 308;
		
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
		* 	@private
		* 
		* 	Creates a <code>CSS3Grammar</code> instance.
		*/
		public function CSS3Grammar()
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
		
		override protected function doWithGrammar( grammar:Grammar ):Grammar
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
				"[_a-zA-Z0-9|\\-]" ;//+ "|" + NONASCII_EXP;//+ "|" + NONASCII_EXP + "|" + ESCAPE_EXP;
				
			//name					{nmchar}+
			const NAME_EXP:String =
				"(?:" + NMCHAR_EXP + ")+";

			//IDENT					{ident}
			//ident					[-]?{nmstart}{nmchar}*	
			const IDENT_EXP:String =
				"-?" + NMSTART_EXP + "{1}" + NMCHAR_EXP + "*"
					//characters that should end an ident
					+ "(?:[^ \\{>+~:;.])";
			
			//ELEMENT-NAME		IDENT | '*'
			const ELEMENT_NAME_EXP:String = "[" + UNIVERSAL + "]|" + IDENT_EXP;
			var element:Token = new Token(
				ELEMENT_NAME, new RegExp( "^(?P<elementname>" + ELEMENT_NAME_EXP + ")" ) );
			element.name = "elementname";					
			
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
				"(?:(?:" + STRING1_EXP + ")|(?:" + STRING2_EXP + "))";
			
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
				"((U|u\\+)([0-9a-fA-F?]{1,6})(-)(" + H_EXP + "{1,6})?)";
			
			//DIMENSION			{num}{ident}
			const DIMENSION_EXP:String = NUM_EXP + IDENT_EXP;
			
			//PERCENTAGE		{num}%
			const PERCENT_EXP:String = NUM_EXP + PERCENTAGE_EXP;
			
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
			const HASH_EXP:String = "(#)(" + NAME_EXP + ")";
			var hash:Token = new Token(
				HASH, new RegExp( "^(?P<hash>" + HASH_EXP + ")" ) );
			hash.name = "hash";			
			
			//UNICODE-RANGE							u\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?
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
			
			//BLOCK-COMMENT							'<!--' {commentdata} '-->'
			const BLOCK_COMMENT_EXP:String =
				"(?P<blockcomment>"
					+ CDO_EXP + "(?P<commentdata>.*)" + CDC_EXP
				+ ")";
			var blockcomment:Token = new Token(
				BLOCK_COMMENT, new RegExp( "^" + BLOCK_COMMENT_EXP ) );
			blockcomment.name = "blockcomment";

			//S										[ \t\r\n\f]+
			var s:Token = new Token(
				S, new RegExp( "^(" + S_EXP + ")" ) );
			s.capture = whitespace;
			s.name = "whitespace";				
			
			//INCLUDES								~=
			var includes:Token = new Token(
				INCLUDES,
				new RegExp( "^(" + INCLUDES_EXP + ")" ) );
			includes.name = "includes";
			
			//DASHMATCH								|=
			var dashmatch:Token = new Token(
				DASHMATCH,
				new RegExp( "^(" + DASHMATCH_EXP + ")" ) );
			dashmatch.name = "dashmatch";
				
			//PREFIXMATCH							^=
			var prefixmatch:Token = new Token(
				PREFIXMATCH,
				new RegExp( "^(" + PREFIXMATCH_EXP + ")" ) );
			prefixmatch.name = "prefixmatch";				
				
			//SUFFIXMATCH							$=
			var suffixmatch:Token = new Token(
				SUFFIXMATCH,
				new RegExp( "^(" + SUFFIXMATCH_EXP + ")" ) );
			suffixmatch.name = "suffixmatch";				
				
			//SUBSTRINGMATCH						$=
			var substringmatch:Token = new Token(
				SUBSTRINGMATCH,
				new RegExp( "^(" + SUBSTRINGMATCH_EXP + ")" ) );
			substringmatch.name = "substringmatch";								
			
			//COMMENT								\/\*[^*]*\*+([^/*][^*]*\*+)*\/
			var comment:Token = new Token(
				COMMENT, new RegExp( "^" + COMMENT_EXP ) );
			comment.capture = comments;
			comment.name = "comment";
			
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
				+ CHARSET_SYM
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
			
			//charset.merges = false;
			
			const MEDIUM_EXP:String = "all|print|screen";
			
			//IMPORT			@import
			const IMPORT_EXP:String = 
				"(?P<import>"
					+ IMPORT_SYM
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
			
			//NAMED GROUP TEST
			//var te:RegExp = /^(?P<char>[a-z]{1,})$/;				//named groups matches concatenated (abcdef)
			var te:RegExp = /^(?P<char>([a-z]){1})*$/;				//named group == last matched character (f)
			var me:Array = te.exec( "abcdef" );
			
			//
			/*
			for( var z:String in me )
			{
				trace("CSS3Grammar::call()", z, me[ z ] );
			}
			*/
			
			//trace("CSS3Grammar::call()", "a", te.test( "a" ), te.test( "ab" ) );
			//END NAMED GROUP TEST
			
			var nsprefix:Token = new Token(
				NAMESPACE_PREFIX,
				new RegExp( "^(?P<nsprefix>" + IDENT_EXP + ")" + "(?P<nsdelimiter>\\|)" ) );
			nsprefix.name = "prefix";
				
			//NAMESPACE			@namespace
			const NAMESPACE_EXP:String = 
				"(?P<namespace>"
					+ NAMESPACE_SYM
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
						
			//trace("CSS3Grammar::call()", ns.match, ns.match.test( "@namespace fluid url( 'http://example.com' );" ) );
				
			//PAGE				@page
			var page:Token = new Token(
				PAGE,
				new RegExp( "^(" + PAGE_SYM + ")" ) );
			page.name = "page";
				
			//MEDIA				@media
			var media:Token = new Token(
				MEDIA,
				new RegExp( "^(" + MEDIA_SYM + ")" ) );
			media.name = "media";			
				
			//FONT-FACE			@font-face
			var fontface:Token = new Token(
				FONT_FACE,
				new RegExp( "^(" + FONT_FACE_SYM + ")" ) );
			fontface.name = "fontface";
				
			//PRIO				!important
			const PRIO_EXP:String = "(?P<prio>\\!(?:" + W_EXP + ")?important)";
			var prio:Token = new Token(
				PRIO,
				new RegExp( "^" + PRIO_EXP + W_EXP ) );
			prio.name = "prio";
				
			//OPERATOR			'/' | ','
  			const OPERATOR_EXP:String = OPTIONAL + "|" + DELIMITER;
			var operator:Token = new Token(
				OPERATOR, new RegExp( "^(?P<operator>" + OPERATOR_EXP + ")" + W_EXP ) );
			operator.name = "operator";
				
			//UNARY-OPERATOR	'-' | '+'
			const UNARY_OPERATOR_EXP:String = "(?P<unary>\\+|-)";
			var unary:Token = new Token(
				UNARY_OPERATOR, new RegExp( "^" + UNARY_OPERATOR_EXP + W_EXP + NUM_EXP ) );
			unary.name = "unary";
				
			//CLASS				'.' IDENT
			const CLASS_EXP:String = "(\\.)(" + IDENT_EXP + ")";
			var clazz:Token = new Token(
				CLASS, new RegExp( "^(?P<class>" + CLASS_EXP + ")" ) );
			clazz.name = "class";
			
			//LBRACE										'{'
			const LBRACE_EXP:String = "\\{";
			var lbrace:Token = new Token(
				LBRACE,
				new RegExp( "^(?P<lbrace>" + LBRACE_EXP + ")" ) );
			lbrace.name = "lbrace";
			lbrace.capture = false;
			
			//RBRACE										'}'
			const RBRACE_EXP:String = "\\}";			
			var rbrace:Token = new Token(
				RBRACE,
				new RegExp( "^(?P<rbrace>" + RBRACE_EXP + ")" ) );
			rbrace.name = "rbrace";
			rbrace.capture = false;			
			
			//LPAREN										'('
			var lparen:Token = new Token(
				LPAREN,
				new RegExp( "^(?P<lparen>" + "\\(" + ")" ) );
			lparen.name = "lparen";
			lparen.capture = false;
			
			//RPAREN										')'
			var rparen:Token = new Token(
				RPAREN,
				new RegExp( "^(?P<rparen>" + "\\)" + ")" ) );
			rparen.name = "rparen";
			rparen.capture = false;

			//**************************** NUMBER/UNIT TOKENS ****************************//			

			//EMS				em
			var ems:Token = new Token(
				EMS, new RegExp( "^(" + NUM_EXP + EMS_EXP + ")", "i" ) );
			ems.name = "ems";			

			//EXS				ex
			var exs:Token = new Token(
				EXS, new RegExp( "^(" + NUM_EXP + EXS_EXP + ")", "i" ) );	
			exs.name = "exs";			

			//LENGTH			px|cm|mm|in|pt|pc
			var length:Token = new Token(
				LENGTH,
				new RegExp( "^(" + NUM_EXP + LENGTH_EXP + ")", "i" ) );
			length.name = "length";				

			//ANGLE				deg|rad|grad
			var angle:Token = new Token(
				ANGLE,
				new RegExp( "^(" + NUM_EXP + ANGLE_EXP + ")", "i" ) );
			angle.name = "angle";				

			//TIME				ms|s
			var time:Token = new Token(
				TIME,
				new RegExp( "^(" + NUM_EXP + TIME_EXP + ")", "i" ) );
			time.name = "time";				

			//FREQUENCY			kHz|Hz
			var frequency:Token = new Token(
				FREQ,
				new RegExp( "^(" + NUM_EXP + FREQUENCY_EXP + ")", "i" ) );
			frequency.name = "frequency";				

			//PERCENTAGE		{num}%
			var percent:Token = new Token(
				PERCENTAGE,
				new RegExp( "^(" + PERCENT_EXP + ")", "i" ) );
			percent.name = "percent";				

			//DIMENSION										{num}{ident}
			var dimension:Token = new Token(
				DIMENSION,
				new RegExp( "^(" + DIMENSION_EXP + ")", "i" ) );
			dimension.name = "dimension";				

			//NUMBER										{num}
			var num:Token = new Token(
				NUMBER,
				new RegExp( "^(?:" + NUM_EXP + ")" ) );	
			num.name = "number";

			//STATEMENT-END									';'
			var statementend:Token = new Token(
				STATEMENT_END,
				new RegExp( "^(?P<statementend>" + ";" + ")" ) );
			statementend.name = "statementend";

			//NAMESPACE-DELIMITER							'|'
			var nsdelimiter:Token = new Token(
				NAMESPACE_DELIMITER,
				new RegExp( "^(?P<nsdelimiter>" + "|" + ")" ) );
			nsdelimiter.name = "nsdelimiter";			
				
			//PROPERTY			IDENT S*
			var property:Token = new Token(
				PROPERTY, new RegExp( "^("
					+ IDENT_EXP + ")" + W_EXP + ":" + W_EXP ) );
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
			const ATTRIB_PARAMETER_EXP:String =
				"(?:(?P<string>" + STRING_EXP + ")|(?P<ident>" + IDENT_EXP + "))";
			
			//ATTRIB
			//[href] | [attr='text'] | [attr="text"] | [attr~=match] | [attr|=match] | [attr^=match] | [attr$=match] | [attr*=match]
			//'[' S* IDENT S* [ '=' | INCLUDES | DASHMATCH | PREFIXMATCH | SUFFIXMATCH | SUBSTRINGMATCH ] S*			
			const ATTRIB_EXP:String =
				"\\["
				+ W_EXP
				+ IDENT_EXP
				+ "(?:"
					+ W_EXP
					+ ATTRIB_OPERATOR_EXP
					+ W_EXP
					+ ATTRIB_PARAMETER_EXP
				+ ")?"
				+ W_EXP
				+ "\\]";
			
			var attrib:Token = new Token(
				ATTRIB, new RegExp( "^(?P<attrib>" + ATTRIB_EXP + ")" ) );
			attrib.name = "attrib";
			
			var attriboperator:Token = new Token(
				ATTRIB_OPERATOR,
				new RegExp( "^" + ATTRIB_OPERATOR_EXP ) );
			attriboperator.name = "attriboperator";
			
			var attribnameident:Token = new Token(
				ATTRIB_NAME_IDENT,
				new RegExp( "^(?P<attribnameident>" + IDENT_EXP + ")" ) );
			attribnameident.name = "attribnameident";
			
			//PSEUDO				':' [ FUNCTION S* IDENT S* ')' | IDENT ]
			const PSEUDO_EXP:String =
				"(:)"
				+ IDENT_EXP
				+ "|("
				+ FUNCTION_EXP + W_EXP + IDENT_EXP + W_EXP + "\\)"				//function call with ident
				+ ")";
			var pseudo:Token = new Token(
				PSEUDO, new RegExp( "^(?P<pseudo>" + PSEUDO_EXP + ")" ) );
			pseudo.name = "pseudo";
			
			//TERM
			//		: unary_operator?
			//		[
			//			NUMBER S* | PERCENTAGE S* | LENGTH S* | EMS S* | EXS S* | ANGLE S*
			//			| TIME S* | FREQUENCY S* | function
			//		]
			//		| STRING S* | IDENT S* | URI S* | UNICODERANGE S* | hexcolor
			const TERM_EXP:String =
				"(?:"
					//+ "(?:"
						+ "(?:" + UNARY_OPERATOR_EXP + ")?"
						+ "(?:"
							+ ANGLE_EXP
							+ "|" + FREQUENCY_EXP
							+ "|" + LENGTH_EXP
							+ "|" + TIME_EXP
							+ "|" + EMS_EXP
							+ "|" + EXS_EXP
							+ "|" + PERCENT_EXP
							+ "|" + DIMENSION_EXP
							+ "|" + NUM_EXP
							//+ "|" + FUNCTION_CALL_EXP
							+ W_EXP
						+ ")|"
						+ "(?:"
							+ URI_EXP
							+ "|" + STRING_EXP
							+ "|" + IDENT_EXP
							+ "|" + UNICODE_RANGE_EXP
							+ "|" + HEXCOLOR_EXP
							+ W_EXP						
						+ ")"
					//+ ")"
				+ ")";
				
			var term:Token = new Token(
				TERM, new RegExp(
					"^(?P<term>"
						+ TERM_EXP
					+ ")" ) );
			term.name = "term";
			
			//EXPR								term [operator term]*
			var expr:Token = new Token(
				EXPR, term.match );
			expr.name = "expr";
			expr.delimiter = new RegExp(
				W_EXP + "(?P<exprdelim>" + OPERATOR_EXP + "){1}" + W_EXP );
			expr.repeater = expr.match;
			
			//FUNCTION			{ident}\(
			const FUNCTION_EXP:String = IDENT_EXP + "\\(";			
			var method:Token = new Token(
				FUNCTION, new RegExp( "^(?P<method>" + FUNCTION_EXP + ")" ) );
			method.name = "method";
			
			//{function}								FUNCTION S* expr ')' S*
			const FUNCTION_CALL_EXP:String = FUNCTION_EXP + TERM_EXP + "\\)";
			var func:Token = new Token(
				FUNCTION, new RegExp( "^(?P<function>" + FUNCTION_CALL_EXP + ")" ) );
			func.name = "function";			
			
			//{declaration}								property ':' S* expr prio?
			const DECLARATION_EXP:String = 
				"(?P<property>" + IDENT_EXP + "){1}"
				+ "(?P<propdelim>:){1}"
				+ W_EXP
				+ TERM_EXP
				+ PRIO_EXP + "?";
			var declaration:Token = new Token(
				DECLARATION, new RegExp(
					"^(?P<declaration>" + DECLARATION_EXP + ")" ) );
			declaration.name = "declaration";
			declaration.delimiter = new RegExp(
				W_EXP + "(?P<decldelim>;){1}" + W_EXP );
			declaration.repeater = declaration.match;
			
			//	+ "(?:[^\\{;]\\r\\n\\f)"

			//COMBINATOR							'+' | '>' | '~' | ' '
			const COMBINATOR_EXP:String =
				"(?:\\"
					+ ADJACENT_SIBLING
					+ "|" + CHILD
					+ "|" + GENERAL_SIBLING
					+ "|" + DESCENDANT
					//+ "|" + "(?:" + NMCHAR_EXP + ")" + DESCENDANT + "(?:" + NMSTART_EXP + ")"
				+ ")";
			var combinator:Token = new Token(
				COMBINATOR, new RegExp( "^(?P<combinator>" + COMBINATOR_EXP + ")" ) );
			combinator.name = "combinator";
			
			//block definition
			var block:BlockToken = new BlockToken( BLOCK );
			block.start = new RegExp(
				"^"
				+ "(?P<blockstart>"
				+ W_EXP
				+ LBRACE_EXP
				+ W_EXP				
				+ ")" );
			block.end = new RegExp(
				"^"
				+ "(?P<blockend>"
				+ W_EXP
				+ "(?:" + LBRACE_EXP + ")?"
				+ RBRACE_EXP
				+ W_EXP
				+ ")" );
			
			//SIMPLE-SELECTOR						element_name? [ HASH | class | attrib | pseudo ]* S*
			const SIMPLE_SELECTOR_EXP:String =
				"(?P<elementname>" + ELEMENT_NAME_EXP + ")?"
				+ "(?:"
				//this match order is important for correctly building selectors
				+ "(?P<hash>" + HASH_EXP + ")"
				+ "|(?P<class>" + CLASS_EXP + ")"				
				+ "|(?P<attrib>" + ATTRIB_EXP + ")"
				+ "|(?P<pseudo>" + PSEUDO_EXP + ")"				
				+ ")*";
				//+ "(?:\\{)";
				
				
			var simpleSelector:Token = new Token(
				SIMPLE_SELECTOR, new RegExp(
					"^(?P<simpleselector>" + SIMPLE_SELECTOR_EXP + ")" + W_EXP ) );
			simpleSelector.name = "simpleselector";	
			
			trace("[SIMPLE-SELECTOR] CSS3Grammar::call()", "h1",
				simpleSelector.test( "h1" ) );
			trace("[SIMPLE-SELECTOR] CSS3Grammar::call()", "h1.red",
				simpleSelector.test( "h1.red" ) );
			trace("[SIMPLE-SELECTOR] CSS3Grammar::call()", ".red",
				simpleSelector.test( ".red" ) );
			trace("[SIMPLE-SELECTOR] CSS3Grammar::call()", "#my-id",
				simpleSelector.test( "#my-id" ) );
			
			//SELECTOR		simple_selector [combinator simple_selector]* S*
			var selector:Token = new Token(
				SELECTOR, new RegExp(
					"^(?P<simpleselector>" + SIMPLE_SELECTOR_EXP + ")" + W_EXP ) );
			selector.name = "selector";
			selector.merges = false;
			selector.delimiter = new RegExp(
				"(?P<combinator>" + COMBINATOR_EXP + "){1}" );
			selector.repeater = selector.match;			
			
			//RULESET		selector [ ',' S* selector ]*
			var ruleset:Token = new Token(
				RULESET, selector.match );
			ruleset.name = "ruleset";
			ruleset.merges = false;
			ruleset.delimiter = new RegExp(
				"(?P<rulesetdelimiter>," + W_EXP + ")" );
			ruleset.repeater = ruleset.match;
			
			ruleset.block = BlockToken( block.clone() );
			//blocks are required for ruleset declarations
			ruleset.block.required = true;
			
			ruleset.block.name = selector.name;
			
			ruleset.block.addToken( comment );					// 	/* multiline comment */
			ruleset.block.addToken( string );					// 	"string" or 'string'
			ruleset.block.addToken( declaration );				// 	font-size: 1.2em;
			ruleset.block.addToken( ident );
			ruleset.block.addToken( expr );						
			ruleset.block.addToken( term );

			ruleset.block.addToken( s );						// 	[ \t\n\r\f]
			
			ruleset.block.addToken( property );					//	font-size
			ruleset.block.addToken( prio );						//	!important
			
			//generic name token
			ruleset.block.addToken( name );
			
			//numeric/unit values should be matched in this order
			ruleset.block.addToken( angle );
			ruleset.block.addToken( frequency );
			ruleset.block.addToken( length );
			ruleset.block.addToken( time );
			ruleset.block.addToken( ems );
			ruleset.block.addToken( exs );
			ruleset.block.addToken( dimension );
			ruleset.block.addToken( percent );
			ruleset.block.addToken( num );
			
			//function expression: method()
			ruleset.block.addToken( func );						//	FUNCTION S* expr ')' S*
			
			//operators need to take precedence
			ruleset.block.addToken( operator );					//	'/' | ',' | /* empty */
			ruleset.block.addToken( unary );					//	'-' | '+'
			
			ruleset.block.addToken( statementend );				//	';'		
			ruleset.block.addToken( lbrace );					//	'{'
			ruleset.block.addToken( rbrace );					//	'}'
			ruleset.block.addToken( lparen );					//	'('
			ruleset.block.addToken( rparen );					//	')'
						
			ruleset.block.addToken( char );						//	[^'"]		
			
			trace("[TERM] CSS3Grammar::call()", "2.5em", term.test( "2.5em" ) );
			trace("[TERM] CSS3Grammar::call()", "url('http://example.com')",
				term.test( "url('http://example.com')" ) );
			trace("[TERM] CSS3Grammar::call()", "2.5em;", term.test( "2.5em;" ) );
			trace("[TERM] CSS3Grammar::call()", "10", term.test( "10" ) );
			trace("[TERM] CSS3Grammar::call()", "0 0 0 0", term.test( "0 0 0 0" ) );
			
			trace("[EXPR] CSS3Grammar::call()", "2.5em/", expr.test( "2.5em/" ) );
			trace("[EXPR] CSS3Grammar::call()", "2.5em", expr.test( "2.5em" ) );
			trace("[EXPR] CSS3Grammar::call()", "2.5em/1.2em", expr.test( "2.5em/1.2em" ) );
			trace("[EXPR] CSS3Grammar::call()", "0 0 0 0", expr.test( "0 0 0 0" ) );			
			
			trace("[DECLARATION] CSS3Grammar::call()", "'font-family:'",
				declaration.compare( "font-family:", declaration ), declaration.matched );
				
			trace("[DECLARATION] CSS3Grammar::call()", "'margin-bottom: 10;'",
				declaration.compare( "margin-bottom: 10;", declaration ), declaration.matched );
			
			trace("[DECLARATION] CSS3Grammar::call()", "'font-family: 'Arial Narrow', Arial, sans-serif;'",
				declaration.compare( "font-family: 'Arial Narrow', Arial, sans-serif;", declaration ), declaration.matched );
			
			trace("[DECLARATION] CSS3Grammar::call()", "'font-size: 2.5em; color: #ff6600'",
				declaration.compare( "font-size: 2.5em; color: #ff6600", declaration ), declaration.matched );			

			trace("[SELECTOR] CSS3Grammar::call()", "h1",
				selector.test( "h1" ) );
			trace("[SELECTOR] CSS3Grammar::call()", "h1.red",
				selector.test( "h1.red" ) );
			trace("[SELECTOR] CSS3Grammar::call()", ".red",
				selector.test( ".red" ) );
			trace("[SELECTOR] CSS3Grammar::call()", "#my-id",
				selector.test( "#my-id" ) );				
			
			trace("[RULESET] CSS3Grammar::call()", "h1",
				ruleset.test( "h1" ) );
			
			trace("[RULESET] CSS3Grammar::call()", "*",
				ruleset.test( "*" ) );
			
			//**************************** TOKEN DEFINITIONS ****************************//
			
			//ORDER IS EXTREMELY IMPORTANT
			
			//byte order mark first
			grammar.addToken( bom );
			
			//code style multiline comment - must be before the operators
			grammar.addToken( comment );
			
			//match a uri function expression early
			grammar.addToken( uri );			
			
			//hexcolor before other hash variants
			grammar.addToken( hexcolor );
			
			//xml style comments
			grammar.addToken( blockcomment );
			grammar.addToken( cdo );
			grammar.addToken( cdc );
			
			//unicode range  - must match before ident and unary
			grammar.addToken( range );
			
			//specific at rules before the generic at rule - before the element name match
			grammar.addToken( charset );				//	@charset
			grammar.addToken( css );					//	@import
			grammar.addToken( page );				//	@page
			grammar.addToken( media );				//	@media
			grammar.addToken( fontface );			//	@font-face
			
			//namespace
			grammar.addToken( ns );					//	@namespace
			
			grammar.addToken( at );					//	@unknown-rule			
			
			//whitespace token - match after the descendant combinator ' '
			grammar.addToken( s );
			
			//operators need to take precedence
			grammar.addToken( operator );			//	'/' | ','
			grammar.addToken( unary );				//	'-' | '+'			
			
			grammar.addToken( string );
			
			//match {baduri} before {ident}
			grammar.addToken( badUri );
			
			//includes operator ~=
			grammar.addToken( includes );
			
			//dashmatch operator |=
			grammar.addToken( dashmatch );
			
			//prefixmatch operator ^=
			grammar.addToken( prefixmatch );
			
			//suffixmatch operator $=
			grammar.addToken( suffixmatch );
			
			//substringmatch operator *=
			grammar.addToken( substringmatch );	
	
			grammar.addToken( statementend );			
			grammar.addToken( lbrace );
			grammar.addToken( rbrace );
			grammar.addToken( lparen );
			grammar.addToken( rparen );	
			
			//combinator before selectors
			grammar.addToken( combinator );			//	'+' | '>' | '~' | ' '
			
			//ruleset + selectors
			grammar.addToken( ruleset );
			grammar.addToken( selector );
			grammar.addToken( simpleSelector );
			
			//hash identifier							//	'#'{name}		#tagid
			//grammar.addToken( hash );
			//ident based
			//grammar.addToken( clazz );								//	'.'{ident}		.class
			//attribute match
			//grammar.addToken( attrib );							//					[href]
			//grammar.addToken( attriboperator );					//					[lang=en]
			//pseudo class selector
			//grammar.addToken( pseudo );							//	':'{ident}		:link	
			
			//element name								//	'*' | {ident}	*, h1, tagname
			grammar.addToken( element );
			
			//namespace prefix			//must be after elementname
			grammar.addToken( nsprefix );			//	nsprefix|tag

			//grammar.addToken( ident );	
			
			//match bad comments after good ones
			grammar.addToken( badComment ); 
			
			grammar.addToken( badString );
			
			//final catch all char
			grammar.addToken( char );
			
			return grammar;
		}
		
		/**
		* 	Retrieves a <code>CSS3Grammar</code> instance.
		* 
		* 	@return A <code>CSS3Grammar</code> instance.
		*/
		public static function newInstance():CSS3Grammar
		{
			if( __grammar == null )
			{
				__grammar = new CSS3Grammar();
			}
			return __grammar;
		}
		
		private static var __grammar:CSS3Grammar;
	}
}