package com.ffsys.swat.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	
	import com.ffsys.io.loaders.resources.*;
	
	/**
	*	A resource manager implementation that exposes
	* 	that nested resource lists that correspond to the
	* 	various load phases as public properties.
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
		private var _list:IResourceList;

		private var _settings:IResourceList;
		private var _xml:IResourceList;
		private var _text:IResourceList;
		private var _rsls:IResourceList;
		private var _images:IResourceList;
		private var _sounds:IResourceList;
		
		/**
		* 	Creates a <code>ResourceManager</code> instance.
		* 
		* 	@param list The resource list being managed.
		*/
		public function ResourceManager( list:IResourceList = null )
		{
			super();
			this.list = list;
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
		* 	@inheritDoc
		*/
		public function get settings():IResourceList
		{
			if( _settings == null && ( this.list != null ) )
			{
				_settings = this.list.getResourceListById(
					ResourceLoadPhase.SETTINGS_PHASE );
			}
			return _settings;
		}		

		/**
		* 	@inheritDoc
		*/
		public function get xml():IResourceList
		{
			if( _xml == null && ( this.list != null ) )
			{
				_xml = this.list.getResourceListById(
					ResourceLoadPhase.XML_PHASE );
			}
			return _xml;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():IResourceList
		{
			if( _text == null && ( this.list != null ) )
			{
				_text = this.list.getResourceListById(
					ResourceLoadPhase.TEXT_PHASE );
			}
			return _text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get rsls():IResourceList
		{
			if( _rsls == null && ( this.list != null ) )
			{
				_rsls = this.list.getResourceListById(
					ResourceLoadPhase.RSLS_PHASE );
			}
			return _rsls;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get images():IResourceList
		{
			if( _images == null && ( this.list != null ) )
			{
				_images = this.list.getResourceListById(
					ResourceLoadPhase.IMAGES_PHASE );
			}
			return _images;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get sounds():IResourceList
		{	
			if( _sounds == null && ( this.list != null ) )
			{
				_sounds = this.list.getResourceListById(
					ResourceLoadPhase.SOUNDS_PHASE );
			}
			return _sounds;
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
			_settings = null;
			_xml = null;
			_text = null;
			_rsls = null;
			_images = null;
			_sounds = null;
		}
	}
}