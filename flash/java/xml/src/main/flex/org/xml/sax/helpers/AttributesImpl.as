package org.xml.sax.helpers
{
	import java.util.*;
	
	import org.xml.sax.Attributes;
	
	/**
	* 	
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
		public function getURI( index:int ):String
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
	}
}