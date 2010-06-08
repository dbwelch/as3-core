package com.ffsys.swat.view {
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.swat.core.SwatFlashVariables;
	
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
		
		private var _flashvars:SwatFlashVariables;
		
		/**
		*	Creates an <code>SwatApplicationPreloader</code> instance.	
		*/
		public function SwatApplicationPreloader()
		{
			super();
			
			//TODO: make the flash variables configurable
			_flashvars = getFlashVariablesClassInstance();
			
			addEventListener( Event.ADDED_TO_STAGE, created );
		}
		
		private function getFlashVariablesClassPath():String
		{
			var classPath:String = "com.ffsys.swat.core.SwatFlashVariables";
			var parameters:Object;

			try {
				parameters = LoaderInfo( this.loaderInfo ).parameters;
				
				if( parameters.vars )
				{
					classPath = parameters.vars;
				}
			}catch( e:Error )
			{
				//fail silently
			}
			
			return classPath;
		}
		
		private function getFlashVariablesClassInstance():SwatFlashVariables
		{
			var classPath:String = getFlashVariablesClassPath();
			
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
		
		/**
		*	@private
		*/
		private function created( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, created );
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			//TODO: inform the preload implementation of the created status
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
			if( _flashvars.main == null )
			{
				throw new Error( "No main class has been specified." );
			}
			
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( _flashvars.main ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate main application class with class path '"
					+ _flashvars.main + "'" );
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
			//app.createChildren();
		}
	}
}