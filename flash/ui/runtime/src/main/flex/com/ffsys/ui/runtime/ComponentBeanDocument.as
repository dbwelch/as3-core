package com.ffsys.ui.runtime
{
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.common.ComponentIdentifiers;
	import com.ffsys.utils.string.PropertyNameConverter;
	
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.controls.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.layout.*;
	import com.ffsys.ui.scrollbars.*;
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
	public class ComponentBeanDocument extends BeanDocument
	{
		/**
		* 	Creates a <code>ComponentBeanDocument</code> instance.
		*/
		public function ComponentBeanDocument()
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
			var data:Object = null;
			var converter:PropertyNameConverter = new PropertyNameConverter();
			
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
				ComponentIdentifiers.LINKS );
			descriptor.instanceClass = LinkContainer;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TABS );
			descriptor.instanceClass = TabContainer;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.GRAPHIC );
			descriptor.instanceClass = Graphic;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.FILL );
			descriptor.instanceClass = RuntimeStyleReference;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.STROKE );
			descriptor.instanceClass = RuntimeStyleReference;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.RUNTIME_ASSET );
			descriptor.instanceClass = RuntimeAsset;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ASSET );
			descriptor.instanceClass = RuntimeStyleReference;
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
				ComponentIdentifiers.LABEL );
			descriptor.instanceClass = Label;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TEXT_INPUT );
			descriptor.instanceClass = TextInput;
			beans.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TEXT_AREA );
			descriptor.instanceClass = TextArea;
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
				ComponentIdentifiers.GRAPHIC_BUTTON );
			descriptor.instanceClass = GraphicButton;
			beans.addBeanDescriptor( descriptor );			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TOGGLE_BUTTON );
			descriptor.instanceClass = ToggleButton;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.RADIO_BUTTON );
			descriptor.instanceClass = RadioButton;
			beans.addBeanDescriptor( descriptor );						
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.CHECK_BOX );
			descriptor.instanceClass = CheckBox;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ICON_BUTTON );
			descriptor.instanceClass = IconButton;
			beans.addBeanDescriptor( descriptor );	
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ICON_TEXT_BUTTON );
			descriptor.instanceClass = IconTextButton;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TEXT_BUTTON );
			descriptor.instanceClass = TextButton;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.LINK_BUTTON );
			descriptor.instanceClass = LinkButton;
			beans.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TAB_BUTTON );
			descriptor.instanceClass = TabButton;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.GROUP_MANAGER );
			descriptor.instanceClass = RuntimeDocumentReference;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.TARGET );
			descriptor.instanceClass = RuntimeDocumentReference;
			beans.addBeanDescriptor( descriptor );			
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.RADIO_BUTTON_GROUP );
			descriptor.instanceClass = RadioButtonGroup;
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
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_TRACK );
			descriptor.instanceClass = ScrollTrack;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_DRAG );
			descriptor.instanceClass = ScrollDrag;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_UP_BUTTON );
			descriptor.instanceClass = ScrollUpButton;
			beans.addBeanDescriptor( descriptor );									
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_DOWN_BUTTON );
			descriptor.instanceClass = ScrollDownButton;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_LEFT_BUTTON );
			descriptor.instanceClass = ScrollLeftButton;
			beans.addBeanDescriptor( descriptor );									
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.SCROLL_RIGHT_BUTTON );
			descriptor.instanceClass = ScrollRightButton;
			beans.addBeanDescriptor( descriptor );			
			
			data = new Object();
			data.scrollTrack = new BeanReference(
				ComponentIdentifiers.HSCROLL,
				converter.convert( ComponentIdentifiers.SCROLL_TRACK ),
				ComponentIdentifiers.SCROLL_TRACK );
			data.scrollDrag = new BeanReference(
				ComponentIdentifiers.HSCROLL,
				converter.convert( ComponentIdentifiers.SCROLL_DRAG ),
				ComponentIdentifiers.SCROLL_DRAG );
				
			/*
			data.negativeScrollButton = new BeanReference(
				ComponentIdentifiers.HSCROLL,
				null,
				ComponentIdentifiers.SCROLL_LEFT_BUTTON );	
			data.positiveScrollButton = new BeanReference(
				ComponentIdentifiers.HSCROLL,
				null,
				ComponentIdentifiers.SCROLL_RIGHT_BUTTON );							
			*/
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.HSCROLL, data );
			descriptor.instanceClass = HorizontalScrollBar;
			beans.addBeanDescriptor( descriptor );
			
			data = new Object();
			data.scrollTrack = new BeanReference(
				ComponentIdentifiers.VSCROLL,
				converter.convert( ComponentIdentifiers.SCROLL_TRACK ),
				ComponentIdentifiers.SCROLL_TRACK );
			data.scrollDrag = new BeanReference(
				ComponentIdentifiers.VSCROLL,
				converter.convert( ComponentIdentifiers.SCROLL_DRAG ),
				ComponentIdentifiers.SCROLL_DRAG );
				
			/*
			data.negativeScrollButton = new BeanReference(
				ComponentIdentifiers.VSCROLL,
				null,
				ComponentIdentifiers.SCROLL_DOWN_BUTTON );
			data.positiveScrollButton = new BeanReference(
				ComponentIdentifiers.VSCROLL,
				null,
				ComponentIdentifiers.SCROLL_UP_BUTTON );					
			*/
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.VSCROLL, data );
			descriptor.instanceClass = VerticalScrollBar;
			beans.addBeanDescriptor( descriptor );

			descriptor = new BeanDescriptor(
				ComponentIdentifiers.CUSTOM_DATA );
			descriptor.instanceClass = Object;
			beans.addBeanDescriptor( descriptor );			

			descriptor = new BeanDescriptor(
				ComponentIdentifiers.IMAGE_DISPLAY );
			descriptor.instanceClass = ImageDisplay;
			beans.addBeanDescriptor( descriptor );							
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.IMAGE_CONTAINER );
			descriptor.instanceClass = ImageContainer;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.MASK );
			descriptor.instanceClass = MaskComponent;
			beans.addBeanDescriptor( descriptor );
			
			//
			descriptor = new BeanDescriptor(
				ComponentIdentifiers.ITERATOR );
			descriptor.instanceClass = RuntimeEachLoop;
			beans.addBeanDescriptor( descriptor );	
		}
	}
}