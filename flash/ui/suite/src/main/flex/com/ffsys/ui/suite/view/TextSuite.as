package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.text.*;
	import com.ffsys.ui.containers.VerticalBox;
	
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
		override public function createChildren():void
		{
			vbox = new VerticalBox();
			addChild( vbox );
			
			createHeading( "Text Suite (com.ffsys.ui.text)", vbox );
			
			var single:SingleLineTextField =
				utils.textFieldFactory.single(
					"This is some test text for a single line textfield..." );
					
			var constrained:ConstrainedSingleLineTextField =
				utils.textFieldFactory.constrained(
					"This is some test text for a single line textfield that wraps at 200 pixels..." );
			constrained.maximumWidth = 200;
			
			var multi:MultiLineTextField =
				utils.textFieldFactory.multi(
					"This is some test text for a multi line textfield which wraps at 200 pixels..." );
			multi.width = 200;			
			
			vbox.addChild( single );
			vbox.addChild( constrained );
			vbox.addChild( multi );
		}
	}
}