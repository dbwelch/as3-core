package com.ffsys.swat.as3.view {
	
	import flash.display.Bitmap;
	import com.ffsys.ui.text.*;
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.IApplicationMainView;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
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
			view:IApplicationPreloadView ):void
		{
			var preloader:SwatActionscriptApplicationPreloadView
				= SwatActionscriptApplicationPreloadView( view );
				
			//get a bitmap grab of the preloader view
			var text:MultiLineTextField = preloader.getTextField();
			var bitmap:Bitmap = text.getBitmap();
			addChild( bitmap );
			
			//remove the preloader view from the display list
			runtime.view = null;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function createChildren():void
		{
			var factory:TextFieldFactory = new TextFieldFactory();
			var text:SingleLineTextField =
				factory.single( "THIS IS SOME TEXT", null, { color: 0xff0000 } );
				
			addChild( text );
			
			//
			trace("SwatActionscriptContainer::createChildren(), ", configuration );
		}
	}
}