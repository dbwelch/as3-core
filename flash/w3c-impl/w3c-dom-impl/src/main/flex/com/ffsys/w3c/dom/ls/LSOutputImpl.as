package com.ffsys.w3c.dom.ls
{
	import org.w3c.dom.ls.LSOutput;
	
	/**
	* 	
	*/
	public class LSOutputImpl extends Object
		implements LSOutput
	{
		/**
		* 	The bean name for this output implementation.
		*/
		public static const NAME:String = "dom-ls-output";		
		
		/*
        protected Writer fCharStream = null;
        protected OutputStream fByteStream = null;
        protected String fSystemId = null;
        protected String fEncoding = null;		
		*/
		
		/**
		* 	Creates an <code>LSOutputImpl</code> instance.
		*/
		public function LSOutputImpl()
		{
			super();
		}
		
		/**
	    * An attribute of a language and binding dependent type that represents a
	    * writable stream of bytes. If the application knows the character encoding
	    * of the byte stream, it should set the encoding attribute. Setting the
	    * encoding in this way will override any encoding specified in an XML
	    * declaration in the data.
	    */
		
		/*
	    public Writer getCharacterStream(){
	        return fCharStream;
	     };
		*/
		
	   /**
	    * An attribute of a language and binding dependent type that represents a
	    * writable stream of bytes. If the application knows the character encoding
	    * of the byte stream, it should set the encoding attribute. Setting the
	    * encoding in this way will override any encoding specified in an XML
	    * declaration in the data.
	    */
		
		/*
	    public void setCharacterStream(Writer characterStream){
	        fCharStream = characterStream;
	    };
		*/
		
		

	   /**
	    * Depending on the language binding in use, this attribute may not be
	    * available. An attribute of a language and binding dependent type that
	    * represents a writable stream to which 16-bit units can be output. The
	    * application must encode the stream using UTF-16 (defined in [Unicode] and
	    *  Amendment 1 of [ISO/IEC 10646]).
	    */
		
		/*
	    public OutputStream getByteStream(){
	        return fByteStream;
	    };
		*/
		
	   /**
	    * Depending on the language binding in use, this attribute may not be
	    * available. An attribute of a language and binding dependent type that
	    * represents a writable stream to which 16-bit units can be output. The
	    * application must encode the stream using UTF-16 (defined in [Unicode] and
	    *  Amendment 1 of [ISO/IEC 10646]).
	    */
		
		/*
	    public void setByteStream(OutputStream byteStream){
	        fByteStream = byteStream;
	    };
		*/
		
	   /**
	    * The system identifier, a URI reference [IETF RFC 2396], for this output
	    *  destination. If the application knows the character encoding of the
	    *  object pointed to by the system identifier, it can set the encoding
	    *  using the encoding attribute. If the system ID is a relative URI
	    *  reference (see section 5 in [IETF RFC 2396]), the behavior is
	    *  implementation dependent.
	    */
		
		/*
	    public String getSystemId(){
	        return fSystemId;
	    };
		*/
		
	   /**
	    * The system identifier, a URI reference [IETF RFC 2396], for this output
	    *  destination. If the application knows the character encoding of the
	    *  object pointed to by the system identifier, it can set the encoding
	    *  using the encoding attribute. If the system ID is a relative URI
	    *  reference (see section 5 in [IETF RFC 2396]), the behavior is
	    *  implementation dependent.
	    */
		
		/*
	    public void setSystemId(String systemId){
	        fSystemId = systemId;
	    };
		*/
		
	   /**
	    * The character encoding, if known. The encoding must be a string
	    * acceptable for an XML encoding declaration ([XML 1.0] section 4.3.3
	    * "Character Encoding in Entities"). This attribute has no effect when the
	    * application provides a character stream or string data. For other sources
	    * of input, an encoding specified by means of this attribute will override
	    * any encoding specified in the XML declaration or the Text declaration, or
	    * an encoding obtained from a higher level protocol, such as HTTP
	    * [IETF RFC 2616].
	    */
		
		/*
	    public String getEncoding(){
	        return fEncoding;
	    };
		*/
		
	   /**
	    * The character encoding, if known. The encoding must be a string
	    * acceptable for an XML encoding declaration ([XML 1.0] section 4.3.3
	    * "Character Encoding in Entities"). This attribute has no effect when the
	    * application provides a character stream or string data. For other sources
	    * of input, an encoding specified by means of this attribute will override
	    * any encoding specified in the XML declaration or the Text declaration, or
	    * an encoding obtained from a higher level protocol, such as HTTP
	    * [IETF RFC 2616].
	    */
		
		/*
	    public void setEncoding(String encoding){
	        fEncoding = encoding;
	    };
		*/
		
	}
}