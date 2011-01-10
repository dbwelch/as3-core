package com.ffsys.ui.runtime
{
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.controls.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.dom.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.layout.*;
	import com.ffsys.ui.scrollbars.*;
	import com.ffsys.ui.text.*;
	
	import com.ffsys.utils.string.PropertyNameConverter;	

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
			descriptor.instanceClass = DivContainer;
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
			
			descriptor = new BeanDescriptor(
				DomIdentifiers.ANCHOR );
			descriptor.instanceClass = TextButton;
			beans.addBeanDescriptor( descriptor );								
		}
	}
}