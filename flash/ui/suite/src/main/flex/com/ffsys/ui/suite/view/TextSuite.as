package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.text.*;
	
	/**
	*	Represents a view for the text functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextSuite extends AbstractComponentSuiteView {
		
		/**
		*	Creates a <code>TextSuite</code> instance.	
		*/
		public function TextSuite()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			createHeading( "Text Suite (com.ffsys.ui.text)" );
			
			var label:Label = new Label( "This is a test label..." );
			
			addChild( label );
		}
	}
}