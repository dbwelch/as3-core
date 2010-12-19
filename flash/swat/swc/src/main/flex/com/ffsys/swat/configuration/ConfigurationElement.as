package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.display.Loader;	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.swat.core.IResourceManager;
	
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	
	/**
	*	Represents the application configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public class ConfigurationElement extends EventDispatcher
		implements IConfigurationElement {
			
		private var _locales:ILocaleManager;
		private var _resources:IResourceManager;
		private var _flashvars:IFlashVariables;
		private var _paths:IPaths;
		
		/**
		*	Create a <code>ConfigurationElement</code> instance.
		*/
		public function ConfigurationElement()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceManager ):void
		{
			_resources = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get locales():ILocaleManager
		{
			return _locales;
		}

		public function set locales( locales:ILocaleManager ):void
		{
			_locales = locales;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}

		public function set flashvars( flashvars:IFlashVariables ):void
		{
			_flashvars = flashvars;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get paths():IPaths
		{
			return _paths;
		}
		
		public function set paths( paths:IPaths ):void
		{
			_paths = paths;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage(
			id:String, ... replacements ):String
		{
			verifyLocales();
			replacements.unshift( id );
			return _locales.getMessage.apply( _locales, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError(
			id:String, ... replacements ):String
		{
			verifyLocales();
			replacements.unshift( id );
			return _locales.getError.apply( _locales, replacements );
		}
		
		/**
		* 	Provides access to stored beans.
		* 
		* 	@param beanName The name of the bean.
		* 
		* 	@return An instance of the bean.
		*/
		public function getBean( beanName:String ):Object
		{
			verifyResources();
			return _resources.getBean( beanName );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			verifyResources();
			return _resources.styleManager;
		}
		
		
		public function set styleManager( value:IStyleManager ):void
		{
			verifyResources();
			_resources.styleManager = value;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			verifyResources();			
			return _resources.stylesheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			verifyResources();			
			return _resources.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle(
			styleName:String, style:Object ):void
		{
			verifyResources();			
			_resources.setStyle( styleName, style );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			verifyResources();			
			return _resources.getFilter( id );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			verifyResources();			
			return _resources.getXmlDocument( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			verifyResources();			
			return _resources.getImage( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			verifyResources();			
			return _resources.getSound( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMovie( id:String ):Loader
		{
			verifyResources();
			return _resources.getMovie( id );
		}		
		
		/**
		* 	Cleans composite references.
		*/
		public function destroy():void
		{
			_locales = null;
			_flashvars = null;
			_paths = null;
			_resources = null;
		}
		
		/**
		* 	@private
		*/
		private function verifyResources():void
		{
			if( _resources == null )
			{
				throw new Error( "Cannot access configuration data with no defined locales." );
			}
		}		
		
		/**
		* 	@private
		*/
		private function verifyLocales():void
		{
			if( _locales == null )
			{
				throw new Error( "Cannot access configuration data with no defined locales." );
			}
		}
	}
}