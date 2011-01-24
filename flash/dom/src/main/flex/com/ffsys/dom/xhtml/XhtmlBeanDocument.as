package com.ffsys.dom.xhtml
{
	import com.ffsys.ioc.*;
	import com.ffsys.dom.*;

	/**
	*	Defines the beans for <code>XHTML</code> documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.01.2011
	*/
	public class XhtmlBeanDocument extends DomBeanDocument
	{
		/**
		* 	Creates a <code>XhtmlBeanDocument</code> instance.
		* 
		* 	@param type An identifier that corresponds either
		* 	to the system id of the document type associated
		* 	with this DOM definition.
		*/
		public function XhtmlBeanDocument( systemId:String = null )
		{
			super( systemId );
		}
		
		/**
		* 	Initializes the XHTML beans on the specified document.
		* 
		* 	@param beans The document to initialize with the
		* 	bean definitions.
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			
			//TOOD: change implementations and/or names based on id
			//which indicates the document type
			
			//this.id == DocumentType.systemId -->
			
			var data:Object = null;
			
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.DOCUMENT );
			descriptor.instanceClass = XhtmlDocument;
			beans.addBeanDescriptor( descriptor );	

			descriptor = new BeanDescriptor(
				DomIdentifiers.LI );
			descriptor.instanceClass = ListItemElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.PARAGRAPH );
			descriptor.instanceClass = ParagraphElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.HR );
			descriptor.instanceClass = HorizontalRuleElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.FORM );
			descriptor.instanceClass = FormElement;
			beans.addBeanDescriptor( descriptor );
		}
	}
}