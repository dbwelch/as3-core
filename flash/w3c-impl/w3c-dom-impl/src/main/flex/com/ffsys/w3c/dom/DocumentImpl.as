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
	* 	The main document implementation.
	*/
	public class DocumentImpl extends CoreDocumentImpl
		implements DocumentTraversal, DocumentEvent, DocumentRange
	{
		/**
		* 	The bean name for a Core document.
		*/
		public static const NAME:String = "dom-core-doc";
		
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
		* 	@inheritDoc
		*/
		public function createNodeIterator(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):NodeIterator
		{
			var iterator:NodeIterator =
				DocumentTraversal( this.implementation ).createNodeIterator(
					root,
					whatToShow,
					filter,
					entityReferenceExpansion );
					
			return iterator;
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
			return DocumentTraversal( this.implementation ).createTreeWalker(
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
			return DocumentEvent( this.implementation ).createEvent(
				eventInterface );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createRange():Range
		{
			return DocumentRange( this.implementation ).createRange();
		}
	}
}