package com.ffsys.ui.runtime {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;
	
	import com.ffsys.ui.containers.*;
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
			
			//text
			classNodeNameMap.add(
				Label,
				"label",
				null,
				false );
		}
	}
}