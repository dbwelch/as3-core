package com.ffsys.w3c.dom.bootstrap
{
	import org.flashx.ioc.BeanDescriptor;
	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.IBeanDescriptor;	
	
	import org.w3c.dom.DOMImplementation;
	
	import org.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	//
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	
	/**
	* 	A boostrap document for the DOM XML implementation.
	*/
	public class DOMXMLBootstrap extends DOMLSAsyncBootstrap
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
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			
			var impl:DOMImplementation =
				new XMLDOMImplementationImpl();
			createImplementationFactory(
				factories,
				XMLDOMImplementationImpl.NAME,
				XMLDOMImplementationImpl,
				impl );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.XML_3_FEATURE );
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			var descriptor:IBeanDescriptor = null;
			descriptor = new BeanDescriptor(
				XMLDocumentImpl.NAME );
			descriptor.instanceClass = XMLDocumentImpl;
			beans.addBeanDescriptor( descriptor );
		}
	}
}