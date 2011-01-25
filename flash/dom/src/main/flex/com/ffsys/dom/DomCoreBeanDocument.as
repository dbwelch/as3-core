package com.ffsys.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.dom.xhtml.*;	
	import com.ffsys.css.CssBeanDocument;

	/**
	*	Defines the core beans for <code>DOM</code> documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class DomCoreBeanDocument extends BeanDocument
	{	
		/**
		* 	Creates a <code>DomCoreBeanDocument</code> instance.
		*/
		public function DomCoreBeanDocument()
		{
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
			//CORE DOM ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.ATTR );
			descriptor.instanceClass = Attr;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.TEXT );
			descriptor.instanceClass = Text;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.DOCUMENT_FRAGMENT );
			descriptor.instanceClass = DocumentFragment;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.PROCESSING_INSTRUCTION );
			descriptor.instanceClass = ProcessingInstruction;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.COMMENT );
			descriptor.instanceClass = Comment;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.CDATA_SECTION );
			descriptor.instanceClass = CDATASection;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.ENTITY );
			descriptor.instanceClass = Entity;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DomIdentifiers.ENTITY_REFERENCE );
			descriptor.instanceClass = EntityReference;
			beans.addBeanDescriptor( descriptor );
		}
	}
}