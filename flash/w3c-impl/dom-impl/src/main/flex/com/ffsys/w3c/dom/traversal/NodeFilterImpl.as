package com.ffsys.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.traversal.NodeFilter;
	
	/**
	* 	Encapsulates the constants for a node filter
	* 	and provides an abstract implementation of
	* 	the NodeFilter interface.
	* 
	* 	This implementation's acceptNode() method
	* 	returns <code>FILTER_ACCEPT</code> to accept
	* 	all nodes by default. This behaviour should
	* 	be modified by derived implementations.
	*/
	public class NodeFilterImpl extends Object
		implements NodeFilter
	{
		/**
		* 	This constant is of type short and its value is 1.
		*/
		public static const FILTER_ACCEPT:uint = 1;
		
		/**
		* 	This constant is of type short and its value is 2.
		*/
		public static const FILTER_REJECT:uint = 2;
		
		/**
		* 	This constant is of type short and its value is 3.
		*/
		public static const FILTER_SKIP:uint = 3;
		
		/**
		* 	This constant is of type Number and its value is 0xFFFFFFFF.
		*/
		public static const SHOW_ALL:Number = 0xFFFFFFFF;
		
		/**
		* 	This constant is of type Number and its value is 0x00000001.
		*/
		public static const SHOW_ELEMENT:Number = 0x00000001;
		
		/**
		* 	This constant is of type Number and its value is 0x00000002.
		*/
		public static const SHOW_ATTRIBUTE:Number = 0x00000002;
		
		/**
		* 	This constant is of type Number and its value is 0x00000004.
		*/
		public static const SHOW_TEXT:Number = 0x00000004;
		
		/**
		* 	This constant is of type Number and its value is 0x00000008.
		*/
		public static const SHOW_CDATA_SECTION:Number = 0x00000008;
		
		/**
		* 	This constant is of type Number and its value is 0x00000010.
		*/
		public static const SHOW_ENTITY_REFERENCE:Number = 0x00000010;
		
		/**
		* 	This constant is of type Number and its value is 0x00000020.
		*/
		public static const SHOW_ENTITY:Number = 0x00000020;
		
		/**
		* 	This constant is of type Number and its value is 0x00000040.
		*/
		public static const SHOW_PROCESSING_INSTRUCTION:Number = 0x00000040;
		
		/**
		* 	This constant is of type Number and its value is 0x00000080.
		*/
		public static const SHOW_COMMENT:Number = 0x00000080;
		
		/**
		* 	This constant is of type Number and its value is 0x00000100.
		*/
		public static const SHOW_DOCUMENT:Number = 0x00000100;
		
		/**
		* 	This constant is of type Number and its value is 0x00000200.
		*/
		public static const SHOW_DOCUMENT_TYPE:Number = 0x00000200;
		
		/**
		* 	This constant is of type Number and its value is 0x00000400.
		*/
		public static const SHOW_DOCUMENT_FRAGMENT:Number = 0x00000400;
		
		/**
		* 	This constant is of type Number and its value is 0x00000800.
		*/
		public static const SHOW_NOTATION:Number = 0x00000800;
		
		/**
		* 	@private
		*/
		public function NodeFilterImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
        public function acceptNode( n:Node ):uint
		{
			return FILTER_ACCEPT;
        }
	}
}