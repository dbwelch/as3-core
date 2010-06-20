package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.text.core.*;
	import com.ffsys.ui.containers.HorizontalBox;
	import com.ffsys.ui.containers.VerticalBox;
	
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.text.*;
	
	/**
	*	Represents a view for the buttons.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class ButtonSuite extends AbstractComponentSuiteView {
		
		/**
		*	Creates a <code>ButtonSuite</code> instance.	
		*/
		public function ButtonSuite()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			createHeading( "Button Suite (com.ffsys.ui.button)" );
			
			var hbox:HorizontalBox = null;
			
			hbox = new HorizontalBox();
			hbox.addChild(
				new Label( "TEXT BUTTON: " ) );
			
			hbox.addChild(
				new TextButton( "A Text Button" ) );
			
			addChild( hbox );
		}
	}
}