package com.ffsys.swat.templates.as3.view {
	
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.containers.VerticalBox;
	import com.ffsys.ui.text.Label;
	
	import com.ffsys.ui.runtime.*;
	
	import com.ffsys.ui.css.ICssStyleCollection;
	import com.ffsys.ui.css.ListenerStyleStrategy;
	
	/**
	*	The main view for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ExampleContainer extends ExampleAbstractView
		implements IApplicationMainView {
			
		public var vbox:VerticalBox;
		
		/**
		*	Creates an <code>ExampleContainer</code> instance.
		*/
		public function ExampleContainer()
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
			var preloader:ExampleApplicationPreloadView
				= ExampleApplicationPreloadView( view );
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function createChildren():void
		{
			//update the style manager reference
			UIComponent.styleManager = utils.configuration.locales.styleManager;

			//set up the component tests
			vbox = new VerticalBox();
			//vbox.y = txt.y + txt.textHeight + 12;
			vbox.spacing = 10;
			addChild( vbox );
			
			var loader:IRuntimeLoader =
				Runtime.load( new URLRequest( "assets/common/xml/pages/main.xml" ), vbox );
			loader.addEventListener( LoadEvent.LOAD_COMPLETE, runtimeLoaded );
			
			/*
			trace("ExampleContainer::message(), ",
				utils.getMessage( "common.message" ) );
			
			trace("ExampleContainer::error(), ",
				utils.getError( "general", "warning" ) );
			*/
			
			var lbl:Label = new Label(
				utils.getMessage( "common.message" ) );
			
			/*	
			var fonts:Array = Font.enumerateFonts();
			
			trace("ExampleContainer::createChildren(), ", 
				fonts );
				
			for each( var f:Font in fonts )
			{
				trace("ExampleContainer::createChildren(), ", f, f.fontName );
			}
			*/
		}
		
		private function runtimeLoaded( event:LoadEvent ):void
		{
			trace("ExampleContainer::runtimeLoaded(), ", event );
		}
	}
}