package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
	/**
	*	Encapsulates the resources for a locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.07.2010
	*/
	public class LocaleResources extends Object
		implements ILocaleResources {
		
		private var _messages:IRuntimeResourceCollection;
		private var _errors:IRuntimeResourceCollection;
		private var _fonts:IRuntimeResourceCollection;
		private var _rsls:IRuntimeResourceCollection;
		private var _images:IRuntimeResourceCollection;
		private var _sounds:IRuntimeResourceCollection;
		
		/**
		*	Creates a <code>LocaleResources</code> instance.
		*/
		public function LocaleResources()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get messages():IRuntimeResourceCollection
		{
			return _messages;
		}
		
		public function set messages( value:IRuntimeResourceCollection ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get errors():IRuntimeResourceCollection
		{
			return _errors;
		}
		
		public function set errors( value:IRuntimeResourceCollection ):void
		{
			_errors = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get fonts():IRuntimeResourceCollection
		{
			return _fonts;
		}
		
		public function set fonts( value:IRuntimeResourceCollection ):void
		{
			_fonts = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():IRuntimeResourceCollection
		{
			return _rsls;
		}
		
		public function set rsls( rsls:IRuntimeResourceCollection ):void
		{
			_rsls = rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get images():IRuntimeResourceCollection
		{
			return _images;
		}
		
		public function set images( value:IRuntimeResourceCollection ):void
		{
			_images = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get sounds():IRuntimeResourceCollection
		{
			return _sounds;
		}

		public function set sounds( value:IRuntimeResourceCollection ):void
		{
			_sounds = value;
		}		
	}
}