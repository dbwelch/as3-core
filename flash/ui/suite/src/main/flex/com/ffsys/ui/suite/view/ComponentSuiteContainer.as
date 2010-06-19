package com.ffsys.ui.suite.view {
	
	import flash.display.Bitmap;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.AbstractSwatView;	
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.components.loaders.*;
	import com.ffsys.ui.graphics.*;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ComponentSuiteContainer extends AbstractSwatView
		implements IApplicationMainView {
			
		public var vbox:VerticalBox;
		
		/**
		*	Creates a <code>ComponentSuiteContainer</code> instance.
		*/
		public function ComponentSuiteContainer()
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
			var preloader:ComponentSuitePreloadView
				= ComponentSuitePreloadView( view );
			
			/*	
			//get a bitmap grab of the preloader view
			var text:MultiLineTextField = preloader.getTextField();
			var bitmap:Bitmap = text.getBitmap();
			addChild( bitmap );
			*/
			
			//remove the preloader view from the display list
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function createChildren():void
		{	
			vbox = new VerticalBox();
			addChild( vbox );
			
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );
			
			var textSuite:TextSuite = new TextSuite();
			vbox.addChild( textSuite );
			
			var buttonSuite:ButtonSuite = new ButtonSuite();
			vbox.addChild( buttonSuite );
			
			var canvas:Canvas = new Canvas( 100, 100, true );
			
			var loader:ImageLoaderComponent =
				new ImageLoaderComponent( "assets/images/mock/amazon.jpg" );
			loader.border = new BorderGraphic();
			loader.border.stroke.thickness = 5;
			canvas.addChild( loader );
			
			vbox.addChild( canvas );
			
			canvas.clipped = false;
			
			//
			trace("ComponentSuiteContainer::createChildren(), ",
				vbox.width, vbox.height, textSuite, buttonSuite, vbox, vbox.numChildren, vbox.parent, vbox.stage );
		}
	}
}