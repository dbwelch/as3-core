package com.ffsys.dom
{
	import com.ffsys.ioc.*;

	import com.ffsys.utils.string.PropertyNameConverter;	

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
		* 	The default name for component bean documents.
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
				DomIdentifiers.BODY );
			descriptor.instanceClass = Body;
			beans.addBeanDescriptor( descriptor );
			
			/*
			descriptor = new BeanDescriptor(
				DomIdentifiers.DIV );
			descriptor.instanceClass = BlockElement;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.PARAGRAPH );
			descriptor.instanceClass = Paragraph;
			beans.addBeanDescriptor( descriptor );

			//TODO: move to a bean name alias implementation
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEADING_1 );
			descriptor.instanceClass = Heading;
			descriptor.names.push(
				DomIdentifiers.HEADING_2,
				DomIdentifiers.HEADING_3,
				DomIdentifiers.HEADING_4,
				DomIdentifiers.HEADING_5,
				DomIdentifiers.HEADING_6 );
			beans.addBeanDescriptor( descriptor );

			//TODO: a custom anchor button
			descriptor = new BeanDescriptor(
				DomIdentifiers.ANCHOR );
			descriptor.instanceClass = TextButton;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.UL );
			descriptor.instanceClass = UnorderedList;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				DomIdentifiers.OL );
			descriptor.instanceClass = OrderedList;
			beans.addBeanDescriptor( descriptor );	

			descriptor = new BeanDescriptor(
				DomIdentifiers.LI );
			descriptor.instanceClass = ListItem;
			beans.addBeanDescriptor( descriptor );
			*/
		}
	}
}