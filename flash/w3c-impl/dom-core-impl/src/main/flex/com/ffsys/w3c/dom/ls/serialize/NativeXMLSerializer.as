package com.ffsys.w3c.dom.ls.serialize
{
	import java.util.TreeMap;	
	import java.util.Map;	
	
	import javax.xml.namespace.QualifiedName;

	import org.w3c.dom.Attr;
	import org.w3c.dom.CDATASection;
	import org.w3c.dom.Comment;	
	import org.w3c.dom.Document;
	import org.w3c.dom.Element;
	import org.w3c.dom.NamedNodeMap;
	import org.w3c.dom.Node;
	import org.w3c.dom.ProcessingInstruction;
	import org.w3c.dom.Text;	
	import org.w3c.dom.ls.LSOutput;
	
	import com.ffsys.w3c.dom.NamedNodeMapImpl;
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
			
			var settings:Object = XML.settings();
			
			XML.ignoreComments = false;
			XML.ignoreProcessingInstructions = false;
			
			var x:XML = getXMLNode( node, null );
			LSOutputImpl( destination ).e4x = x;
			//trace("[WRITTEN XML] NativeXMLSerializer::write()", node, x.toXMLString() );
			
			//XML.setSettings( settings );
			
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
			
			//the node must be an: element | text | comment | cdata | processing instruction
			if( !( node is Element )
				&& !( node is Text )
				&& !( node is Comment )
				&& !( node is CDATASection )
				&& !( node is ProcessingInstruction ) )
			{
				return null;
			}
			
			var x:XML = null;
			
			if( node is CDATASection )
			{
				x = new XML( "<![CDATA[" + CDATASection( node ).data  + "]]>" );
				parent.appendChild( x );
				return x;
			}else if( node is Comment )
			{
				trace("[FOUND COMMENT NODE] NativeXMLSerializer::getXMLNode()", Comment( node ).data );
				
				x = new XML( "<!--" + Comment( node ).data  + "-->" );
				parent.appendChild( x );
				return x;
			}else if( node is ProcessingInstruction )
			{
				x = new XML( "<?" + ProcessingInstruction( node ).target + " ?>" );
				parent.appendChild( x );
				return x;
			}else if( node is Text )
			{
				x = new XML( Text( node ).data );
				parent.appendChild( x );
				return x;
			}
			
			var i:int = 0;
			var attributes:Map = new TreeMap();
			
			if( node.attributes.length > 0 )
			{
				var mapping:NamedNodeMapImpl = NamedNodeMapImpl( node.attributes );
				var map:Map = mapping.map();
				var keys:Array = map.keySet().toArray();
				var key:Object = null;
				var attr:Attr = null;
				for( i = 0;i < keys.length;i++ )
				{
					key = keys[ i ];
					attr = Attr( map.item( key ) );
					attributes.put( attr.name, attr.value );
				}
			}
			
			var nm:String = QualifiedName.toXMLName(
				null,
				node.nodeName,
				attributes,
				getParameter( "xml-namespaces" ) );
				
			trace("NativeXMLSerializer::getXMLNode()", "GOT XML", node.nodeName, nm );
			
			x = new XML( nm );
			
			if( parent != null )
			{
				parent.appendChild( x );
			}
			
			if( node.childNodes.length > 0 )
			{
				for( i = 0;i < node.childNodes.length;i++ )
				{
					getXMLNode( node.childNodes[ i ], x );
				}
			}
			
			return x;
		}
		
		
		//update the internal XML representation of the element name
		//xml.setName( new QName( uri, name ) );
		
		
		/*
		* 	An <code>XML</code> representation of this node.
		*/
		
		/*
		override public function get xml():XML
		{
			if( _xml == null || _xml.toString() != data )
			{
				_xml = new XML( "<![CDATA[" + data + "]]>" );
			}
			return _xml;
		}
		*/
		
		
		/*
		* 	An <code>XML</code> representation of this node.
		*/
		/*
		override public function get xml():XML
		{
			if( _xml == null || _xml.toString() != data )
			{
				_xml = new XML( "<!--" + data + "-->" );
			}
			return _xml;
		}
		*/
		
		
		/*
		* 	An <code>XML</code> representation of the this document type.
		*/
		
		/*
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
		*/
		
		
		/**
		* 	Ensures that the representation of
		* 	a processing instruction is correct.
		*/
		
		/*
		override public function get xml():XML
		{
			if( _xml == null || _xml.name().localName != data )
			{
				_xml = new XML( "<?" + data + " ?>" );
			}
			return _xml;
		}
		*/
		
		//delete xml.@[ attr.nodeName ];
		
		/*
		if( tagName != null
			&& tagName.length > 0
			&& !/^\s+$/.test( tagName ) )
		{
			//trace("[NS] ElementImpl::setTagName()", ns );
			
			var nsAttr:String = "";
			if( ns != null )
			{
				nsAttr = " xmlns:" + ns.prefix + "=\"" + ns.uri + "\"";
			}
			_xml = new XML( "<" + tagName + nsAttr + " />" );
		}
		*/
		
		/*
		* 	Ensures the xml representation is in sync
		* 	with the attribute definitions for this node.
		*/
		
		/*
		override public function get xml():XML
		{
			var x:XML = super.xml;
			//
			if( x != null && !( this is Document ) )
			{
				x.removeNamespace( x.@xmlns );
			}
			return x;
		}
		*/
	}
}