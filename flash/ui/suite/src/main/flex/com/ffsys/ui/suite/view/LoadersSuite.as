package com.ffsys.ui.suite.view {
	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.loaders.*;
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
	public class LoadersSuite extends AbstractComponentSuiteView {
		
		/**
		*	Creates a <code>LoadersSuite</code> instance.	
		*/
		public function LoadersSuite()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			createHeading( "Loaders Suite (com.ffsys.ui.loaders)" );

			var canvas:Canvas = new Canvas( 100, 100, true );
			
			var loader:ImageLoaderComponent =
				new ImageLoaderComponent( "assets/images/mock/amazon.jpg" );
			loader.border = new BorderGraphic();
			loader.border.stroke.thickness = 5;
			canvas.addChild( loader );
			
			addChild( canvas );
			
			canvas.clipped = false;			
		}
	}
}