package com.ffsys.w3c.dom
{
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;	

	dynamic public class DOMImplementationListImpl extends AbstractNodeProxyImpl
		implements DOMImplementationList
	{
		/**
		* 	The bean name for the main DOM implementation list.
		*/
		public static const NAME:String = "dom-impl-list";
		
		private var _implementations:Vector.<DOMImplementation>;
	
		/**
		* 	Creates a DOMImplementationListImpl instance.
		*/
		public function DOMImplementationListImpl()
		{
			super();
			setProxySource( this.implementations );
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
			}
			return _implementations;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:int ):DOMImplementation
		{
			return this.implementations[ index ] as DOMImplementation;
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