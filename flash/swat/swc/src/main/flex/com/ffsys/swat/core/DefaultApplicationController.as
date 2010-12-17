package com.ffsys.swat.core  {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	import com.ffsys.swat.configuration.IPaths;
	
	/**
	*	Abstract super class for application views.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class DefaultApplicationController extends Object
		implements IDefaultApplicationController {

		private var _configuration:IConfiguration;
		
		/**
		*	Creates an <code>DefaultApplicationController</code> instance.
		*/
		public function DefaultApplicationController()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set configuration( configuration:IConfiguration ):void
		{
			_configuration = configuration;
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
			verifyConfiguration();
			return this.configuration.getBean( beanName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			verifyConfiguration();
			return this.configuration.flashvars;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			verifyConfiguration();
			return this.configuration.getFilter( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getMessage.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getError.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			verifyConfiguration();
			return this.configuration.getImage( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			verifyConfiguration();
			return this.configuration.getXmlDocument( id );			
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			verifyConfiguration();
			return this.configuration.stylesheet;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			verifyConfiguration();
			return this.configuration.styleManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			verifyConfiguration();
			return this.configuration.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			verifyConfiguration();
			this.configuration.setStyle( styleName, style );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			verifyConfiguration();
			return this.configuration.getSound( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLocalePath( path:String, locale:IConfigurationLocale = null ):String
		{
			verifyConfiguration();
			if( locale == null )
			{
				locale = configuration.locales.current;
			}
			
			var paths:IPaths = configuration.paths;
			var out:String = paths.join(
				[ paths.getLocalePath( locale ) ], path );
			return out;
		}
		
		/**
		* 	Clean the references stored by this application.
		*/
		public function destroy():void
		{
			_configuration = null;
		}
		
		/**
		*	@private	
		*/
		private function verifyConfiguration():void
		{
			if( this.configuration == null )
			{
				throw new Error(
					"Cannot access configuration data with a null configuration." );
			}
		}
	}
}