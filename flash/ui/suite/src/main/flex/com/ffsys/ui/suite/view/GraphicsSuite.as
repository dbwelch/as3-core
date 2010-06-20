package com.ffsys.ui.suite.view {
	
	import flash.display.DisplayObject;
	
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
			var graphic:IComponentGraphic = null;
			
			hbox = new HorizontalBox();
			hbox.spacing = 5;
			
			//
			graphic = new SquareGraphic(
				10,
				new Stroke( 1, 0xff0000, 1 ) );
			hbox.addChild( DisplayObject( graphic ) );
			
			//
			graphic = new CircleGraphic(
				10,
				new Stroke( 1, 0xff0000, 1 ) );
			hbox.addChild( DisplayObject( graphic ) );
			
			//
			graphic = new EllipseGraphic(
				10,
				5,
				new Stroke( 1, 0xff0000, 1 ) );
			hbox.addChild( DisplayObject( graphic ) );			
						
			addChild( hbox );
		}
	}
}