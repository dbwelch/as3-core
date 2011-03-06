package com.ffsys.swat.configuration.rsls {
	
	import com.ffsys.swat.configuration.rsls.IResourceCollection;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	*	Encapsulates the resources for a locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.07.2010
	*/
	public class ResourceDefinitionManager extends Object
		implements IResourceDefinitionManager {

		private var _beans:IResourceCollection;
		private var _messages:IResourceCollection;
		private var _errors:IResourceCollection;
		private var _xml:IResourceCollection;
		private var _text:IResourceCollection;
		private var _settings:IResourceCollection;
		private var _fonts:IResourceCollection;
		private var _rsls:IResourceCollection;
		private var _css:IResourceCollection;
		private var _images:IResourceCollection;
		private var _sounds:IResourceCollection;
		private var _components:IResourceCollection;
		
		/**
		*	Creates a <code>ResourceDefinitionManager</code> instance.
		*/
		public function ResourceDefinitionManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get beans():IResourceCollection
		{
			return _beans;
		}

		public function set beans( value:IResourceCollection ):void
		{
			_beans = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get messages():IResourceCollection
		{
			return _messages;
		}
		
		public function set messages( value:IResourceCollection ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get errors():IResourceCollection
		{
			return _errors;
		}
		
		public function set errors( value:IResourceCollection ):void
		{
			_errors = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get xml():IResourceCollection
		{
			return _xml;
		}

		public function set xml( value:IResourceCollection ):void
		{
			_xml = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get text():IResourceCollection
		{
			return _text;
		}

		public function set text( value:IResourceCollection ):void
		{
			_text = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get settings():IResourceCollection
		{
			return _settings;
		}

		public function set settings( value:IResourceCollection ):void
		{
			_settings = value;
		}				
		
		/**
		*	@inheritDoc
		*/
		public function get fonts():IResourceCollection
		{
			return _fonts;
		}
		
		public function set fonts( value:IResourceCollection ):void
		{
			_fonts = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():IResourceCollection
		{
			return _rsls;
		}
		
		public function set rsls( rsls:IResourceCollection ):void
		{
			_rsls = rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get css():IResourceCollection
		{
			return _css;
		}

		public function set css( css:IResourceCollection ):void
		{
			_css = css;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get images():IResourceCollection
		{
			return _images;
		}
		
		public function set images( value:IResourceCollection ):void
		{
			_images = value;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get sounds():IResourceCollection
		{
			return _sounds;
		}

		public function set sounds( value:IResourceCollection ):void
		{
			_sounds = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get components():IResourceCollection
		{
			return _components;
		}

		public function set components( value:IResourceCollection ):void
		{
			_components = value;
		}
	}
}