package com.ffsys.w3c.dom.ls.serialize
{
	import javax.xml.namespace.QualifiedName;
	
	import org.w3c.dom.Document;
	import org.w3c.dom.Element;
	import org.w3c.dom.Node;
	import org.w3c.dom.ls.LSOutput;
	
	import com.ffsys.w3c.dom.ls.LSOutputImpl;
	
	/**
	* 	Responsible for serializing a DOM tree to the
	* 	native XML type.
	*/
	public class NativeXMLSerializer extends DOMSerializerImpl
	{
		/**
		* 	Creates a <code>NativeXMLSerializer</code>. instance.
		*/
		public function NativeXMLSerializer()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function write(
			node:Node, destination:LSOutput ):Boolean
		{
			if( node == null )
			{
				return false;
			}
			
			if( !( LSOutputImpl( destination ).e4x is XML ) )
			{
				return false;
			}
			
			var x:XML = LSOutputImpl( destination ).e4x;
			var child:XML = getXMLNode( node, x );

			trace("NativeXMLSerializer::write()", node, x.toXMLString() );
			
			return true;
		}
		
		/**
		* 	@private
		* 
		* 	Constructs the XML for a Node.
		* 
		* 	@param node The DOM node to serialize.
		* 
		* 	@return An XML representation of the node.
		*/
		private function getXMLNode( node:Node, parent:XML ):XML
		{
			if( node is Document )
			{
				//always use the documentElement for the moment.
				node = Document( node ).documentElement;
			}
			
			//the node must be an: element | text | comment | processing instruction
			if( !( node is Element ) )
			{
				return null;
			}
			
			var prefix:String = node.lookupPrefix(
				node.namespaceURI );
			var nm:String = QualifiedName.toXMLName(
				prefix, node.nodeName );
			
			trace("NativeXMLSerializer::getXMLNode()", node, node.nodeName, nm );
			
			var x:XML = new XML( nm );
			if( parent != null )
			{
				trace("NativeXMLSerializer::getXMLNode()", "APPENDING CHILD" );
				parent.appendChild( x );
			}
			
			if( node.childNodes.length > 0 )
			{
				for( var i:int = 0;i < node.childNodes.length;i++ )
				{
					getXMLNode( node.childNodes[ i ], x );
				}
			}
			
			return x;
		}
	}
}