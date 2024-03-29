package com.ffsys.w3c.dom.ls.parser
{
	import org.w3c.dom.Document;	
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.Node;
	import org.w3c.dom.ls.LSInput;	
	import org.w3c.dom.ls.LSParser;
	import org.w3c.dom.ls.LSParserFilter;
	
	import com.ffsys.w3c.dom.DOMConfigurationImpl;
	
	/**
	* 	
	*/
	public class DOMParserImpl extends DOMConfigurationImpl
		implements LSParser, DOMConfiguration
	{
		/**
		* 	The bean name for this parser implementation.
		*/
		public static const NAME:String = "dom-ls-parser";
		
		/**
		* 	Create a synchronous LSParser.
		*/
		public static const MODE_SYNCHRONOUS:uint = 1;
		
		/**
		* 	Create an asynchronous LSParser.
		*/
		public static const MODE_ASYNCHRONOUS:uint = 2;	
		
		/**
		* 	Append the result of the parse operation
		* 	as children of the context node.
		*/
		public static const ACTION_APPEND_AS_CHILDREN:uint = 1;
		
		/**
		* 	Replace all the children of the context node
		* 	with the result of the parse operation.
		*/
		public static const ACTION_REPLACE_CHILDREN:uint = 2;
		          
		/**
		* 	Insert the result of the parse operation as
		* 	the immediately preceding sibling of the context node.
		*/
		public static const ACTION_INSERT_BEFORE:uint = 3;
		
		/**
		* 	Insert the result of the parse operation
		* 	as the immediately following sibling of
		* 	the context node.
		*/
		public static const ACTION_INSERT_AFTER:uint = 4;

		/**
		* 	Replace the context node with the result
		* 	of the parse operation.
		*/
		public static const ACTION_REPLACE:uint = 5;
		
		private var _async:Boolean;
		private var _busy:Boolean;
		private var _filter:LSParserFilter;
		
		/**
		* 	Creates a <code>DOMParserImpl</code> instance.
		*/
		public function DOMParserImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function abort():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get async():Boolean
		{
			return _async;
		}
		
		/**
		* 	@inheritDoc
		*/	
		public function get busy():Boolean
		{
			return _busy;
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
		public function get filter():LSParserFilter
		{
			return _filter;
		}
		
		public function set filter( filter:LSParserFilter ):void
		{
			_filter = filter;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parse( input:LSInput ):Document
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parseURI( uri:String ):Document
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parseWithContext( input:LSInput, context:Node, action:uint ):Node
		{
			//TODO			
			return null;
		}		
	}
}