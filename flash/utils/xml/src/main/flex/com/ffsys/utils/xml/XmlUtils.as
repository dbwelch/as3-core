package com.ffsys.utils.xml {
	
	/**
	*	Utility methods for working with
	*	<code>XML</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2007
	*/
	public class XmlUtils extends Object {
		
		/**
		*	@private
		*/
		public function XmlUtils()
		{
			super();
		}
		
		/**
		*	Gets an XML node from a given name and optional value.
		*	
		*	@param nodeName The name to use for the <code>XML</code> node.
		*	@param value A text value for the node's content.
		*	@param cdata A <code>Boolean</code> indicating whether the node's
		*	content should be wrapped in a CDATA element.
		*	@param attributes An <code>Object</code> whose properties will become
		*	attributes of the generated node.
		*	
		*	@return An <code>XML</code> node.
		*/
		static public function getSimpleXmlNode(
			nodeName:String,
			value:String = null,
			cdata:Boolean = false,
			attributes:Object = null ):XML
		{
			var x:XML = new XML( "<" + nodeName + " />" );
			
			if( cdata && value )
			{
				value = "<![CDATA[" + value + "]]>";
			}
			
			if( value )
			{
				x = new XML( "<" + nodeName + ">" + value + "</" + nodeName + ">" );
			}
			
			if( attributes )
			{
				var z:String;
				
				for( z in attributes )
				{
					x.@[ z ] = attributes[ z ];
				}
			}
			
			return x;
		}
		
		/**
		*	Determines whether an <code>XML</code> node has
		*	any attributes.
		*	
		*	@param node The <code>XML</code> node to inspect.
		*	
		*	@return A <code>Boolean</code> indicating whether the node
		*	has any attributes.
		*/
		static public function hasAttributes( node:XML ):Boolean
		{
			var attributes:XMLList = node.attributes();
			return ( attributes.length() > 0 );
		}
		
		/**
		*	Determines whether an <code>XML</code> node is empty.
		*	
		*	A node is considered to be empty if it has no attributes
		*	and no child nodes.
		*	
		*	@param node The <code>XML</code> node to inspect.
		*	
		*	@return A <code>Boolean</code> indicating whether the
		*	node is empty.
		*/
		static public function isEmptyNode( node:XML ):Boolean
		{
			if( !node )
			{
				return true;
			}
			
			var isEmpty:Boolean =
				node.hasSimpleContent() && ( node.children().length() == 0 );
			
			if( hasAttributes( node ) )
			{
				return false;
			}
			
			return isEmpty;
		}
		
		/**
		*	Determines whether an <code>XML</code> node has a single
		*	text child node.
		*
		*	@param node The <code>XML</code> node to inspect
		*
		*	@return A <code>Boolean</code> indicating whether the node has a single
		*	text child node.
		*/
		static public function isTextNode( node:XML ):Boolean
		{
			if( node.children().length() == 1 &&
				node.children()[ 0 ].nodeKind() == "text" )
			{
				return true;
			}
			
			return false;
		}
	}
}