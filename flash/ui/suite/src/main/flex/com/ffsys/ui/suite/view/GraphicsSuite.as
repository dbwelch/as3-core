package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Represents a view for the graphics functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class GraphicsSuite extends AbstractComponentSuiteView {
		
		/**
		*	Creates a <code>GraphicsSuite</code> instance.	
		*/
		public function GraphicsSuite()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			createHeading( "Graphics Suite (com.ffsys.ui.graphics)" );
			
			var hbox:HorizontalBox = null;
			var square:SquareGraphic = null;
			
			hbox = new HorizontalBox();
			square = new SquareGraphic( 10, null, new Fill( 0xa9a9a9, 1 ) );
			hbox.addChild( square );
			
			addChild( hbox );
		}
	}
}