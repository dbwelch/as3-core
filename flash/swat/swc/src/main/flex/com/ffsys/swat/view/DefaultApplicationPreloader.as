package com.ffsys.swat.view {
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.BootstrapLoader;
	import com.ffsys.swat.core.DefaultFlashVariables;
	
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	import com.ffsys.swat.events.RslEvent;
	
	/**
	*	The main application preloader.
	*	
	*	This handles loading of the main code base
	*	and then defers to a bootstrap loader
	*	for the remaining resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class DefaultApplicationPreloader extends MovieClip
		implements IApplicationPreloader {
		
		private var _classes:IClassPathConfiguration;
		private var _flashvars:IFlashVariables;
		private var _view:IApplicationPreloadView;
		
		/**
		*	Creates a <code>DefaultApplicationPreloader</code> instance.	
		*/
		public function DefaultApplicationPreloader()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_classes = getClassConfigurationInstance();
			_flashvars = IFlashVariables( _classes.getFlashVariablesInstance( this ) );
			_view = IApplicationPreloadView( _classes.getApplicationPreloadViewInstance() );
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
					RslEvent.PHASE_START, null, event );
				_view.phase( evt );
				
				evt = new RslEvent(
					RslEvent.LOAD_START, null, event );
				evt.uri = LoaderInfo( this.loaderInfo ).loaderURL;
				_view.resource( evt );
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
			_view.resource( evt );
			
			if( bl >= bt )
			{
				evt = new RslEvent(
					RslEvent.LOADED, null, event );
				evt.bytesTotal = bt;
				evt.bytesLoaded = bl;
				evt.uri = LoaderInfo( this.loaderInfo ).loaderURL;
				_view.resource( evt );
				
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				init( event, bl, bt );
			}
		}
		
		/**
		*	@private	
		*/
		private function init( event:Event, bytesLoaded:Number, bytesTotal:Number ):void
		{
			var app:IApplication =
				IApplication( _classes.getMainClassInstance() );
			DefaultFlashVariables(
				_flashvars ).classPathConfiguration = _classes;
			DefaultApplication( app ).setFlashVariables( _flashvars );
			
			var evt:RslEvent = new RslEvent(
				RslEvent.PHASE_COMPLETE, app.preloader, event );
			evt.bytesTotal = bytesTotal;
			evt.bytesLoaded = bytesLoaded;
			_view.complete( evt );
			
			app.preloader.view = _view;
			app.preloader.main = this;
			addChild( DisplayObject( app ) );
		}
	}
}