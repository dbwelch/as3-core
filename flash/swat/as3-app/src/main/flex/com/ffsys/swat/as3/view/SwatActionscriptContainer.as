package com.ffsys.swat.as3.view {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.text.Font;
	
	import com.ffsys.ui.text.core.*;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.containers.VerticalBox;
	import com.ffsys.ui.text.Label;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class SwatActionscriptContainer extends SwatActionscriptAbstractView
		implements IApplicationMainView {
			
		public var vbox:VerticalBox;
		
		/**
		*	Creates a <code>SwatActionscriptContainer</code> instance.
		*/
		public function SwatActionscriptContainer()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function ready(
			main:IApplicationPreloader,
			runtime:IRuntimeAssetPreloader,
			view:IApplicationPreloadView ):Boolean
		{
			var preloader:SwatActionscriptApplicationPreloadView
				= SwatActionscriptApplicationPreloadView( view );
				
			/*
			//get a bitmap grab of the preloader view
			var text:MultiLineTextField = preloader.getTextField();
			var bitmap:Bitmap = text.getBitmap();
			addChild( bitmap );
			*/
			
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function createChildren():void
		{
			vbox = new VerticalBox();
			vbox.spacing = 10;
			
			/*
			trace("SwatActionscriptContainer::message(), ",
				utils.getMessage( "common.message" ) );
			
			trace("SwatActionscriptContainer::error(), ",
				utils.getError( "general", "warning" ) );
			*/
			
			var lbl:Label = new Label(
				utils.getMessage( "common.message" ) );
				
			/*
			trace("SwatActionscriptContainer::createChildren(), ", Font.enumerateFonts() );
				
			trace("SwatActionscriptContainer::createChildren(), ",
			 	lbl,
				lbl.text,
				lbl.textfield,
				lbl.textfield.embedFonts,
				lbl.textfield.defaultTextFormat.font,
				lbl.visible,
				lbl.width,
				lbl.height );
			*/
				
			vbox.addChild( lbl );
			
			lbl = new Label( utils.getMessage( "test.message" ) );
			vbox.addChild( lbl );
			
			var fill:IFill = new SolidFill( 0xff0000, 0.5 );
			
			var graphic:DisplayObject = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "bevel" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "drop-shadow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "color-matrix" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "glow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "gradient-glow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50, null, fill );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilter( "gradient-bevel" ) ];
			vbox.addChild( graphic );
			
			addChild( vbox );
			
			/*
			var image:Bitmap = utils.getImage( "garden-001" );
			image.scaleX = image.scaleY = .1;
			addChild( image );
			*/
		}
	}
}