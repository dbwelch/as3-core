package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;	
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	//
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	
	/**
	* 	A boostrap document for the DOM XML implementation.
	*/
	public class DOMXMLBootstrap extends DOMCoreBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> XML implementation bean document.
		*/
		public static const NAME:String = DOMFeature.XML_MODULE;
		
		/**
		* 	Creates a <code>DOMXMLBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMXMLBootstrap( identifier:String = null )
		{
			if( identifier == null )
			{
				identifier = NAME;
			}
			super( identifier );
		}
		
		/**
		* 	Initialies the components beans on the specified document.
		* 
		* 	@param beans The document to initialize with the bean definitions.
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				XMLDOMImplementationImpl.NAME );
			descriptor.instanceClass = XMLDOMImplementationImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				XMLDocumentImpl.NAME );
			descriptor.instanceClass = XMLDocumentImpl;
			beans.addBeanDescriptor( descriptor );
			
			addLoadSaveImplementations( beans );
			
			descriptor = new BeanDescriptor(
				DOMFeature.EVENTS_MODULE );
			descriptor.instanceClass = DocumentEventImpl;
			descriptor.singleton = true;
			descriptor.names = new Vector.<String>();
			addCommonEventAliases( descriptor.names );
			beans.addBeanDescriptor( descriptor );
			
			addCommonEvents( beans );
			addCommonFeatures( beans );
		}
	}
}