package com.ffsys.w3c.dom.ls.parser
{
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.ls.LSParser;
	
	/**
	* 	
	*/
	public class DOMParserImpl extends Object
		//implements LSParser, DOMConfiguration
	{
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
		
		/**
		* 	Creates a <code>DOMParserImpl</code> instance.
		*/
		public function DOMParserImpl()
		{
			super();
		}
	}
}