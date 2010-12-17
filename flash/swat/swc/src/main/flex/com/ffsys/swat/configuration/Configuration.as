package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.swat.configuration.locale.LocaleManager;
	import com.ffsys.swat.configuration.rsls.IResourceCollection;
	
	/**
	*	Represents the application configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class Configuration extends ConfigurationElement
		implements IConfiguration {
			
		private var _locales:ILocaleManager;
		private var _meta:ApplicationMeta;
		
		/**
		*	Create a <code>Configuration</code> instance.
		*/
		public function Configuration()
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
		* 	Provides access to stored beans.
		* 
		* 	@param beanName The name of the bean.
		* 
		* 	@return An instance of the bean.
		*/
		override public function getBean( beanName:String ):Object
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
		override public function getMessage(
			id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return _locales.getMessage.apply( _locales, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getError(
			id:String, ... replacements ):String
		{
			replacements.unshift( id );
			return _locales.getError.apply( _locales, replacements );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getXmlDocument( id:String ):XML
		{
			return _locales.getXmlDocument( id );
		}		
		
		/**
		*	@inheritDoc
		*/
		override public function get styleManager():IStyleManager
		{
			return _locales.styleManager;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function get stylesheet():ICssStyleSheet
		{
			return _locales.stylesheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getStyle( id:String ):Object
		{
			return _locales.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function setStyle(
			styleName:String, style:Object ):void
		{
			_locales.setStyle( styleName, style );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getImage( id:String ):Bitmap
		{
			return _locales.getImage( id );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getSound( id:String ):Sound
		{
			return _locales.getSound( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilter( id:String ):BitmapFilter
		{
			return _locales.getFilter( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set meta( val:ApplicationMeta ):void
		{
			_meta = val;
		}
		
		public function get meta():ApplicationMeta
		{
			if( !_meta )
			{
				_meta = new ApplicationMeta();
			}
			
			return _meta;
		}
	}
}