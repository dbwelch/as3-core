package com.ffsys.swat.as3.view {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import com.ffsys.ui.text.core.*;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.buttons.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.text.*;
	import com.ffsys.ui.runtime.*;
	import com.ffsys.ui.css.*;
	
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
			
		private var _loader:IRuntimeLoader;
		private var _document:IDocument;
		
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
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function createChildren():void
		{
			//update the style manager reference
			UIComponent.styleManager = styleManager;
			
			var substyle:Object = styleManager.getStyle( "sub" );
			
			trace("SwatActionscriptContainer::createChildren()", substyle.substitution );
			
			vbox = new VerticalBox();
			addChild( vbox );
			
			_loader =
				Runtime.load(
					new URLRequest( "view.xml" ),
					vbox,
					{ title: "this is a test" },
					{ another: "another title :)" },
					{ items: [ 1, 2, 3 ] },
					{ locales: utils.configuration.locales.getLocales(), fonts: Font.enumerateFonts() }
				);
			
			_document = _loader.document;
			_loader.addEventListener( LoadEvent.LOAD_COMPLETE, runtimeLoaded );
		}
		
		private function runtimeLoaded( event:LoadEvent ):void
		{
			var btn:Button = Button( _loader.document.getElementById( "btn" ) );
			btn.addEventListener( MouseEvent.CLICK, click );
			trace("SwatActionscriptContainer::runtimeLoaded(), ", btn );
		}
		
		private function click( event:MouseEvent ):void
		{
			trace("SwatActionscriptContainer::click()", Button( event.target ).text );
		}
		
	}
}