package com.ffsys.dom
{
	/**
	*	Represents a <code>DOM</code> attribute.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class Attr extends Node
	{
		private var _name:String;
		
		/**
		* 	Creates an <code>Attr</code> instance.
		* 
		* 	@param xml The <code>XML</code> fragment
		* 	that declared this attribute.
		* 	@param name The name of the attribute.
		*/
		public function Attr( xml:XML = null, name:String = null )
		{
			_nodeType = Node.ATTRIBUTE_NODE;
			super( xml );
			if( name != null )
			{
				this.name = name;
			}
		}
		
		/**
		* 	The name of this attribute.
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		/**
		* 	Whether this attribute was specified.å
		*/
		public function get specified():Boolean
		{
			//return _specified;
			
			//TODO: determine whether an attribute of the given name was specified in the xml fragment
			//associated with this element
			
			return true;
		}
		
		/**
		* 	The element that owns this attribute.
		*/
		public function get ownerElement():Element
		{
			return null;
		}
		
		/*
		
		
		
		
		
		Object Attr
		Attr has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The Attr object has the following properties:
		name
		This read-only property is of type String.
		specified
		This read-only property is of type Boolean.
		value
		This property is of type String and can raise a DOMException object on setting.
		ownerElement
		This read-only property is a Element object.
		
		
		
		
		*/
	
	}

}

