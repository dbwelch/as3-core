package com.ffsys.swat.mock
{
	import com.ffsys.swat.core.*;
	import com.ffsys.swat.configuration.locale.ILocaleManager;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.utils.properties.IProperties;

	public class MockApplicationController extends DefaultApplicationController
		implements 	ILocalesAware,
					IMessagesAware
	{
		private var _rectangle:RectangleGraphic;
		private var _locales:ILocaleManager;
		private var _messages:IProperties;
		
		public function MockApplicationController()
		{
			super();
		}
		
		/**
		* 	An example of cross referencing bean documents.
		*/
		public function get rectangle():RectangleGraphic
		{
			return _rectangle;
		}
		
		public function set rectangle( value:RectangleGraphic ):void
		{
			_rectangle = value;
		}
		
		/**
		* 	A reference to the locale manager.
		*/
		public function get locales():ILocaleManager
		{
			return _locales;
		}
		
		public function set locales( value:ILocaleManager ):void
		{
			_locales = value;
		}
		
		/**
		* 	The application messages.
		*/
		public function get messages():IProperties
		{
			return _messages;
		}
		
		public function set messages( value:IProperties ):void
		{
			_messages = value;
		}
	}
}