package com.ffsys.ui.suite.view {
	
	import flash.events.MouseEvent;
	
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
			hbox.spacing = 10;
			hbox.addChild(
				new IconButton() );
				
			hbox.addChild(
				new ForwardButton() );
				
			var btn:ButtonComponent =
				new TextButton( "Simple Text Button" );
			
			hbox.addChild( btn );
			
			btn = new Button( "A GRAPHICAL BUTTON" );
			btn.tooltip = "this is a test with descenders for you";
			hbox.addChild( btn );
			
			addChild( hbox );
		}
	}
}