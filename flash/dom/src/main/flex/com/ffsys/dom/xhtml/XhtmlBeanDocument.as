package com.ffsys.dom.xhtml
{
	import com.ffsys.ioc.*;

	import com.ffsys.utils.string.PropertyNameConverter;	
	
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
	public class XhtmlBeanDocument extends BeanDocument
	{
		/**
		* 	The default name for <code>XHTML</code> bean documents.
		*/
		public static const NAME:String = "xhtml";
		
		/**
		* 	Creates a <code>XhtmlBeanDocument</code> instance.
		*/
		public function XhtmlBeanDocument()
		{
			super();
			this.id  = NAME;
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
			
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.DOCUMENT );
			descriptor.instanceClass = XhtmlDocument;
			beans.addBeanDescriptor( descriptor );

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

			descriptor = new BeanDescriptor(
				DomIdentifiers.BODY );
			descriptor.instanceClass = Body;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.DIV );
			descriptor.instanceClass = DivElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.PARAGRAPH );
			descriptor.instanceClass = ParagraphElement;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.ANCHOR );
			descriptor.instanceClass = AnchorElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.UL );
			descriptor.instanceClass = UnorderedListElement;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.OL );
			descriptor.instanceClass = OrderedListElement;
			beans.addBeanDescriptor( descriptor );	

			descriptor = new BeanDescriptor(
				DomIdentifiers.LI );
			descriptor.instanceClass = ListItemElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.STRONG );
			descriptor.instanceClass = StrongElement;
			beans.addBeanDescriptor( descriptor );								
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.EM );
			descriptor.instanceClass = EmElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.SPAN );
			descriptor.instanceClass = SpanElement;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEADING_1 );
			descriptor.instanceClass = HeadingElement;
			descriptor.names.push(
				DomIdentifiers.HEADING_2,
				DomIdentifiers.HEADING_3,
				DomIdentifiers.HEADING_4,
				DomIdentifiers.HEADING_5,
				DomIdentifiers.HEADING_6 );
			beans.addBeanDescriptor( descriptor );
		}
	}
}