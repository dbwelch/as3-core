package com.ffsys.ui.suite.view {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.AbstractSwatView;	
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.containers.*;
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
			/*
			trace("ComponentSuiteContainer::createChildren(), creating initial vertical box: ",
				this, UIComponent.utilities, UIComponent.utilities.layer, UIComponent.utilities.layer.tooltips );
			*/
			
			vbox = new VerticalBox();
			addChild( vbox );
			
			//initialize the tooltips
			UIComponent.utilities.layer.tooltips.delay = 1000;
			UIComponent.utilities.layer.tooltips.renderer = 
				new DefaultToolTipRenderer();
			
			vbox.spacing = 15;
			
			var buttonSuite:ButtonSuite = new ButtonSuite();
			vbox.addChild( buttonSuite );
	
			var containersSuite:ContainersSuite = new ContainersSuite();
			vbox.addChild( containersSuite );
			
			var graphicsSuite:GraphicsSuite = new GraphicsSuite();
			vbox.addChild( graphicsSuite );
			
			var loadersSuite:LoadersSuite = new LoadersSuite();
			vbox.addChild( loadersSuite );
			
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
			
			DisplayObjectContainer( this.root ).addChild( sp );
		}
	}
}