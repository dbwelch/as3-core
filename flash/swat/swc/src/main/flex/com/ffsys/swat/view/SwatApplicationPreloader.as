package com.ffsys.swat.view {
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.core.RuntimeAssetPreloader;
	import com.ffsys.swat.core.SwatFlashVariables;
	
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	import com.ffsys.swat.events.RslEvent;
	
	/**
	*	The main application preloader.
	*	
	*	This handles loading of the main code base
	*	and then differs to the runtime asset preloader
	*	for the remaining assets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatApplicationPreloader extends Sprite
		implements IApplicationPreloader {
		
		private var _classes:IClassPathConfiguration;
		private var _flashvars:IFlashVariables;
		private var _view:IApplicationPreloadView;
		
		/**
		*	Creates an <code>SwatApplicationPreloader</code> instance.	
		*/
		public function SwatApplicationPreloader()
		{
			super();
			_classes = getClassConfigurationInstance();
			_flashvars = _classes.getFlashVariablesClassInstance( this );
			_view = _classes.getApplicationPreloadViewInstance();
			addEventListener( Event.ADDED_TO_STAGE, created );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get classes():IClassPathConfiguration
		{
			return _classes;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRuntimeClasses():Array
		{
			return new Array();
		}		
		
		/**
		* 	@private
		*/
		private function getClassConfigurationInstance():IClassPathConfiguration
		{
			var classPath:String = null;
			var parameters:Object;

			try {
				parameters = LoaderInfo( this.loaderInfo ).parameters;
				
				if( parameters.classes )
				{
					classPath = parameters.classes;
				}
			}catch( e:Error )
			{
				//
			}
			
 			if( classPath == null )
			{
				throw new Error(
					"The flash variable 'classes' containing"
					+ " the qualified path to the class path configuration was not specified." );
			}
			
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate class path configuration class with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			
			if( !( instance is IClassPathConfiguration ) )
			{
				throw new Error( "The class path configuration class does"
				+ " not adhere to the class path contract." );
			}
			
			return IClassPathConfiguration( instance );
		}
		
		/**
		*	@private
		*/
		private function created( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, created );
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			var evt:RslEvent = null;

			if( _view )
			{
				addChild( DisplayObject( _view ) );
				_view.created();
				
				evt = new RslEvent(
					RslEvent.LOAD_START, null, event );
				evt.uri = LoaderInfo( this.loaderInfo ).loaderURL;
				_view.code( evt );
			}
		}
		
		/**
		*	@private
		*/
		private function onEnterFrame( event:Event ):void
		{
			var evt:RslEvent = null;
			
			var bl:Number = stage.loaderInfo.bytesLoaded;
			var bt:Number = stage.loaderInfo.bytesTotal;
			
			evt = new RslEvent(
				RslEvent.LOAD_PROGRESS, null, event );
			evt.bytesTotal = bt;
			evt.bytesLoaded = bl;
			evt.uri = LoaderInfo( this.loaderInfo ).loaderURL;
			_view.code( evt );
			
			if( bl >= bt )
			{
				evt = new RslEvent(
					RslEvent.LOADED, null, event );
				evt.bytesTotal = bt;
				evt.bytesLoaded = bl;
				evt.uri = LoaderInfo( this.loaderInfo ).loaderURL;
				_view.code( evt );
				
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				init();
			}
		}
		
		/**
		*	@private	
		*/
		private function init():void
		{
			var app:IApplication =
				_classes.getMainClassInstance();
			app.flashvars = _flashvars;
			app.preloader.view = _view;
			app.preloader.main = this;
			addChild( DisplayObject( app ) );
		}
	}
}