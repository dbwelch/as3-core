package com.ffsys.dom
{
	import com.ffsys.dom.xhtml.*;
	import com.ffsys.ioc.*;
		
	/**
	*	Represents the type of a document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DocumentType extends Node
	{
		/**
		* 	The name of the bean document that
		* 	contains components to attach to
		* 	visual DOM elements.
		*/
		public static const COMPONENTS_NAME:String = "dom-components";
		
		/**
		* 	Represents an <code>XHTML</code> 1.0 strict document type.
		*/
		public static const XHTML_1_STRICT:DocumentType = new DocumentType(
			"html",
			"-//W3C//DTD XHTML 1.0 Strict//EN",
			"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" );
			
		/**
		* 	Represents an <code>XHTML</code> 1.1 document type.
		*/
		public static const XHTML_1_1:DocumentType = new DocumentType(
			"html",
			"-//W3C//DTD XHTML 1.1//EN",
			"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" );
			
		
		/*
		
			<!DOCTYPE html PUBLIC 
				"-//W3C//DTD XHTML Basic 1.1//EN"
				"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	
		
		*/
		
			
		private var _elements:IBeanDocument;
		private var _components:IBeanDocument;		
		
		private var _name:String;
		private var _entities:NamedNodeMap;
		private var _notations:NamedNodeMap;
		private var _systemId:String;
		private var _publicId:String;
		private var _internalSubset:String;
		
		/**
		* 	Creates a <code>DocumentType</code> instance.
		* 
		* 	@param name The qualified name of the document type.
		* 	@param systemId The system identifier.
		* 	@param publicId The public identifier.
		*/
		public function DocumentType(
			name:String = null,
			systemId:String = null,
			publicId:String = null )
		{
			_nodeType = Node.DOCUMENT_TYPE_NODE;
			super();
			
			if( name == null || publicId == null || systemId == null )
			{
				transfer( XHTML_1_STRICT );
			}else
			{
				_name = name;
				_publicId = publicId;
				_systemId = systemId;
			}
		}
		
		/**
		* 	The primary bean document that defines the
		* 	DOM elements.
		*/
		public function get elements():IBeanDocument
		{
			if( _elements == null )
			{
				//TODO: generate from a factory
				_elements = new XhtmlBeanDocument();
			}
			return _elements;
		}	
		
		public function set elements( value:IBeanDocument ):void
		{
			_elements = value;
		}
		
		/**
		* 	A bean document that defines visual components
		* 	to be attached to visual DOM elements.
		*/
		public function get components():IBeanDocument
		{
			if( _components == null )
			{
				_components = new BeanDocument();
				_components.id = COMPONENTS_NAME;
			}
			return _components;
		}
		
		public function set components( value:IBeanDocument ):void
		{
			_components = value;
		}		
		
		/**
		* 	An <code>XML</code> representation of the this document type.
		*/
		override public function get xml():XML
		{
			var x:XML = new XML( "<doctype><![CDATA[<!DOCTYPE "
				+ name
				+ " PUBLIC \""
				+ systemId
				+ "\" \""
				+ publicId + "\">]]></doctype>" );
			return x;
		}
		
		/**
		* 	The name of this document type.
		*/
		public function get name():String
		{
			return _name;
		}
		
		/**
		* 	Document type entities.
		*/
		public function get entities():NamedNodeMap
		{
			if( _entities == null )
			{
				_entities = new NamedNodeMap();
			}
			return _entities;
		}
		
		/**
		* 	Document type notations.
		*/
		public function get notations():NamedNodeMap
		{		
			if( _notations == null )
			{
				_notations = new NamedNodeMap();
			}
			return _notations;
		}
		
		/**
		* 	The public identifier for this document type.
		*/
		public function get publicId():String
		{
			return _publicId;
		}
		
		/**
		* 	The system identifier for this document type.
		*/
		public function get systemId():String
		{
			return _systemId;
		}
		
		/**
		* 	An internal subset for this document type.
		*/		
		public function get internalSubset():String
		{
			return _internalSubset;
		}
		
		/**
		* 	Transfers references to the name, publicId and
		* 	systemId into this document type.
		* 
		* 	@param target The target document type to transfer
		* 	into this one.
		*/
		public function transfer( target:DocumentType ):void
		{
			_name = target.name;
			_publicId = target.publicId;
			_systemId = target.systemId;
		}
		
		/**
		* 	Determines whether another document type is equal
		* 	to this document type.
		* 
		* 	@param compare The document type to compate for equality
		* 	against this document type.
		* 
		* 	@return Whether both document types are considered to be
		* 	equal.
		*/
		public function equals( compare:DocumentType ):Boolean
		{
			return compare != null && ( compare == this
				|| ( compare.name == name && compare.publicId == publicId && compare.systemId ) );
		}
	}
}