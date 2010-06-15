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
	public class SwatApplicationPreloader extends Sprite {
		
		private var _classes:IClassPathConfiguration;
		private var _flashvars:IFlashVariables;
		private var _view:IApplicationPreloadView;
		
		/**
		*	Creates an <code>SwatApplicationPreloader</code> instance.	
		*/
		public function SwatApplicationPreloader()
		{
			super();
			
			var classPathConfiguration:IClassPathConfiguration
				= getClassConfigurationInstance();
				
			_flashvars = getFlashVariablesClassInstance(
				classPathConfiguration.getFlashVariablesClassPath() );
			SwatFlashVariables( _flashvars ).classPathConfiguration = classPathConfiguration;
			
			_view = getApplicationPreloadViewInstance(
				classPathConfiguration.getPreloadViewClassPath() );
			
			addEventListener( Event.ADDED_TO_STAGE, created );
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
				//fail silently
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
				throw new Error( "The class path configuration class does not adhere to the class path contract." );
			}
			
			return IClassPathConfiguration( instance );
		}
		
		private function getFlashVariablesClassInstance(
			classPath:String ):IFlashVariables
		{
			
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate flash variables application class with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz( this );
			
			if( !( instance is SwatFlashVariables ) )
			{
				throw new Error( "The flash variables class does not adhere to the flash variables contract." );
			}
			
			return IFlashVariables( instance );
		}
		
		private function getApplicationPreloadViewInstance(
			classPath:String ):IApplicationPreloadView
		{
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate application preload view class with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			
			if( !( instance is IApplicationPreloadView ) )
			{
				throw new Error(
					"The application preload view class does not adhere to the application preload contract." );
			}
			
			return IApplicationPreloadView( instance );
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
		* 	@private
		*/
		private function getMainClassInstance():IApplication
		{
			var classPath:String = SwatFlashVariables(
				_flashvars ).classPathConfiguration.getMainClassPath();
			
			if( classPath == null )
			{
				throw new Error( "No main class has been specified." );
			}
			
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate main application class with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			
			if( !( instance is IApplication ) )
			{
				throw new Error( "The main class does not adhere to the application contract." );
			}
			
			return IApplication( instance );
		}
		
		/**
		*	@private	
		*/
		private function init():void
		{
			var app:IApplication =
				getMainClassInstance();
			app.flashvars = _flashvars;
			app.preloader.view = _view;
			addChild( DisplayObject( app ) );
		}
	}
}