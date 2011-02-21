package com.ffsys.w3c.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.core.*;
	
	import com.ffsys.w3c.dom.bootstrap.DOMImplementationRegistryImpl;

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
		* 	The default name for a <code>DOM</code> registry bean document.
		*/
		public static const NAME:String = "dom-core-bootstrap";
		
		/**
		* 	The default name for a <code>DOM</code> implementation bean document.
		*/
		public static const IMPLEMENTATIONS_NAME:String = "dom-core-implementations";
		
		/**
		* 	The bean name for a DOM registry.
		*/
		public static const DOM_REGISTRY:String = "dom-registry";
		
		/**
		* 	The bean name for the main DOM implementation source.
		*/
		public static const DOM_SOURCE:String = "dom-source";
		
		/**
		* 	The bean name for the main DOM implementation source.
		*/
		public static const DOM_IMPL_LIST:String = "dom-impl-list";		
		
		/**
		* 	An implementation for the "XML" feature.
		*/
		public static const XML_IMPLEMENTATION:String = "dom-xml-impl";
		
		/**
		* 	An implementation for the "XML" feature.
		*/
		public static const XML_DOCUMENT:String = "dom-xml-doc";
			
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
			
			descriptor = new BeanDescriptor( DOM_SOURCE );
			descriptor.instanceClass = DOMImplementationSourceImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor( DOM_IMPL_LIST );
			descriptor.instanceClass = DOMImplementationListImpl;
			beans.addBeanDescriptor( descriptor );
			
			//create a document to store all implementations
			var impls:IBeanDocument = new BeanDocument( IMPLEMENTATIONS_NAME );
			
			descriptor = new BeanDescriptor(
				XML_IMPLEMENTATION );
			descriptor.instanceClass = XMLImplementationImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				XML_DOCUMENT );
			descriptor.instanceClass = XMLDocumentImpl;
			impls.addBeanDescriptor( descriptor );			
			
			trace("DOMBootstrap::DOMBootstrap()",
				descriptor, descriptor.id );
				
			//add the implementations as an xref
			xrefs.push( impls );
		}
	}
}