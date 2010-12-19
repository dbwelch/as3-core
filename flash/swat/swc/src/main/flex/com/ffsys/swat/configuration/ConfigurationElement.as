package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
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
		* 	Provides access to stored beans.
		* 
		* 	@param beanName The name of the bean.
		* 
		* 	@return An instance of the bean.
		*/
		public function getBean( beanName:String ):Object
		{
			if( _locales )
			{
				return _locales.getBean( beanName );
			}
			return null;
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
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			verifyLocales();			
			return _locales.getXmlDocument( id );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			verifyLocales();			
			return _locales.styleManager;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			verifyLocales();			
			return _locales.stylesheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			verifyLocales();			
			return _locales.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle(
			styleName:String, style:Object ):void
		{
			verifyLocales();			
			_locales.setStyle( styleName, style );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			verifyLocales();			
			return _locales.getImage( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			verifyLocales();			
			return _locales.getSound( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			verifyLocales();			
			return _locales.getFilter( id );
		}
		
		/**
		* 	Cleans composite references.
		*/
		public function destroy():void
		{
			_locales = null;
			_flashvars = null;
			_paths = null;
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