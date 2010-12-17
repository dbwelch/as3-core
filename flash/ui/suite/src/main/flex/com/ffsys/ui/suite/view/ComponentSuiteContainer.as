package com.ffsys.ui.suite.view {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.IApplicationMainController;
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.tooltips.*;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ComponentSuiteContainer extends Container
		implements IApplicationMainController {
			
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
			parent:IApplication,
			main:IApplicationPreloader,
			runtime:IBootstrapLoader,
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
			
			createMainChildren( DisplayObjectContainer( parent ) );
			
			//remove the preloader view from the display list
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
 		private function createMainChildren( root:DisplayObjectContainer ):void
		{	
			/*
			trace("ComponentSuiteContainer::createChildren(), creating initial vertical box: ",
				this, UIComponent.utilities, UIComponent.utilities.layer, UIComponent.utilities.layer.tooltips );
			*/
			
			vbox = new VerticalBox();
			root.addChild( vbox );
			
			//initialize the tooltips
			var tooltip:DefaultToolTipRenderer = new DefaultToolTipRenderer()
			tooltip.maximumTextWidth = 200;
			
			//UIComponent.utilities.layer.tooltips.delay = 1000;
			UIComponent.utilities.layer.tooltips.renderer = tooltip;
			
			vbox.spacing = 15;
			
			var loadersSuite:LoadersSuite = new LoadersSuite();
			vbox.addChild( loadersSuite );
			
			var buttonSuite:ButtonSuite = new ButtonSuite();
			vbox.addChild( buttonSuite );
	
			var containersSuite:ContainersSuite = new ContainersSuite();
			vbox.addChild( containersSuite );
			
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );
			
			var textSuite:TextSuite = new TextSuite();
			vbox.addChild( textSuite );
			
			//test adding a new sibling - to check the root layer
			//swaps itself to the top depth
			var sp:Sprite = new Sprite();
			
			/*
			sp.graphics.beginFill( 0xff0000, 1 );
			sp.graphics.drawRect( 0, 0, 100, 100 );
			sp.graphics.endFill();
			*/
			
			//DisplayObjectContainer( this.root ).addChild( sp );
		}
	}
}