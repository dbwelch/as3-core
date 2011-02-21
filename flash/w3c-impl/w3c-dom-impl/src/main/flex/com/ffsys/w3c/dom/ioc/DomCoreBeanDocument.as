package com.ffsys.w3c.dom.ioc
{
	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.core.*;

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
		* 	The default name for <code>DOM</code> bean documents.
		*/
		public static const NAME:String = "dom-core";
		
		//CORE DOM ELEMENTS
		
		/**
		* 	The identifier for a document.
		*/
		public static const DOCUMENT:String = "html";		//TODO: change this!
		
		/**
		* 	The identifier for <code>DOM</code> attributes.
		*/
		public static const ATTR:String = "attr";
		
		/**
		* 	The identifier for <code>DOM</code> document fragments.
		*/
		public static const DOCUMENT_FRAGMENT:String = "fragment";
		
		/**
		* 	The identifier for <code>DOM</code> text nodes.
		*/
		public static const TEXT:String = "text";
		
		/**
		* 	The identifier for <code>DOM</code> processing instructions.
		*/
		public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		
		/**
		* 	The identifier for <code>DOM</code> comments.
		*/
		public static const COMMENT:String = "comment";
		
		/**
		* 	The identifier for <code>DOM</code> CDATA sections.
		*/
		public static const CDATA_SECTION:String = "cdata-section";
		
		/**
		* 	The identifier for <code>DOM</code> entities.
		*/
		public static const ENTITY:String = "entity";
		
		/**
		* 	The identifier for <code>DOM</code> entity references.
		*/
		public static const ENTITY_REFERENCE:String = "entity-reference";		
			
		/**
		* 	Creates a <code>DomCoreBeanDocument</code> instance.
		* 
		* 	@param id A specific id to use for this document.
		*/
		public function DomCoreBeanDocument( id:String = null )
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
			//CORE DOM ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				ATTR );
			descriptor.instanceClass = AttrImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				TEXT );
			descriptor.instanceClass = TextImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DOCUMENT_FRAGMENT );
			descriptor.instanceClass = DocumentFragmentImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				PROCESSING_INSTRUCTION );
			descriptor.instanceClass = ProcessingInstructionImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				COMMENT );
			descriptor.instanceClass = CommentImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				CDATA_SECTION );
			descriptor.instanceClass = CDATASectionImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ENTITY );
			descriptor.instanceClass = EntityImpl;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ENTITY_REFERENCE );
			descriptor.instanceClass = EntityReferenceImpl;
			beans.addBeanDescriptor( descriptor );
		}
	}
}