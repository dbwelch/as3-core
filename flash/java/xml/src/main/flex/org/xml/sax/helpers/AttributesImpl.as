package org.xml.sax.helpers
{
	import java.util.*;
	
	import org.xml.sax.Attributes;
	
	/**
	* 	Default implementation of the Attributes interface.
	* 
	* 	<p>This class provides a default implementation of the
	* 	SAX2 Attributes interface, with the addition of
	* 	manipulators so that the list can be modified or reused.</p>
	* 
	* 	<p>There are two typical uses of this class:</p>
	* 
	* 	<ol>
	* 		<li>to take a persistent snapshot of an Attributes
	* 		object in a startElement event; or</li>
	* 		<li>to construct or modify an Attributes object in
	* 		a SAX2 driver or filter.</li>
	* 	</ol>
	* 
	* 	<p>This class replaces the now-deprecated SAX1
	* 	AttributeListImpl class; in addition to supporting the
	* 	updated Attributes interface rather than the deprecated
	* 	AttributeList interface, it also includes a much more
	* 	efficient implementation using a single array rather
	* 	than a set of Vectors.</p>
	*/
	public class AttributesImpl extends Object
		implements Attributes
	{
		private var _map:Map;
		
		/**
		* 	Creates an <code>AttributesImpl</code> instance.
		*/
		public function AttributesImpl()
		{
			super();
			_map = new HashMap();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getIndex( qname:String ):int
		{
			//TODO			
			return -1;
		}
		
		public function getIndexNS( uri:String, localName:String ):int
		{
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLength():int
		{
			//TODO			
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLocalName( index:int ):String
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getQName( index:int ):String
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getType( index:int ):String
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getTypeNS( uri:String, localName:String ):String
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getURI( index:int ):String
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getValueByIndex( index:int ):String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getValue( qname:String ):String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getValueNS( uri:String, localName:String ):String
		{
			//TODO
			return null;
		}
	}
}