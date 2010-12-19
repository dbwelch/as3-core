package com.ffsys.swat.core
{
	import com.ffsys.io.loaders.resources.IResourceList;
	
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
	}
}