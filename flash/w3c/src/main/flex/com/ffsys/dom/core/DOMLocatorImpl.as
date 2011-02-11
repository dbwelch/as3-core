package com.ffsys.dom.core
{
	import org.w3c.dom.*;	
	
	/**
	* 	TODO
	*/
	public class DOMLocatorImpl extends Object
		implements DOMLocator
	{
		private var _lineNumber:Number = -1;
		private var _columnNumber:Number = -1;
		private var _byteOffset:Number = -1;
		private var _utf16Offset:Number = -1;
		private var _relatedNode:Node;
		private var _uri:String;
		
		/**
		* 	Creates a <code>DOMLocatorImpl</code> instance.
		*/
		public function DOMLocatorImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get lineNumber():Number
		{
			return _lineNumber;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get columnNumber():Number
		{
			return _columnNumber;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get byteOffset():Number
		{
			return _byteOffset;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get utf16Offset():Number
		{
			return _utf16Offset;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get relatedNode():Node
		{
			return _relatedNode;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get uri():String
		{
			return _uri;
		}
	}
}