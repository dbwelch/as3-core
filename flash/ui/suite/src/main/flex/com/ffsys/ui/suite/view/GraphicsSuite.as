package com.ffsys.ui.suite.view {
	
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.GradientType;
	
	import com.ffsys.ui.common.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.display.*;
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
			
			var width:Number = 32;
			var height:Number = 32;			
			
			var hbox:HorizontalBox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			var stroke:IStroke = new Stroke( 0, 0xff0000, 1 );
			var fill:IFill = new SolidFill( 0xff0000, 0.5 );
			
			var gradient:IGradientFill = 
				new GradientFill(
					new Gradient(
						GradientType.LINEAR, [ 0xff0000, 0x000000 ] ) );
			
			//stroke but no fill
			layoutGraphics( hbox, width, height, stroke, null );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			//stroke and fill
			layoutGraphics( hbox, width, height, stroke, fill );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			//fill but no stroke
			layoutGraphics( hbox, width, height, null, fill );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );			
			
			//gradient fill test
			layoutGraphics( hbox, width, height, null, gradient );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			//test for bitmap and composite
			var bmp:Bitmap = new RuntimeAsset(
				"com.ffsys.ui.images.DefaultTile" ).getBitmap();
			
			var bitmap:IBitmapFill = new BitmapFill( bmp.bitmapData );
			
			var composite:ICompositeFill = new CompositeFill( 
				new SolidFill( 0x626262, 1 ) );
			
			//composite - solid color only
			layoutGraphics( hbox, width, height, null, composite );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );			
			
			composite.gradient = new GradientFill(
				new Gradient(
					GradientType.LINEAR,
					[ 0x4e4e4e, 0x1a1a1a ],
					[ 0, .75 ] ) );
			
			//composite solid fill and gradient
			layoutGraphics( hbox, width, height, null, composite );
			
			composite.bitmap = bitmap;
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );
			
			//composite all default layers
			layoutGraphics( hbox, width, height, null, composite );
			
			hbox = new HorizontalBox();
			hbox.spacing = 10;
			addChild( hbox );			
			
			//custom composite layers - adds an extra top gradient
			composite.gradient.gradient.colors.reverse();
			composite.composites = [
				composite.solid,
				composite.gradient,
				composite.bitmap,
				composite.gradient ];
			
			layoutGraphics( hbox, width, height, null, composite );
		}
		
		private function layoutGraphics(
			hbox:HorizontalBox,
			width:Number,
			height:Number,
			stroke:IStroke,
			fill:IFill ):void
		{
			var graphic:IComponentGraphic = null;
			var cell:Cell = null;
			
			graphic = new SquareGraphic(
				width,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );
			
			var pointer:IPointer = null;
			
			graphic = new RectangleGraphic(
				width,
				height,
				stroke,
				fill );
			pointer = new ArrowPointer();
			RectangleGraphic( graphic ).pointer = pointer;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height,
				stroke,
				fill );
			pointer = new ArrowPointer();
			pointer.edge = Orientation.TOP;
			RectangleGraphic( graphic ).pointer = pointer;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height,
				stroke,
				fill );
			pointer = new ArrowPointer();
			pointer.edge = Orientation.LEFT;
			RectangleGraphic( graphic ).pointer = pointer;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height,
				stroke,
				fill );
			pointer = new ArrowPointer();
			pointer.edge = Orientation.RIGHT;
			RectangleGraphic( graphic ).pointer = pointer;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new RectangleGraphic(
				width,
				height,
				stroke,
				fill );
			pointer = new ArrowPointer();
			pointer.inside = false;
			RectangleGraphic( graphic ).pointer = pointer;
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
			cell = new Cell( width, height, new Graphic( graphic ) );
			hbox.addChild( cell );			
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.LEFT;
			hbox.addChild( DisplayObject( graphic ) );	
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.TOP;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.BOTTOM;
			hbox.addChild( DisplayObject( graphic ) );
			
			
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.TOP_LEFT;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.TOP_RIGHT;
			hbox.addChild( DisplayObject( graphic ) );	
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.BOTTOM_RIGHT;
			hbox.addChild( DisplayObject( graphic ) );
			
			graphic = new ArrowGraphic(
				width / 2,
				height / 2,
				stroke,
				fill );
			ArrowGraphic( graphic ).orientation = Orientation.BOTTOM_LEFT;
			hbox.addChild( DisplayObject( graphic ) );							
			
			var cornerAware:CornerAwareRectangleGraphic = null;
			
			//straight bevel
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				4,
				4 );
			hbox.addChild( DisplayObject( graphic ) );
			
			//top left only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 0 );
			
			hbox.addChild( DisplayObject( graphic ) );
			
			//top right only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 1 );
			
			hbox.addChild( DisplayObject( graphic ) );
			
			//bottom right only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 2 );
			
			hbox.addChild( DisplayObject( graphic ) );
			
			//bottom left only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 3 );									
				
			hbox.addChild( DisplayObject( graphic ) );			
			
			//top corners only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.corners[ 2 ].reset();									
			cornerAware.corners[ 3 ].reset();
			
			hbox.addChild( DisplayObject( graphic ) );	
			
			//bottom corners only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.corners[ 0 ].reset();					
			cornerAware.corners[ 1 ].reset();
			
			hbox.addChild( DisplayObject( graphic ) );	
			
			//opposite corners only
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				6,
				6 );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.corners[ 1 ].reset();					
			cornerAware.corners[ 3 ].reset();
				
			hbox.addChild( DisplayObject( graphic ) );			
			
			//make a bevel appear as a diamond shape
			graphic = new BevelRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				width / 2,
				height / 2 );
			hbox.addChild( DisplayObject( graphic ) );
			
			//normal rounded rectangle
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				4,
				4 );
				
			hbox.addChild( DisplayObject( graphic ) );			
			
			//top left only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 0 );
			hbox.addChild( DisplayObject( graphic ) );
			
			//top right only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 1 );
			hbox.addChild( DisplayObject( graphic ) );
			
			//bottom right only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 2 );
			hbox.addChild( DisplayObject( graphic ) );						
			
			//bottom left only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.solo( 3 );
			hbox.addChild( DisplayObject( graphic ) );
			
			//top corners only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.corners[ 2 ].reset();									
			cornerAware.corners[ 3 ].reset();
			hbox.addChild( DisplayObject( graphic ) );
			
			//opposite corners only
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill );
				
			cornerAware = CornerAwareRectangleGraphic( graphic );
			cornerAware.corners[ 1 ].reset();					
			cornerAware.corners[ 3 ].reset();
			hbox.addChild( DisplayObject( graphic ) );	
			
			//make nearly circular
			graphic = new RoundedRectangleGraphic(
				width,
				height,
				stroke,
				fill,
				width * 0.5,
				height * 0.5 );
			hbox.addChild( DisplayObject( graphic ) );					
		}
	}
}