package com.ffsys.utils.flex {
	
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import flash.utils.getDefinitionByName;
	
	/**
	*	Utility functions for working with Flex applications
	*	at runtime.
	*	
	*	This class allows you to determine
	*	whether the current movie has the Flex framework
	*	compiled and allows you to get a reference to the main
	*	Flex Application instance if available.
	*	
	*	In addition, you can get a <code>UIComponent</code>
	*	instance at runtime if the Flex framework is compiled
	*	or a <code>Sprite</code> instance if the Flex framework
	*	is not compiled. This allows us to attach the correct type
	*	of <code>DisplayObjectContainer</code> depending upon
	*	whether we are running as a Flex application or a straight
	*	Actionscipt 3 application.
	*	
	*	This is useful is you need to attach
	*	<code>DisplayObjectContainer</code>
	*	instances but do not want the runtime
	*	errors thrown by Flex if you try to add a non
	*	<code>IUIComponent</code> to the display list
	*	at runtime.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public class FlexUtils extends Object {
		
		/**
		*	Fully qualified class path to the Flex
		*	<code>Application</code>.
		*/
		static public const APPLICATION_CLASS_PATH:String =
			"mx.core::Application";
			
		/**
		*	Fully qualified class path to the Flex
		*	<code>UIComponent</code>.
		*/		
		static public const CORE_COMPONENT_CLASS_PATH:String =
			"mx.core::UIComponent";
		
		/**
		*	Fully qualified class path to the Flex
		*	<code>StyleManager</code>.
		*/	
		static public const STYLE_MANAGER_CLASS_PATH:String =
			"mx.styles::StyleManager";
		
		/**
		*	Constant referring to the Flex <code>rawChildren</code>
		*	property.	
		*/
		static public const RAW_CHILDREN:String = "rawChildren";
		
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded images in a Flex application.	
		*/
		static public const FLEX_IMAGE_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::FlexImageDisplay";
			
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded Flash movies in a Flex application.	
		*/		
		static public const FLEX_MOVIE_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::FlexMovieDisplay";
			
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded videos in a Flex application.
		*/			
		static public const FLEX_VIDEO_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::FlexVideoDisplay";	
			
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded images in an application.	
		*/
		static public const IMAGE_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::ImageDisplay";
			
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded Flash movies in an application.	
		*/		
		static public const MOVIE_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::MovieDisplay";
			
		/**
		*	Fully qualified class path to the <code>Class</code>
		*	used for displaying loaded videos in an application.
		*/			
		static public const VIDEO_DISPLAY_CLASS_PATH:String =
			"com.ffsys.io.loaders.display::VideoDisplay";						
		
		/**
		*	@private	
		*/
		static private var _isFlexApplication:Boolean;
		
		/**
		*	@private	
		*/		
		static private var _flexApplicationClass:Class;
		
		/**
		*	@private	
		*/		
		static private var _flexCoreComponentClass:Class;
		
		/**
		*	@private	
		*/
		public function FlexUtils()
		{
			super();
		}

		/**
		*	Gets the appropriate type of display instance
		*	used to display loaded images depending upon
		*	whether this is a Flex application.
		*	
		*	@return An <code>IDisplayImage</code> implementation.
		*/
		static public function getImageDisplay():Object
		{
			var classReference:Class = null;
			if( isFlexApplication() )
			{
				classReference =
					getDefinitionByName( FLEX_IMAGE_DISPLAY_CLASS_PATH ) as Class;
			}else{
				classReference =
					getDefinitionByName( IMAGE_DISPLAY_CLASS_PATH ) as Class;
			}
			
			return new classReference as Object;
		}
		
		/**
		*	Gets the appropriate type of display instance
		*	used to display loaded Flash movies depending upon
		*	whether this is a Flex application.
		*	
		*	@return An <code>IDisplayMovie</code> implementation.
		*/		
		static public function getMovieDisplay():Object
		{
			var classReference:Class = null;
			if( isFlexApplication() )
			{
				classReference =
					getDefinitionByName( FLEX_MOVIE_DISPLAY_CLASS_PATH ) as Class;
			}else{
				classReference =
					getDefinitionByName( MOVIE_DISPLAY_CLASS_PATH ) as Class;
			}
			
			return new classReference as Object;	
		}		
		
		/**
		*	Gets the appropriate type of display instance
		*	used to display loaded videos depending upon
		*	whether this is a Flex application.
		*	
		*	@return An <code>IDisplayVideo</code> implementation.
		*/
		static public function getVideoDisplay():Object
		{
			var classReference:Class = null;
			if( isFlexApplication() )
			{
				classReference =
					getDefinitionByName( FLEX_VIDEO_DISPLAY_CLASS_PATH ) as Class;
			}else{
				classReference =
					getDefinitionByName( VIDEO_DISPLAY_CLASS_PATH ) as Class;
			}
			
			return new classReference as Object;
		}				
		
		/**
		*	Gets a reference to the Flex style manager.
		*	
		*	@return The Flex style manager or null if this
		*	is not a Flex application.	
		*/
		static public function getStyleManager():Object
		{
			if( isFlexApplication() )
			{
				return getDefinitionByName( STYLE_MANAGER_CLASS_PATH );
			}
			
			return null;
		}		
		
		/**
		*	Gets a display list container based upon whether this
		*	is a Flex application.
		*	
		*	@return A <code>UIComponent</code> instance if this is
		*	a Flex application otherwise a <code>Sprite</code> instance.
		*/
		static public function getContainer():DisplayObjectContainer
		{
			if( !isFlexApplication() )
			{
				return new Sprite() as DisplayObjectContainer;
			}else{
				return getCoreComponent();
			}
		}		
		
		/**
		*	Gets a <code>UIComponent</code> instance if this
		*	is a Flex application.
		*	
		*	@return A <code>UIComponent</code> instance if this
		*	is a Flex application or null otherwise.
		*/
		static public function getCoreComponent():DisplayObjectContainer
		{
			if( isFlexApplication() )
			{
				return DisplayObjectContainer(
					new _flexCoreComponentClass() );
			}
			
			return null;
		}
		
		/**
		*	Gets the root display object for the application.
		*	
		*	Equivalent to the Flex <code>Application.application</code>
		*	property.
		*	
		*	@return The root <code>DisplayObjectContainer</code> for the
		*	application or null if this is not a Flex application.
		*/
		static public function getFlexApplication():DisplayObjectContainer
		{
			if( isFlexApplication() )
			{
				return DisplayObjectContainer(
					_flexApplicationClass.application );
			}
			
			return null;
		}
		
		/**
		*	Determines at runtime whether this is a Flex
		*	application.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	this is a Flex application.	
		*/
		static public function isFlexApplication():Boolean
		{
			return _isFlexApplication;
		}
		
		/**
		*	@private
		*	
		*	Called during the initialization process to
		*	store references to the main Flex components.	
		*/
		static private function getFlexClasses():Boolean
		{
			try {
				_flexApplicationClass =
					getDefinitionByName( APPLICATION_CLASS_PATH ) as Class;
					
				_flexCoreComponentClass =
					getDefinitionByName( CORE_COMPONENT_CLASS_PATH ) as Class;
					
				return ( _flexApplicationClass && _flexApplicationClass.application );
			}catch( e:Error )
			{
				//we need to fail silently in this scenario as
				//non-flex applications will throw a runtime error
				//when we attempt to locate the Flex specific classes
				//using getDefinitionByName()
			}
			
			return false;			
		}
		
		/**
		*	@private	
		*	
		*	Performs the initial routines to determine whether
		*	this application is a Flex application or not.
		*/
		static private function initialize():Boolean
		{
			if( _initialized )
			{
				return false;
			}
			
			_isFlexApplication = getFlexClasses();
			
			return true;
		}
		
		/**
		*	@private
		*	
		*	Performs intialization as soon as <code>FlexUtils</code>
		*	becomes available.
		*/
		static private var _initialized:Boolean = initialize();
	}
}