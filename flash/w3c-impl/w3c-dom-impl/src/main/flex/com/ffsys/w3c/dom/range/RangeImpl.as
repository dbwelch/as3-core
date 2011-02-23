package com.ffsys.w3c.dom.range
{
	import org.w3c.dom.Node;
	import org.w3c.dom.range.Range;
	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;	

	/**
	* 	Represents a range of nodes.
	*/
	public class RangeImpl extends AbstractNodeProxyImpl
		implements Range
	{	
		private var _startContainer:Node;
		private var _endContainer:Node;
		private var _commonAncestorContainer:Node;
		private var _collapsed:Boolean = false;
		private var _startOffset:uint;
		private var _endOffset:uint;
		
		/**
		* 	Creates a <code>RangeImpl</code> instance.
		*/
		public function RangeImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get startContainer():Node
		{
			return _startContainer;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get startOffset():uint
		{
			return _startOffset;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get endContainer():Node
		{
			return _endContainer;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get endOffset():uint
		{
			return _endOffset;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get collapsed():Boolean
		{
			return _collapsed;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get commonAncestorContainer():Node
		{
			return _commonAncestorContainer;
		}
	}
}