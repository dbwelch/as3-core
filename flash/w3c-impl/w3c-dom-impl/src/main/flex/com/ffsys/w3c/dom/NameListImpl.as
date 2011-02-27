package com.ffsys.w3c.dom
{
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;	
	
	
	dynamic public class NameListImpl extends AbstractNodeProxyImpl
		implements NameList
	{
		private var _namespaces:Vector.<Namespace>;
		
		/**
		* 	Creates a <code>NameListImpl</code> instance.
		*/
		public function NameListImpl()
		{
			super();
		}
		
		/**
		* 	The list of namespaces for this name list.
		*/
		public function get namespaces():Vector.<Namespace>
		{
			if( _namespaces == null )
			{
				_namespaces = new Vector.<Namespace>();
				setProxySource( _namespaces );
			}
			return _namespaces;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getName( index:int ):String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getNamespaceURI( index:int ):String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function contains( name:String ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function containsNS(
			namespaceURI:String, name:String ):Boolean
		{
			//TODO
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return this.namespaces.length;
		}
	}
}