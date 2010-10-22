package com.ffsys.ui.runtime {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;
	
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
			
			//this.deserializer.parentField = PARENT_FIELD;
			
			classNodeNameMap.add(
				Label,
				"label",
				"label",
				false );
		}
	}
}