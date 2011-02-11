package com.ffsys.dom.core
{
	import com.ffsys.dom.core.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;	

	dynamic public class DOMImplementationListImpl extends AbstractNodeProxyImpl
		implements DOMImplementationList
	{
		private var _implementations:Vector.<DOMImplementation>;
	
		/**
		* 	Creates a DOMImplementationListImpl instance.
		*/
		public function DOMImplementationListImpl()
		{
			super();
		}
		
		/**
		* 	The collection of implementations encapsulated
		* 	by this list.
		*/
		public function get implementations():Vector.<DOMImplementation>
		{
			if( _implementations == null )
			{
				_implementations = new Vector.<DOMImplementation>();
				setProxySource( _implementations );
			}
			return _implementations;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:int ):DOMImplementation
		{
			return this[ index ] as DOMImplementation;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return this.implementations.length;
		}
	}
}