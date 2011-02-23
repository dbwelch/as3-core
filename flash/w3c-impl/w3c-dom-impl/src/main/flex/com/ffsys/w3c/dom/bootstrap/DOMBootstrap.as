package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.*;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationSourceImpl;
	import com.ffsys.w3c.dom.DOMImplementationListImpl;	
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	import com.ffsys.w3c.dom.events.EventImpl;
	import com.ffsys.w3c.dom.events.FocusEventImpl;
	import com.ffsys.w3c.dom.events.MutationEventImpl;
	import com.ffsys.w3c.dom.events.UIEventImpl;
	
	import com.ffsys.w3c.dom.html.HTMLDocumentImpl;
	import com.ffsys.w3c.dom.html.HTMLDOMImplementationImpl;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	import com.ffsys.w3c.dom.range.DocumentRangeImpl;
	import com.ffsys.w3c.dom.range.RangeImpl;
	
	import com.ffsys.w3c.dom.traversal.DocumentTraversalImpl;
	
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
	*/
	public class DOMBootstrap extends BeanDocument
	{
		
		/**
		* 	The name for a <code>DOM</code> bootstrap bean document.
		*/
		public static const NAME:String = "dom-bootstrap";
		
		/**
		* 	The bean name for a DOM registry.
		*/
		public static const DOM_REGISTRY:String = "dom-registry";
		
		/**
		* 	The bean name for the main DOM implementation source.
		*/
		public static const DOM_IMPL_SOURCE:String = "dom-impl-source";
		
		/**
		* 	The bean name for the main DOM implementation list.
		*/
		public static const DOM_IMPL_LIST:String = "dom-impl-list";
		
		/**
		* 	The name for a <code>DOM</code> XML implementation bean document.
		*/
		public static const XML_IMPLEMENTATION_DOC_NAME:String = "dom-xml-implementation";
		
		/**
		* 	The name for a <code>DOM</code> HTML implementation bean document.
		*/
		public static const HTML_IMPLEMENTATION_DOC_NAME:String = "dom-html-implementation";
		
		/**
		* 	An implementation for the "XML" feature.
		*/
		public static const XML_IMPLEMENTATION:String = "dom-xml-impl";
		
		/**
		* 	An implementation for the "XML" feature.
		*/
		public static const XML_DOCUMENT:String = "dom-xml-doc";
		
		/**
		* 	An implementation for the "HTML" feature.
		*/
		public static const HTML_IMPLEMENTATION:String = "dom-html-impl";
		
		/**
		* 	An implementation for the "HTML" feature.
		*/
		public static const HTML_DOCUMENT:String = "dom-html-doc";
		
		/**
		* 	A bean name for a range implementation.
		*/
		public static const RANGE_IMPL:String = "range-impl";
			
		/**
		* 	Creates a <code>DOMBootstrap</code> instance.
		* 
		* 	@param id A specific id to use for this document.
		*/
		public function DOMBootstrap( id:String = null )
		{
			this.id  = id != null ? id : NAME;
			super();
			doWithBeans( this );
		}
		
		/**
		* 	Initialies the components beans on the specified document.
		* 
		* 	@param beans The document to initialize with the bean definitions.
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			var data:Object = null;
			
			//CORE DOM ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor( DOM_REGISTRY );
			descriptor.instanceClass = DOMImplementationRegistryImpl;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( DOM_IMPL_SOURCE );
			descriptor.instanceClass = DOMImplementationSourceImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( DOM_IMPL_LIST );
			descriptor.instanceClass = DOMImplementationListImpl;
			beans.addBeanDescriptor( descriptor );
			
			//add the implementations as an xref
			xrefs.push( getXMLImplBeans() );
			xrefs.push( getHTMLImplBeans() );
		}
		
		/**
		* 	@private
		*/
		private function getXMLImplBeans():IBeanDocument
		{
			var descriptor:IBeanDescriptor = null;
			//create a document to store all implementations
			var impls:IBeanDocument = new BeanDocument( XML_IMPLEMENTATION_DOC_NAME );
			
			descriptor = new BeanDescriptor(
				XML_IMPLEMENTATION );
			descriptor.instanceClass = XMLDOMImplementationImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				XML_DOCUMENT );
			descriptor.instanceClass = XMLDocumentImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMFeature.EVENTS_MODULE );
			descriptor.instanceClass = DocumentEventImpl;
			descriptor.singleton = true;
			descriptor.names = new Vector.<String>();
			descriptor.names.push( DOMFeature.MUTATION_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.MUTATION_NAME_EVENTS_MODULE );			
			
			descriptor.names.push( DOMFeature.UI_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.MOUSE_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.TEXT_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.KEYBOARD_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.WHEEL_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.COMPOSITION_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.CUSTOM_EVENTS_MODULE );
			impls.addBeanDescriptor( descriptor );
			
			//DOM Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.EVENT_INTERFACE );
			descriptor.instanceClass = EventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Mutation Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.MUTATION_EVENT_INTERFACE );
			descriptor.instanceClass = MutationEventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM UI Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.UI_EVENT_INTERFACE );
			descriptor.instanceClass = UIEventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Focus Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.FOCUS_EVENT_INTERFACE );
			descriptor.instanceClass = FocusEventImpl;
			impls.addBeanDescriptor( descriptor );
			
			addCommonFeatures( impls );
			
			return impls;		
		}
		
		/**
		* 	@private
		*/
		private function getHTMLImplBeans():IBeanDocument
		{
			var descriptor:IBeanDescriptor = null;
			//create a document to store all implementations
			var impls:IBeanDocument = new BeanDocument( HTML_IMPLEMENTATION_DOC_NAME );
			
			descriptor = new BeanDescriptor(
				HTML_IMPLEMENTATION );
			descriptor.instanceClass = HTMLDOMImplementationImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				HTML_DOCUMENT );
			descriptor.instanceClass = HTMLDocumentImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMFeature.EVENTS_MODULE );
			descriptor.instanceClass = DocumentEventImpl;
			descriptor.singleton = true;
			descriptor.names = new Vector.<String>();
			descriptor.names.push( DOMFeature.MUTATION_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.MUTATION_NAME_EVENTS_MODULE );		
			
			descriptor.names.push( DOMFeature.UI_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.MOUSE_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.TEXT_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.KEYBOARD_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.WHEEL_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.COMPOSITION_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.CUSTOM_EVENTS_MODULE );
			impls.addBeanDescriptor( descriptor );
			
			//DOM Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.EVENT_INTERFACE );
			descriptor.instanceClass = EventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Mutation Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.MUTATION_EVENT_INTERFACE );
			descriptor.instanceClass = MutationEventImpl;
			impls.addBeanDescriptor( descriptor );
			
			
			
			//DOM UI Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.UI_EVENT_INTERFACE );
			descriptor.instanceClass = UIEventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Focus Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.FOCUS_EVENT_INTERFACE );
			descriptor.instanceClass = FocusEventImpl;
			impls.addBeanDescriptor( descriptor );

			addCommonFeatures( impls );
			
			return impls;		
		}
		
		/**
		* 	@private
		*/
		private function addCommonFeatures( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				DOMFeature.LS_MODULE );
			descriptor.instanceClass = DOMImplementationLSImpl;
			descriptor.singleton = true;
			descriptor.names = new Vector.<String>();
			descriptor.names.push( DOMFeature.LS_ASYNC_MODULE );
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMFeature.RANGE_MODULE );
			descriptor.instanceClass = DocumentRangeImpl;
			descriptor.singleton = true;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				RANGE_IMPL );
			descriptor.instanceClass = RangeImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMFeature.TRAVERSAL_MODULE );
			descriptor.instanceClass = DocumentTraversalImpl;
			descriptor.singleton = true;
			impls.addBeanDescriptor( descriptor );			
		}
	}
}