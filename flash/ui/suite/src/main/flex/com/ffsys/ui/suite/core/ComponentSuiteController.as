package com.ffsys.ui.suite.core {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
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
	
	import com.ffsys.ui.suite.view.*;
	
	/**
	*	The main controller for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ComponentSuiteController extends AbstractApplicationController
		implements IApplicationMainController {
			
		public var vbox:VerticalBox;
		
		/**
		*	Creates a <code>ComponentSuiteController</code> instance.
		*/
		public function ComponentSuiteController()
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
			UIComponent.styleManager = styleManager;
			
			//create the main view
			createMainChildren( DisplayObjectContainer( parent ) );
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
 		private function createMainChildren( root:DisplayObjectContainer ):void
		{	
			/*
			trace("ComponentSuiteController::createChildren(), creating initial vertical box: ",
				this, UIComponent.utilities, UIComponent.utilities.layer, UIComponent.utilities.layer.tooltips );
			*/
			
			vbox = new VerticalBox();
			vbox.spacing = 15;			
			root.addChild( vbox );
			
			//initialize the tooltips
			var tooltip:DefaultToolTipRenderer = new DefaultToolTipRenderer()
			tooltip.maximumTextWidth = 200;
			
			//UIComponent.utilities.layer.tooltips.delay = 1000;
			UIComponent.utilities.layer.tooltips.renderer = tooltip;			
			
			var view:DisplayObject = getView( "graphics" );
			trace("ComponentSuiteController::createMainChildren()", "GOT VIEW: ", view );
			
			if( view != null )
			{
				vbox.addChild( view );
			}
			
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );		
			graphicsSuite.y += 350;
			
			/*
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
			*/
		}
	}
}