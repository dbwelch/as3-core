package com.ffsys.dom
{
	
	/**
	*	Represents the <code>DOM</code> implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DOMImplementation extends Object
	{
		
		public static const VERSION_1:String = "1.0";
		
		public static const VERSION_1_1:String = "1.1";		
		
		public static const VERSION_2_0:String = "2.0";
	
		public function DOMImplementation()
		{
			super();
		}
		
		public function hasFeature( feature:String, version:String ):Boolean
		{
			return false;
		}
		
		public function getXhtmlDocumentType( version:String = VERSION_1 ):DocumentType
		{
			var qualifiedName:String = "html";
			var publicId:String = null;
			var systemId:String = null;
			
			switch( version )
			{
				case VERSION_1:
					systemId = "\"-//W3C//DTD XHTML 1.0 Strict//EN\"";
					publicId = "\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"";
					break;
			}
			
			
			
			/*
			<!DOCTYPE html PUBLIC 
				"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
			
			*/
			
			// "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"
			
			// "-//W3C//DTD XHTML Basic 1.1//EN"
			
			return createDocumentType( qualifiedName, publicId, systemId );
		}
		
		public function createDocumentType( 
			qualifiedName:String, publicId:String, systemId:String ):DocumentType
		{
			var x:XML = new XML( "<!DOCTYPE " + qualifiedName + " PUBLIC \"" + systemId + "\" \"" + publicId + "\">" );
			trace("[DOCTYPE] DOMImplementation::createDocumentType()", x.toXMLString() );
			return new DocumentType( x );
		}
		
		public function createDocument(
			namespaceURI:String, qualifiedName:String, docType:DocumentType ):Document
		{
			//TOOD: implement properly
			var x:XML =
				<html>
					<head>
					</head>
					<body>
					</body>
				</html>;
				
			x.@[ 'xmlns' ] = namespaceURI;
			x.@[ 'xml:lang' ] = "en";
			x.setName( qualifiedName );
			return new Document( x );
		}
	
		/*
	
		Object DOMImplementation
		The DOMImplementation object has the following methods:
		hasFeature(feature, version)
		This method returns a Boolean.
		The feature parameter is of type String.
		The version parameter is of type String.
		createDocumentType(qualifiedName, publicId, systemId)
		This method returns a DocumentType object.
		The qualifiedName parameter is of type String.
		The publicId parameter is of type String.
		The systemId parameter is of type String.
		This method can raise a DOMException object.
		createDocument(namespaceURI, qualifiedName, doctype)
		This method returns a Document object.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
		The doctype parameter is a DocumentType object.
		This method can raise a DOMException object.	
	
	
	
		*/
	
	}

}