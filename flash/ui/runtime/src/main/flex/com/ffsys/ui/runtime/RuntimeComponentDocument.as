package com.ffsys.ui.runtime
{
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.controls.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.layout.*;
	import com.ffsys.ui.text.*;

	/**
	*	Defines the default bean components for runtime xml documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.12.2010
	*/
	public class RuntimeComponentDocument extends BeanDocument
	{
		/**
		* 	Creates a <code>RuntimeComponentDocument</code> instance.
		*/
		public function RuntimeComponentDocument()
		{
			super();
			this.locked = false;
			this.policy = BeanCreationPolicy.MERGE;			
			doWithBeans( this );
		}
		
		/**
		* 	Initialies the components beans on the specified document.
		* 
		* 	@param beans The document to initialize with runtime component
		* 	beans.
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				ComponentIdentifiers.DOCUMENT );
			descriptor.instanceClass = Document;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.CANVAS );
			descriptor.instanceClass = Canvas;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.CONTAINER );
			descriptor.instanceClass = Container;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.CELL );
			descriptor.instanceClass = Cell;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.HBOX );
			descriptor.instanceClass = HorizontalBox;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.VBOX );
			descriptor.instanceClass = VerticalBox;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.LIST );
			descriptor.instanceClass = List;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.GRAPHIC );
			descriptor.instanceClass = Graphic;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.FILL );
			descriptor.instanceClass = RuntimeBeanReference;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.STROKE );
			descriptor.instanceClass = RuntimeBeanReference;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.GRADIENT );
			descriptor.instanceClass = Gradient;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TOP_LEFT_CORNER );
			descriptor.instanceClass = Corner;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TOP_RIGHT_CORNER );
			descriptor.instanceClass = Corner;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BOTTOM_LEFT_CORNER );
			descriptor.instanceClass = Corner;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BOTTOM_RIGHT_CORNER );
			descriptor.instanceClass = Corner;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BITMAP_GRAPHIC );
			descriptor.instanceClass = BitmapGraphic;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.LABEL );
			descriptor.instanceClass = Label;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.HEADING );
			descriptor.instanceClass = Heading;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SUB_HEADING );
			descriptor.instanceClass = SubHeading;
			beans.addBeanDescriptor( descriptor );						
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.PARAGRAPH );
			descriptor.instanceClass = Paragraph;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SUB_PARAGRAPH );
			descriptor.instanceClass = SubParagraph;
			beans.addBeanDescriptor( descriptor );						
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BUTTON );
			descriptor.instanceClass = Button;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ICON_BUTTON );
			descriptor.instanceClass = IconButton;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TEXT_BUTTON );
			descriptor.instanceClass = TextButton;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.BOX_MODEL );
			descriptor.instanceClass = BoxModelComponent;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.LAYOUT );
			descriptor.instanceClass = Layout;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.HORIZONTAL_LAYOUT );
			descriptor.instanceClass = HorizontalLayout;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.VERTICAL_LAYOUT );
			descriptor.instanceClass = VerticalLayout;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLLER );
			descriptor.instanceClass = Scroller;
			beans.addBeanDescriptor( descriptor );						
			
			//
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ITERATOR );
			descriptor.instanceClass = RuntimeEachLoop;
			beans.addBeanDescriptor( descriptor );	
		}
	}
}