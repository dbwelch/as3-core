package com.ffsys.ui.dom
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
	
		public function DOMImplementation()
		{
			super();
		}
		
		public function hasFeature( feature:String, version:String ):Boolean
		{
			return false;
		}
		
		public function createDocumentType( 
			qualifiedName:String, publicId:String, systemId:String ):IDocumentType
		{
			return null;
		}
		
		public function createDocument(
			namespaceURI:String, qualifiedName:String, docType:IDocumentType ):IDomDocument
		{
			return null;
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

