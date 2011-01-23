package com.ffsys.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.dom.xhtml.*;
	import com.ffsys.ui.css.*;

	/**
	*	Defines the core beans for <code>DOM</code> based documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class DomBeanDocument extends BeanDocument
	{
		/**
		* 	The default name for <code>DOM</code> bean documents.
		*/
		public static const NAME:String = "dom";
		
		/**
		* 	Creates a <code>DomBeanDocument</code> instance.
		* 
		* 	@param id A specific id to use for this document.
		*/
		public function DomBeanDocument( id:String = null )
		{
			super();
			this.id  = id != null ? id : NAME;
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;
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
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.ATTR );
			descriptor.instanceClass = Attr;
			beans.addBeanDescriptor( descriptor );
			
			//hook in the style manager
			descriptor = new BeanDescriptor( 
				DomIdentifiers.STYLE_MANAGER );
			descriptor.instanceClass = StyleManager;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			//bean manager type injector
			beans.types.push( new BeanTypeInjector(
				DomIdentifiers.STYLE_MANAGER,
				DomIdentifiers.STYLE_MANAGER,
				IStyleManagerAware,
				descriptor ) );
			
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
			
			//COMMON NON-VISUAL ELEMENTS
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEAD );
			descriptor.instanceClass = Head;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.META );
			descriptor.instanceClass = MetaElement;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.TITLE );
			descriptor.instanceClass = TitleElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.LINK );
			descriptor.instanceClass = LinkElement;
			beans.addBeanDescriptor( descriptor );
			
			//COMMON VISUAL ELEMENTS
			descriptor = new BeanDescriptor(
				DomIdentifiers.BODY );
			descriptor.instanceClass = Body;
			beans.addBeanDescriptor( descriptor );
		}
	}
}