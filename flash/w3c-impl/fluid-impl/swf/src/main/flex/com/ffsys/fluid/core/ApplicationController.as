package com.ffsys.fluid.core {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	
	import org.flashx.color.*;
	
	import org.flashx.swat.core.IBootstrapLoader;
	import org.flashx.swat.core.IApplicationMainController;
	import org.flashx.swat.view.IApplication;
	import org.flashx.swat.view.IApplicationPreloader;
	import org.flashx.swat.view.IApplicationPreloadView;
	
	/*
	import org.flashx.ui.buttons.*;	
	import org.flashx.ui.common.*;	
	import org.flashx.ui.containers.*;
	import org.flashx.ui.core.*;
	import org.flashx.ui.css.*;
	import org.flashx.ui.display.*;
	import org.flashx.ui.dom.*;
	import org.flashx.ui.graphics.*;
	import org.flashx.ui.runtime.*;
	import org.flashx.ui.text.*;	
	import org.flashx.ui.tooltips.*;
	*/
	
	/**
	*	The main controller for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.01.2011
	*/
	public class ApplicationController extends AbstractApplicationController
		implements IApplicationMainController {
		
		/**
		*	Creates a <code>ApplicationController</code> instance.
		*/
		public function ApplicationController()
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
			//UIComponent.styleManager = styleManager;
			
			//create the main view
			createMainChildren( DisplayObjectContainer( parent ) );
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
 		private function createMainChildren( root:DisplayObjectContainer ):void
		{	
			trace("ApplicationController::createMainChildren()", root );
		}
	}
}