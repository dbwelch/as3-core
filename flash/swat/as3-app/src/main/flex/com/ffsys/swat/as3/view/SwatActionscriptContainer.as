package com.ffsys.swat.as3.view {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
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
			
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function createChildren():void
		{
			vbox = new VerticalBox();
			
			vbox.x = vbox.y = 20;
			
			var graphic:DisplayObject = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "bevel" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "drop-shadow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "color-matrix" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "glow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "gradient-glow" ) ];
			vbox.addChild( graphic );
			
			graphic = new SquareGraphic( 50 );
			IComponentGraphic( graphic ).draw();
			graphic.filters = [ utils.getFilterById( "gradient-bevel" ) ];
			vbox.addChild( graphic );												
			
			addChild( vbox );
		}
	}
}