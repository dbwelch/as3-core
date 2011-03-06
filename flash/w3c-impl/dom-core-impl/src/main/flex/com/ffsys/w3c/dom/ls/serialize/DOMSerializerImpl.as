package com.ffsys.w3c.dom.ls.serialize
{
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.Node;
	
	import org.w3c.dom.ls.LSOutput;	
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.LSSerializerFilter;
	
	import com.ffsys.w3c.dom.DOMConfigurationImpl;
	
	import com.ffsys.w3c.dom.ls.LSOutputImpl;
	
	/**
	* 	TODO
	*/
	public class DOMSerializerImpl extends DOMConfigurationImpl
		implements LSSerializer, DOMConfiguration
	{
		/**
		* 	The bean name for this serializer implementation.
		*/
		public static const NAME:String = "dom-ls-serializer";	
		
		private var _newLine:String;
		private var _filter:LSSerializerFilter;	
		
		/**
		* 	Creates <code>DOMSerializerImpl</code> instance.
		*/
		public function DOMSerializerImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get domConfig():DOMConfiguration
		{
			return this;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get newLine():String
		{
			return _newLine;
		}
		
		public function set newLine( value:String ):void
		{
			_newLine = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get filter():LSSerializerFilter
		{
			return _filter;
		}
		
		public function set filter( filter:LSSerializerFilter ):void
		{
			_filter = filter;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function write(
			node:Node, destination:LSOutput ):Boolean
		{
			if( destination is LSOutputImpl && ( LSOutputImpl( destination ).e4x is XML ) )
			{
				var serializer:NativeXMLSerializer = new NativeXMLSerializer();
				//copy over the configuration
				copy( serializer );
				return serializer.write( node, destination );
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function writeToString( node:Node ):String
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function writeToURI( node:Node, uri:String ):Boolean
		{
			return false;
		}
	}
}