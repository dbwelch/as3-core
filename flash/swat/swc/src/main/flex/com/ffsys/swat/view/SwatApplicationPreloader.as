package com.ffsys.swat.view {
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.swat.core.SwatFlashVariables;
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	
	/**
	*	The main application preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatApplicationPreloader extends Sprite {
		
		private var _classes:IClassPathConfiguration;
		private var _flashvars:SwatFlashVariables;
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
			_flashvars.classPathConfiguration = classPathConfiguration;
			
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
			classPath:String ):SwatFlashVariables
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
			
			return SwatFlashVariables( instance );
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
			
			//TODO: inform the preload implementation of the created status
			
			if( _view )
			{
				addChild( DisplayObject( _view ) );
				_view.created();
			}
			
		}
		
		/**
		*	@private
		*/
		private function onEnterFrame( event:Event ):void
		{
			var bl:Number = stage.loaderInfo.bytesLoaded;
			var bt:Number = stage.loaderInfo.bytesTotal;
			
			if( bl >= bt )
			{
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				init();
			}
		}
		
		/**
		* 	@private
		*/
		private function getMainClassInstance():IApplication
		{
			var classPath:String = _flashvars.classPathConfiguration.getMainClassPath();
			
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
			
			var instance:Object = new clz( _flashvars );
			
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
			addChild( DisplayObject( app ) );
		}
	}
}