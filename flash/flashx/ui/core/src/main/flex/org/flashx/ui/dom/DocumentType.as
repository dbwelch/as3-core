package org.flashx.ui.dom
{
	
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
		implements IDocumentType
	{
		//private var _name:String;
		
		/**
		* 	Creates a <code>DocumentType</code> instance.
		*/
		public function DocumentType( xml:XML = null, name:String = null )
		{
			_nodeType = Node.DOCUMENT_TYPE_NODE;
			super( xml );
			if( name != null )
			{
				this.name = name;
			}
		}
		
		/**
		* 	The name of this document type.
		*/
		
		/*
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		*/
		
		//TODO: implement
		public function get entities():NamedNodeMap
		{
			return null;
		}

		//TODO: implement		
		public function get notations():NamedNodeMap
		{
			return null;
		}
		
		//TODO: implement		
		public function get publicId():String
		{
			return null;
		}
		
		//TODO: implement		
		public function get systemId():String
		{
			return null;
		}
		
		//TODO: implement		
		public function get internalSubset():String
		{
			return null;
		}
	
		/*
	
		Object DocumentType
		DocumentType has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The DocumentType object has the following properties:
		name
		This read-only property is of type String.
		entities
		This read-only property is a NamedNodeMap object.
		notations
		This read-only property is a NamedNodeMap object.
		publicId
		This read-only property is of type String.
		systemId
		This read-only property is of type String.
		internalSubset
		This read-only property is of type String.	
	
		*/
	
	}

}

