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
			
			var stroke:IStroke = new Stroke( 3, 0xff0000, 1 );
			var fill:IFill = new Fill(
				new SolidFill( 0xff0000, 0.5 ) );
			
			hbox = new HorizontalBox();
			hbox.spacing = 5;
			
			var width:Number = 25;
			var height:Number = 25;
			
			graphic = new SquareGraphic(
				width,
				stroke );
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height / 2,
				stroke );
			hbox.addChild( DisplayObject( graphic ) );			

			graphic = new CircleGraphic(
				width,
				stroke );
			hbox.addChild( DisplayObject( graphic ) );

			graphic = new EllipseGraphic(
				width,
				height / 2,
				stroke );
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new SquareGraphic(
				width,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height / 2,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );	

			graphic = new CircleGraphic(
				width,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );

			graphic = new EllipseGraphic(
				width,
				height / 2,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );			
						
			addChild( hbox );
		}
	}
}