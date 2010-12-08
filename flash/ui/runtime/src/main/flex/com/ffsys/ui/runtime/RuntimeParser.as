package com.ffsys.ui.runtime {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;
	
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.controls.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.layout.*;
	import com.ffsys.ui.text.*;
	
	/**
	*	Responsible for parsing the runtime view definition document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeParser extends Parser {
		
		/**
		*	The element name for a document.
		*/
		public static const DOCUMENT_NAME:String = "document";
		
		/**
		*	The element name for an each loop.
		*/
		public static const EACH_NODE_NAME:String = "each";
		
		/**
		*	The element name for a container. 
		*/
		public static const CONTAINER_NAME:String = "container";
		
		/**
		*	The element name for a list. 
		*/
		public static const LIST_NAME:String = "list";
		
		/**
		*	Creates a RuntimeParser instance.	
		*/
		public function RuntimeParser()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			this.interpreter = new RuntimeInterpreter();
			
			//this.deserializer.parentField = PARENT_FIELD;
			
			//document
			classNodeNameMap.add(
				Array,
				"css",
				null,
				false );
			
			//containers
			classNodeNameMap.add(
				Canvas,
				"canvas",
				null,
				false );
				
			classNodeNameMap.add(
				Container,
				CONTAINER_NAME,
				null,
				false );
				
			classNodeNameMap.add(
				RuntimeAsset,
				"asset",
				null,
				false );
				
			//TODO: implement
			classNodeNameMap.add(
				RectangleGraphic,
				"background",
				null,
				false );
			
			//TODO: implement	
			classNodeNameMap.add(
				RectangleGraphic,
				"border",
				null,
				false );	
			
			classNodeNameMap.add(
				Scroller,
				"scroller",
				null,
				false );
						
			classNodeNameMap.add(
				Cell,
				"cell",
				null,
				false );
				
			classNodeNameMap.add(
				BoxModelComponent,
				"box-model",
				null,
				false );
				
			classNodeNameMap.add(
				Layout,
				"layout",
				null,
				false );
				
			classNodeNameMap.add(
				HorizontalLayout,
				"horizontal-layout",
				null,
				false );
			
			classNodeNameMap.add(
				VerticalLayout,
				"vertical-layout",
				null,
				false );
				
			classNodeNameMap.add(
				HorizontalBox,
				"hbox",
				null,
				false );			
				
			classNodeNameMap.add(
				VerticalBox,
				"vbox",
				null,
				false );
				
			//graphics
			classNodeNameMap.add(
				Graphic,
				"graphic",
				null,
				false );			
			
			//
			
			/*
			classNodeNameMap.add(
				RectangleGraphic,
				"rect",
				null,
				false );
				
			classNodeNameMap.add(
				SolidFill,
				"fill",
				null,
				false );
				
			classNodeNameMap.add(
				Stroke,
				"stroke",
				null,
				false );				
			//
			*/
			
			//text
			classNodeNameMap.add(
				Label,
				"label",
				null,
				false );
				
			//buttons
			classNodeNameMap.add(
				Button,
				"button",
				null,
				false );
				
			classNodeNameMap.add(
				TextButton,
				"text-button",
				null,
				false );
				
			classNodeNameMap.add(
				RuntimeEachLoop,
				EACH_NODE_NAME,
				null,
				false );
			
			//controls package	
			classNodeNameMap.add(
				List,
				LIST_NAME,
				null,
				false );										
		}
	}
}