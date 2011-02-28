package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.*;
	
	import com.ffsys.w3c.dom.*;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	import com.ffsys.w3c.dom.events.EventImpl;
	import com.ffsys.w3c.dom.events.FocusEventImpl;
	import com.ffsys.w3c.dom.events.MutationEventImpl;
	import com.ffsys.w3c.dom.events.UIEventImpl;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	import com.ffsys.w3c.dom.ls.LSInputImpl;
	import com.ffsys.w3c.dom.ls.LSOutputImpl;
	import com.ffsys.w3c.dom.ls.serialize.DOMSerializerImpl;
	import com.ffsys.w3c.dom.ls.parser.DOMParserImpl;
		
	import com.ffsys.w3c.dom.range.DocumentRangeImpl;
	import com.ffsys.w3c.dom.range.RangeImpl;
	
	import com.ffsys.w3c.dom.traversal.DocumentTraversalImpl;
	import com.ffsys.w3c.dom.traversal.NodeIteratorImpl;
	import com.ffsys.w3c.dom.traversal.TreeWalkerImpl;
	
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;

	/**
	*	A bean document used to implementations
	* 	that are used during the bootstrap process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	* 
	* 	@todo Ensure that shared bean descriptors are the same instance.
	*/
	public class DOMBootstrap extends BeanDocument
	{
		/**
		* 	The name for a <code>DOM</code> bootstrap bean document.
		*/
		public static const NAME:String = "dom-bootstrap";
		
		/**
		* 	The name for the <code>DOM</code> implementation bean document.
		*/
		public static const DOM_IMPLEMENTATION_DOC_NAME:String = DOMFeature.XML_MODULE;
		
		/**
		* 	The name for the <code>DOM</code> HTML implementation bean document.
		*/
		public static const HTML_IMPLEMENTATION_DOC_NAME:String = DOMFeature.HTML_MODULE;
		
		/**
		* 	The name for the <code>DOM</code> LS implementation bean document.
		*/
		public static const LS_IMPLEMENTATION_DOC_NAME:String = DOMFeature.LS_MODULE;
		
		/**
		* 	The name for the <code>DOM</code> LS Async implementation bean document.
		*/
		public static const LS_ASYNC_IMPLEMENTATION_DOC_NAME:String = DOMFeature.LS_ASYNC_MODULE;
			
		/**
		* 	Creates a <code>DOMBootstrap</code> instance.
		* 
		* 	@param identifier A specific id to use for this document.
		*/
		public function DOMBootstrap( identifier:String = null )
		{
			super( identifier );
			doWithBeans( this );
		}
		
		/**
		* 	Initializes the beans on the specified document.
		* 
		* 	@param beans The document to initialize with the
		* 	bean definitions.
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			addImplementationRegistry( beans );
			
			//add the implementations as an xref
			xrefs.push( new DOMXMLBootstrap() );
			xrefs.push( new DOMHTMLBootstrap() );
			
			xrefs.push( getLSFeatureDocument() );
			xrefs.push( getLSAsyncFeatureDocument() );
		}
		
		/**
		* 	@private
		*/
		protected function addImplementationRegistry( beans:IBeanDocument ):void
		{
			//CORE DOM IMPLEMENTATION ACCESS ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DOMImplementationRegistry.NAME );
			descriptor.instanceClass = DOMImplementationRegistry;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMImplementationSourceImpl.NAME );
			descriptor.instanceClass = DOMImplementationSourceImpl;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( 
			 	DOMImplementationListImpl.NAME );
			descriptor.instanceClass = DOMImplementationListImpl;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );			
		}
		
		/**
		* 	@private
		*/
		protected function getLSFeatureDocument():IBeanDocument
		{
			var descriptor:IBeanDescriptor = null;
			
			var ls:IBeanDocument = new BeanDocument(
				LS_IMPLEMENTATION_DOC_NAME );
			
			descriptor = new BeanDescriptor(
				DOMFeature.LS_MODULE );
			descriptor.instanceClass = DOMImplementationLSImpl;
			descriptor.singleton = true;
			ls.addBeanDescriptor( descriptor );
			
			addLoadSaveImplementations( ls );
			
			return ls;			
		}
		
		/**
		* 	@private
		*/
		protected function getLSAsyncFeatureDocument():IBeanDocument
		{
			var descriptor:IBeanDescriptor = null;
			
			var lsAsync:IBeanDocument = new BeanDocument(
				LS_ASYNC_IMPLEMENTATION_DOC_NAME );
			
			descriptor = new BeanDescriptor(
				DOMFeature.LS_ASYNC_MODULE );
			descriptor.instanceClass = DOMImplementationLSImpl;
			descriptor.singleton = true;
			lsAsync.addBeanDescriptor( descriptor );
			
			addLoadSaveImplementations( lsAsync );
			
			return lsAsync;			
		}
		
		protected function addLoadSaveImplementations( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				LSInputImpl.NAME );
			descriptor.instanceClass = LSInputImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				LSOutputImpl.NAME );
			descriptor.instanceClass = LSOutputImpl;
			impls.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				DOMSerializerImpl.NAME );
			descriptor.instanceClass = DOMSerializerImpl;
			impls.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				DOMParserImpl.NAME );
			descriptor.instanceClass = DOMParserImpl;
			impls.addBeanDescriptor( descriptor );
		}
	}
}