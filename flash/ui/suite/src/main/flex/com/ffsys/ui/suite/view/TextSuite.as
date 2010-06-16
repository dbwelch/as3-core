package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.text.*;
	import com.ffsys.ui.components.containers.VerticalBox;
	
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
		
		public var vbox:VerticalBox;
		
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
			
			createHeading( "Text Suite", vbox );
			
			var text:SingleLineTextField =
				textFieldFactory.single(
					"This is some test text for a single line textfield...",
					null, { color: 0xa9a9a9 } );
			
			vbox.addChild( text );
		}
	}
}