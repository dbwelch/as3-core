package com.ffsys.dom.core
{
	import com.ffsys.dom.core.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;

	public class DOMImplementationSourceImpl extends AbstractNodeProxyImpl
		implements DOMImplementationSource
	{
		private var _sources:Vector.<DOMImplementation>;
		
		/**
		* 	Creates a <code>DOMImplementationSourceImpl</code> instance.
		*/
		public function DOMImplementationSourceImpl()
		{
			super();
		}
		
		/**
		* 	A collection of implementations that are the
		* 	sources for this implementation source.
		*/
		public function get sources():Vector.<DOMImplementation>
		{
			return _sources;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation(
			features:String ):DOMImplementation
		{
			//TODO
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList(
			features:String ):DOMImplementationList
		{
			//TODO
			return null;
		}
	}
}
