package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.utils.locale.ILocale;
	
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
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			return null;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			return null;
		}
	}
}