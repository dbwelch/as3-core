package javax.xml
{
	import javax.script.scanner.*;
	
	/**
	*	A grammar definition for <code>XML</code> text.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.02.2011
	*/
	public class XMLGrammar extends Grammar
	{
		
		/*

		6 Notation

		The formal grammar of XML is given in this specification using a simple Extended Backus-Naur Form (EBNF) notation. Each rule in the grammar defines one symbol, in the form

		symbol ::= expression
		Symbols are written with an initial capital letter if they are the start symbol of a regular language, otherwise with an initial lowercase letter. Literal strings are quoted.

		Within the expression on the right-hand side of a rule, the following expressions are used to match strings of one or more characters:

		#xN
		where N is a hexadecimal integer, the expression matches the character whose number (code point) in ISO/IEC 10646 is N. The number of leading zeros in the #xN form is insignificant.

		[a-zA-Z], [#xN-#xN]
		matches any Char with a value in the range(s) indicated (inclusive).

		[abc], [#xN#xN#xN]
		matches any Char with a value among the characters enumerated. Enumerations and ranges can be mixed in one set of brackets.

		[^a-z], [^#xN-#xN]
		matches any Char with a value outside the range indicated.

		[^abc], [^#xN#xN#xN]
		matches any Char with a value not among the characters given. Enumerations and ranges of forbidden values can be mixed in one set of brackets.

		"string"
		matches a literal string matching that given inside the double quotes.

		'string'
		matches a literal string matching that given inside the single quotes.

		These symbols may be combined to match more complex patterns as follows, where A and B represent simple expressions:

		(expression)
		expression is treated as a unit and may be combined as described in this list.

		A?
		matches A or nothing; optional A.

		A B
		matches A followed by B. This operator has higher precedence than alternation; thus A B | C D is identical to (A B) | (C D).

		A | B
		matches A or B.

		A - B
		matches any string that matches A but does not match B.

		A+
		matches one or more occurrences of A. Concatenation has higher precedence than alternation; thus A+ | B+ is identical to (A+) | (B+).

		A*
		matches zero or more occurrences of A. Concatenation has higher precedence than alternation; thus A* | B* is identical to (A*) | (B*).

		Other notations used in the productions are:

		/* ... 
		comment.

		[ wfc: ... ]
		well-formedness constraint; this identifies by name a constraint on well-formed documents associated with a production.

		[ vc: ... ]
		validity constraint; this identifies by name a constraint on valid documents associated with a production.		

		*/
		
		
		/*
		
			XML 1.1
		
			[1]   	document	   		::=   	 ( prolog element Misc* ) - ( Char* RestrictedChar Char* )
			
			[2]   	Char	   			::=   	[#x1-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]	//any Unicode character, excluding the surrogate blocks, FFFE, and FFFF.
			[2a]   	RestrictedChar	   	::=   	[#x1-#x8] | [#xB-#xC] | [#xE-#x1F] | [#x7F-#x84] | [#x86-#x9F]
			
			[3]   	S	   ::=   	(#x20 | #x9 | #xD | #xA)+
			
			[4]   	NameStartChar	   	::=   	":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
			[4a]   	NameChar	   		::=   	 NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
			[5]   	Name	   			::=   	 NameStartChar (NameChar)*
			[6]   	Names	   			::=   	 Name (#x20 Name)*
			[7]   	Nmtoken	   			::=   	(NameChar)+
			[8]   	Nmtokens	   		::=   	 Nmtoken (#x20 Nmtoken)*
			
			[9]   	EntityValue	   		::=   	'"' ([^%&"] | PEReference | Reference)* '"' |  "'" ([^%&'] | PEReference | Reference)* "'"
			[10]   	AttValue	   		::=   	'"' ([^<&"] | Reference)* '"' |  "'" ([^<&'] | Reference)* "'"
			[11]   	SystemLiteral	   	::=   	('"' [^"]* '"') | ("'" [^']* "'")
			[12]   	PubidLiteral	   	::=   	'"' PubidChar* '"' | "'" (PubidChar - "'")* "'"
			[13]   	PubidChar	   		::=   	#x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]
			[14]   	CharData	   		::=   	[^<&]* - ([^<&]* ']]>' [^<&]*)
			
			[15]   	Comment	   ::=   	'<!--' ((Char - '-') | ('-' (Char - '-')))* '-->'
			
			[16]   	PI	   				::=   	'<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
			[17]   	PITarget	   		::=   	 Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
			
			[18]   	CDSect	   			::=   	 CDStart CData CDEnd
			[19]   	CDStart	   			::=   	'<![CDATA['
			[20]   	CData	   			::=   	(Char* - (Char* ']]>' Char*))
			[21]   	CDEnd	   			::=   	']]>'
			
			[22]   	prolog	   			::=   	 XMLDecl Misc* (doctypedecl Misc*)?
			[23]   	XMLDecl	   			::=   	'<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
			[24]   	VersionInfo	   		::=   	 S 'version' Eq ("'" VersionNum "'" | '"' VersionNum '"')
			[25]   	Eq	   				::=   	 S? '=' S?
			[26]   	VersionNum	   		::=   	'1.1'
			[27]   	Misc	   			::=   	 Comment | PI | S
			
			
			
			[28]   	doctypedecl	   		::=   	'<!DOCTYPE' S Name (S ExternalID)? S? ('[' intSubset ']' S?)? '>'	[VC: Root Element Type]
			[WFC: External Subset]
			[28a]   	DeclSep	   		::=   	 PEReference | S	[WFC: PE Between Declarations]
			[28b]   	intSubset	   	::=   	(markupdecl | DeclSep)*
			[29]   	markupdecl	   		::=   	 elementdecl | AttlistDecl | EntityDecl | NotationDecl | PI | Comment	[VC: Proper Declaration/PE Nesting]
			[WFC: PEs in Internal Subset]
			
			[30]   	extSubset	   		::=   	 TextDecl? extSubsetDecl
			[31]   	extSubsetDecl	   	::=   	( markupdecl | conditionalSect | DeclSep)*
			
			[32]   	SDDecl	   			::=   	 S 'standalone' Eq (("'" ('yes' | 'no') "'") | ('"' ('yes' | 'no') '"'))	[VC: Standalone Document Declaration]
			
			(Productions 33 through 38 have been removed.)
			
			[39]   	element	   			::=   	 EmptyElemTag | STag content ETag						[WFC: Element Type Match]
																										[VC: Element Valid]
																					
			[40]   	STag	   			::=   	'<' Name (S Attribute)* S? '>'	[WFC: Unique Att Spec]
			[41]   	Attribute	   		::=   	 Name Eq AttValue										[VC: Attribute Value Type]
																										[WFC: No External Entity References]
																										[WFC: No < in Attribute Values]
																										
			[42]   	ETag	   			::=   	'</' Name S? '>'
			
			[43]   	content	   			::=   	 CharData? ((element | Reference | CDSect | PI | Comment) CharData?)*
			
			
			[44]   	EmptyElemTag	   ::=   	'<' Name (S Attribute)* S? '/>'	[WFC: Unique Att Spec]
			
			
			[45]   	elementdecl	   		::=   	'<!ELEMENT' S Name S contentspec S? '>'					[VC: Unique Element Type Declaration]
			[46]   	contentspec	   		::=   	'EMPTY' | 'ANY' | Mixed | children
			
			[47]   	children	   		::=   	(choice | seq) ('?' | '*' | '+')?
			[48]   	cp	   				::=   	(Name | choice | seq) ('?' | '*' | '+')?
			[49]   	choice	   			::=   	'(' S? cp ( S? '|' S? cp )+ S? ')'						[VC: Proper Group/PE Nesting]
			[50]   	seq	   				::=   	'(' S? cp ( S? ',' S? cp )* S? ')'						[VC: Proper Group/PE Nesting]
			
			[51]   	Mixed	   			::=   	'(' S? '#PCDATA' (S? '|' S? Name)* S? ')*' | '(' S? '#PCDATA' S? ')'		[VC: Proper Group/PE Nesting]
																													[VC: No Duplicate Types]
																													
																													
			[52]   	AttlistDecl	   		::=   	'<!ATTLIST' S Name AttDef* S? '>'
			[53]   	AttDef	   			::=   	 S Name S AttType S DefaultDecl
			
			[54]   	AttType	   			::=   	 StringType | TokenizedType | EnumeratedType
			[55]   	StringType	   		::=   	'CDATA'
			[56]   	TokenizedType	   	::=   	'ID'													[VC: ID]
																										[VC: One ID per Element Type]
																										[VC: ID Attribute Default]
												| 'IDREF'	[VC: IDREF]					
												| 'IDREFS'	[VC: IDREF]
												| 'ENTITY'	[VC: Entity Name]
												| 'ENTITIES'	[VC: Entity Name]
												| 'NMTOKEN'	[VC: Name Token]
												| 'NMTOKENS'	[VC: Name Token]
												
												
			[57]   	EnumeratedType	   	::=   	 NotationType | Enumeration
			[58]   	NotationType	   	::=   	'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')'		[VC: Notation Attributes]
																										[VC: One Notation Per Element Type]
																										[VC: No Notation on Empty Element]
																										[VC: No Duplicate Tokens]
			[59]   	Enumeration	   		::=   	'(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')'				[VC: Enumeration]
																										[VC: No Duplicate Tokens]
																										
			[60]   	DefaultDecl	   		::=   	'#REQUIRED' | '#IMPLIED' | (('#FIXED' S)? AttValue)		[VC: Required Attribute]
																										[VC: Attribute Default Value Syntactically Correct]
																										[WFC: No < in Attribute Values]
																										[VC: Fixed Attribute Default]
																										[WFC: No External Entity References]
																										
			[61]   	conditionalSect	   	::=   	 includeSect | ignoreSect
			[62]   	includeSect	   		::=   	'<![' S? 'INCLUDE' S? '[' extSubsetDecl ']]>'			[VC: Proper Conditional Section/PE Nesting]
			[63]   	ignoreSect	   		::=   	'<![' S? 'IGNORE' S? '[' ignoreSectContents* ']]>'		[VC: Proper Conditional Section/PE Nesting]
			[64]   	ignoreSectContents	::=   	 Ignore ('<![' ignoreSectContents ']]>' Ignore)*
			[65]   	Ignore	   			::=   	 Char* - (Char* ('<![' | ']]>') Char*)
			
			[66]   	CharRef	   			::=   	'&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';'				[WFC: Legal Character]
			
			
			[67]   	Reference	   		::=   	 EntityRef | CharRef
			[68]   	EntityRef	   		::=   	'&' Name ';'											[WFC: Entity Declared]
																										[VC: Entity Declared]
																										[WFC: Parsed Entity]
																										[WFC: No Recursion]
			[69]   	PEReference	   		::=   	'%' Name ';'											[VC: Entity Declared]
																										[WFC: No Recursion]
																										[WFC: In DTD]
																										
			[70]   	EntityDecl	   		::=   	 GEDecl | PEDecl
			[71]   	GEDecl	   			::=   	'<!ENTITY' S Name S EntityDef S? '>'
			[72]   	PEDecl	   			::=   	'<!ENTITY' S '%' S Name S PEDef S? '>'
			[73]   	EntityDef	   		::=   	 EntityValue | (ExternalID NDataDecl?)
			[74]   	PEDef	   			::=   	 EntityValue | ExternalID
			
			[75]   	ExternalID	   		::=   	'SYSTEM' S SystemLiteral | 'PUBLIC' S PubidLiteral S SystemLiteral
			[76]   	NDataDecl	   		::=   	 S 'NDATA' S Name										[VC: Notation Declared]
			
			
			[77]   	TextDecl	   		::=   	'<?xml' VersionInfo? EncodingDecl S? '?>'
			
			[78]   	extParsedEnt	   	::=   	 ( TextDecl? content ) - ( Char* RestrictedChar Char* )
			
			
			[80]   	EncodingDecl	   	::=   	 S 'encoding' Eq ('"' EncName '"' | "'" EncName "'" )
			
			
			[81]   	EncName	   ::=   	[A-Za-z] ([A-Za-z0-9._] | '-')*		//Encoding name contains only Latin characters
			
			[82]   	NotationDecl	   	::=   	'<!NOTATION' S Name S (ExternalID | PublicID) S? '>'	[VC: Unique Notation Name]
			[83]   	PublicID	   		::=   	'PUBLIC' S PubidLiteral
			
			
		*/
		
		/**
		* 	An expression for the NameStartChar product.
		*/
		public static const NAME_START_CHAR_EXP:String =
			"(?:[A-Za-z_:]|[\\xC0-\\xD6]|[\\xD8-\\xF6]|[ø-˿]|[Ͱ-ͽ]"
			+ "|[" + String.fromCharCode( 0x037F ) + "-"
			+ String.fromCharCode( 0x1FFF ) + "]"
			+ "|[" + String.fromCharCode( 0x200C ) + "-"
			+ String.fromCharCode( 0x200D ) + "]"
			+ "|[" + String.fromCharCode( 0x2070 ) + "-"
			+ String.fromCharCode( 0x218F ) + "]"
			+ "|[" + String.fromCharCode( 0x2C00 ) + "-"
			+ String.fromCharCode( 0x2FEF ) + "]"
			+ "|[" + String.fromCharCode( 0x3001 ) + "-"
			+ String.fromCharCode( 0xD7FF ) + "]"
			+ "|[" + String.fromCharCode( 0xF900 ) + "-"
			+ String.fromCharCode( 0xFDCF ) + "]"
			+ "|[" + String.fromCharCode( 0xFDF0 ) + "-"
			+ String.fromCharCode( 0xFFFD ) + "]"
			
			//code point \u+10000 = 65536 = 0xD800DC00 (utf-16 hex)
			//code point \u+EFFFF = 983039 = 0xDB7FDFFF (utf-16 hex)
			+ "|[" + String.fromCharCode( 0xD800DC00 ) + "-"
			+ String.fromCharCode( 0xDB7FDFFF ) + "]"
			
			//0xD800DC00
			
			+ "){1}";
			
		/**
		* 	An expression for the NameChar product.
		*/
		public static const NAME_CHAR_EXP:String =
			"(?:" + NAME_START_CHAR_EXP
			+ "|-"
			+ "|[.]"
			+ "|[0-9]"
			+ "|[\\xB7]"
			+ "|[" + String.fromCharCode( 0x0300 ) + "-"
			+ String.fromCharCode( 0x036F ) + "]"
			+ "|[" + String.fromCharCode( 0x203F ) + "-"
			+ String.fromCharCode( 0x2040 ) + "]"
			+ ")";
		
		/**
		* 	An expression for the Name product.
		*/	
		public static const NAME_EXP:String = 
			"^"
			+ NAME_START_CHAR_EXP
			+ NAME_CHAR_EXP + "*"
			+ "$";
		
		/**
		* 	A regular expression for the Name product.
		*/	
		public static const NAME_RE:RegExp = new RegExp( NAME_EXP );
			
			
			
		/*
		
		[4a]   	NameChar	   		::=   	 NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
		[5]   	Name	   			::=   	 NameStartChar (NameChar)*		
		
		*/
		
		/**
		* 	The identifier for a BOM token.
		*/
		public static const BOM:int = 0;
		
		/**
		* 	The identifier for an ident token.
		*/
		public static const IDENT:int = 1;
		
		private var _version:XMLVersion;

		/**
		* 	Creates a <code>XMLGrammar</code> instance.
		*/
		public function XMLGrammar( version:XMLVersion = null )
		{
			super();
		}
		
		/**
		* 	Determines whether the specified name is a valid
		* 	XML name.
		* 
		* 	
		* 
		* 	@param name The name to test for validity.
		* 
		* 	@return Whether the name is a valid XML name.
		*/
		static public function isValidXMLName( name:String ):Boolean
		{
			if( name == null )
			{
				return false;
			}	
			//forget about the top-level isXMLName() method
			//as it returns false for names with a namespace prefix
			return NAME_RE.test( name );
		}
		
		/**
		* 	Configures the grammar for an XML scanner
		* 	based on the XML version associated with this
		* 	grammar.
		* 
		* 	@param grammar The scanner grammar.
		* 
		* 	@return The configured grammar.
		*/
		override protected function doWithGrammar( grammar:Grammar ):Grammar
		{
			return grammar;
		}
	}
}