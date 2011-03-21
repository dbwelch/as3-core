package org.flashx.ui.runtime
{
	import org.flashx.ioc.*;
	
	import org.flashx.ui.buttons.*;
	import org.flashx.ui.common.*;	
	import org.flashx.ui.containers.*;
	import org.flashx.ui.controls.*;
	import org.flashx.ui.core.*;
	import org.flashx.ui.display.*;
	import org.flashx.ui.dom.*;
	import org.flashx.ui.graphics.*;
	import org.flashx.ui.layout.*;
	import org.flashx.ui.scrollbars.*;
	import org.flashx.ui.text.*;
	
	import org.flashx.utils.string.PropertyNameConverter;	

	/**
	*	Defines the default bean components for xhtml documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.01.2011
	*/
	public class XhtmlBeanDocument extends ComponentBeanDocument
	{
		/**
		* 	The default name for xhtml bean documents.
		*/
		public static const NAME:String = "xhtml";
		
		/**
		* 	Creates a <code>XhtmlBeanDocument</code> instance.
		*/
		public function XhtmlBeanDocument()
		{
			super();
			this.id  = NAME;
			trace("::::::::::::::::::::::::::::: XhtmlBeanDocument::init() NEW XHTML BEAN DOCUMENT ::::::::::::::::::::::::::::::::::::");
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			
			var data:Object = null;
			var converter:PropertyNameConverter = new PropertyNameConverter();			
			
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DomIdentifiers.DOCUMENT );
			descriptor.instanceClass = XhtmlDocument;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.HEAD );
			descriptor.instanceClass = HeadElement;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.BODY );
			descriptor.instanceClass = BodyElement;
			beans.addBeanDescriptor( descriptor );
			
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
			
			//overwrite the normal component button descriptor?
			
			/*
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BUTTON );
			descriptor.instanceClass = IconButton;
			beans.addBeanDescriptor( descriptor );
			*/
			
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
		}
	}
}