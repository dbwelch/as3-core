package com.ffsys.w3c.xni.grammar
{
	import com.ffsys.w3c.xni.XMLResourceIdentifier;

	public interface XMLGrammarDescription
		extends XMLResourceIdentifier
	{
		
		
		// initial set of grammar constants that some configurations will recognize;user
	    // components which create and/or recognize other types of grammars may
	    // certainly use their own constants in place of these (so long as
	    // their Grammar objects implement this interface).

	    /*
	     * The grammar type constant for XML Schema grammars. When getGrammarType()
	     * method returns this constant, the object should be an instance of
	     * the XMLSchemaDescription interface.
	     */
	    //public static final String XML_SCHEMA = "http://www.w3.org/2001/XMLSchema";

	    /*
	     * The grammar type constant for DTD grammars. When getGrammarType()
	     * method returns this constant, the object should be an instance of
	     * the XMLDTDDescription interface.
	     */
	    //public static final String XML_DTD = "http://www.w3.org/TR/REC-xml";

	    /*
	     * Return the type of this grammar.
	     * 
	     * @return  the type of this grammar
	     */
	    //public String getGrammarType();
	}
}