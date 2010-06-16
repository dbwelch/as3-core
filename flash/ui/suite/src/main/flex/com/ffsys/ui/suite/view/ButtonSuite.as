package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.text.*;
	import com.ffsys.ui.components.containers.VerticalBox;
	
	import com.ffsys.ui.components.button.*;
	
	/**
	*	Represents a view for the text functionality.
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
		override public function createChildren():void
		{
			vbox = new VerticalBox();
			addChild( vbox );			
			
			createHeading( "Button Suite (com.ffsys.ui.components.button)", vbox );
			
			//vbox.addChild( single );
			//vbox.addChild( constrained );
		}
	}
}