package com.ffsys.fluid.core {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	
	import com.ffsys.color.*;
	
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.IApplicationMainController;
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	/*
	import com.ffsys.ui.buttons.*;	
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.containers.*;
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.display.*;
	import com.ffsys.ui.dom.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.runtime.*;
	import com.ffsys.ui.text.*;	
	import com.ffsys.ui.tooltips.*;
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