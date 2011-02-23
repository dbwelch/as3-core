package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;
		
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;	
	import org.w3c.dom.range.DocumentRange;
	import org.w3c.dom.range.Range;
	import org.w3c.dom.traversal.DocumentTraversal;	
	import org.w3c.dom.traversal.NodeFilter;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.TreeWalker;
	
	/**
	* 	
	*/
	public class DocumentImpl extends CoreDocumentImpl
		implements DocumentTraversal, DocumentEvent, DocumentRange
	{
		private var _documentTraversal:DocumentTraversal;
		private var _documentEvent:DocumentEvent;
		private var _documentRange:DocumentRange;
		
		/**
		* 	@private
		* 
		* 	Creates a <code>DocumentImpl</code> instance.
		*/
		public function DocumentImpl()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		protected function get documentTraversal():DocumentTraversal
		{
			if( _documentTraversal == null )
			{
				_documentTraversal = DocumentTraversal(
					this.implementation.getFeature(
						DOMFeature.TRAVERSAL_MODULE,
						DOMFeature.LEVEL_3 ) );
			}
			return _documentTraversal;
		}
		
		/**
		* 	@private
		*/
		protected function get documentEvent():DocumentEvent
		{
			if( _documentEvent == null )
			{
				_documentEvent = DocumentEvent(
					this.implementation.getFeature(
						DOMFeature.EVENTS_MODULE,
						DOMFeature.LEVEL_3 ) );
			}
			return _documentEvent;
		}
		
		/**
		* 	@private
		*/
		protected function get documentRange():DocumentRange
		{
			if( _documentRange == null )
			{
				_documentRange = DocumentRange(
					this.implementation.getFeature(
						DOMFeature.RANGE_MODULE,
						DOMFeature.LEVEL_3 ) );
			}
			return _documentRange;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createNodeIterator(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):NodeIterator
		{
			return this.documentTraversal.createNodeIterator(
				root,
				whatToShow,
				filter,
				entityReferenceExpansion );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTreeWalker(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):TreeWalker
		{
			return this.documentTraversal.createTreeWalker(
				root,
				whatToShow,
				filter,
				entityReferenceExpansion );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createEvent( eventInterface:String ):DOMEvent
		{
			return this.documentEvent.createEvent(
				eventInterface );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createRange():Range
		{
			return this.documentRange.createRange();
		}
	}
}