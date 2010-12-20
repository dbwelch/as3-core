package com.ffsys.swat.core
{
	import flash.display.Bitmap;
	import flash.display.Loader;	
	import flash.filters.BitmapFilter;	
	import flash.media.Sound;
	
	import com.ffsys.ioc.*;
	import com.ffsys.ui.css.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.utils.properties.IProperties;
	import com.ffsys.utils.properties.Properties;
	import com.ffsys.utils.properties.PrimitiveProperties;		
	
	/**
	*	A resource manager implementation that exposes
	* 	that nested resource lists that correspond to the
	* 	various load phases.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public class ResourceManager extends Object
		implements IResourceManager
	{
		private var _beanManager:IBeanManager;
		private var _styleManager:IStyleManager;
		private var _list:IResourceList;
		private var _messages:IProperties;
		private var _errors:IProperties;
		private var _settings:IProperties;	
		
		/**
		* 	Creates a <code>ResourceManager</code> instance.
		* 
		* 	@param list The resource list being managed.
		* 	@param beanManager The bean manager.
		* 	@param styleManager The style manager.
		*/
		public function ResourceManager(
			list:IResourceList = null,
			beanManager:IBeanManager = null,
			styleManager:IStyleManager = null )
		{
			super();
			this.list = list;
			this.beanManager = beanManager;
			this.styleManager = styleManager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanManager():IBeanManager
		{
			return _beanManager;
		}
		
		public function set beanManager( value:IBeanManager ):void
		{
			_beanManager = value;
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
			if( this.beanManager != null )
			{
				return this.beanManager.getBean( beanName );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get document():IBeanDocument
		{
			if( this.beanManager )
			{
				return this.beanManager.document;
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}

		/**
		*	@inheritDoc	
		*/
		public function get stylesheet():ICssStyleSheet
		{
			if( this.styleManager != null )
			{
				return this.styleManager.stylesheet;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			if( this.styleManager != null )
			{
				return this.styleManager.getStyle( id );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			if( this.styleManager ) 
			{
				this.styleManager.setStyle( styleName, style );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			if( this.styleManager )
			{
				return this.styleManager.getFilter( id );
			}
			return null;
		}					
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			var xml:IResourceList = this.xml;
			var resource:IResource = null;
			if( xml != null )
			{
				resource = xml.getResourceById( id );
				if( resource is XmlResource ) 
				{
					return XmlResource( resource ).xml;
				}
			}
			return null;			
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			var sounds:IResourceList = this.sounds;
			var resource:IResource = null;
			if( sounds != null )
			{
				resource = sounds.getResourceById( id );
				if( resource is SoundResource ) 
				{
					return SoundResource( resource ).sound;
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			var images:IResourceList = this.images;
			var resource:IResource = null;
			if( images != null )
			{
				resource = images.getResourceById( id );
				if( resource is ImageResource ) 
				{
					return ImageResource( resource ).bitmap;
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMovie( id:String ):Loader
		{
			var images:IResourceList = this.rsls;
			var resource:IResource = null;
			if( rsls != null )
			{
				resource = rsls.getResourceById( id );
				if( resource is MovieResource ) 
				{
					return MovieResource( resource ).loader;
				}
			}
			return null;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get list():IResourceList
		{
			return _list;
		}
		
		public function set list( value:IResourceList ):void
		{
			_list = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			if( this.messages != null )
			{
				replacements.unshift( id );
				return this.messages.getProperty.apply( this.messages, replacements ) as String;
			}
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getError( id:String, ... replacements ):String
		{
			if( this.errors != null )
			{
				replacements.unshift( id );
				return this.errors.getProperty.apply( this.errors, replacements ) as String;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getSetting( id:String ):Object
		{
			if( this.settings != null )
			{
				return this.settings.getProperty.apply( this.settings, [ id ] );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get messages():IProperties
		{
			if( _messages == null )
			{
				_messages = new Properties();
			}
			return _messages;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get errors():IProperties
		{
			if( _errors == null )
			{
				_errors = new Properties();
			}			
			return _errors;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get settings():IProperties
		{
			if( _settings == null )
			{
				_settings = new PrimitiveProperties();
			}			
			return _settings;
		}

		/**
		* 	@inheritDoc
		*/
		public function get xml():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.XML_PHASE );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.TEXT_PHASE );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beans():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.BEANS_PHASE );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get css():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.CSS_PHASE );
			}
			return null;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get fonts():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.FONTS_PHASE );
			}
			return null;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get rsls():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.RSLS_PHASE );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get images():IResourceList
		{
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.IMAGES_PHASE );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get sounds():IResourceList
		{	
			if( this.list != null )
			{
				return this.list.getResourceListById(
					ResourceLoadPhase.SOUNDS_PHASE );
			}
			return null;
		}
		
		/**
		* 	Destroys all resources enacpsulated by this
		* 	resource manager and clear composite references.
		*/
		public function destroy():void
		{
			if( _list )
			{
				_list.destroy();
			}
			_list = null;
			//TODO: destroy these composite instances as well
			_beanManager = null;
			_styleManager = null;
			_messages = null;
			_errors = null;
		}
	}
}