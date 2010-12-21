package com.ffsys.ioc.mock
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;	
	
	import flash.display.*;
	import flash.media.*;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.utils.properties.IProperties;
	
	/**
	* 	Example of a bean that is intended solely to load
	* 	and access resources.
	* 
	* 	This implementation 
	*/
	public class MockFileLoaderBean extends LoaderQueue
	{
		private var _propertyBitmap:BitmapData;
		private var _propertySound:Sound;
		private var _propertyMovie:Loader;
		private var _propertyXml:XML;
		private var _propertyText:String;
		private var _propertyFont:Array;
		private var _propertyMessages:IProperties;
		
		/**
		* 	Creates a <code>MockFileLoaderBean</code> instance.
		*/
		public function MockFileLoaderBean()
		{
			super();
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	image file.
		*/
		public function get propertyBitmap():BitmapData
		{
			return _propertyBitmap;
		}
		
		public function set propertyBitmap( value:BitmapData ):void
		{
			_propertyBitmap = value;
			Assert.assertNotNull( value );
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	sound file.
		*/		
		public function get propertySound():Sound
		{
			return _propertySound;
		}
		
		public function set propertySound( value:Sound ):void
		{
			_propertySound = value;
			Assert.assertNotNull( value );			
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	flash movie.
		*/		
		public function get propertyMovie():Loader
		{
			return _propertyMovie;
		}
		
		public function set propertyMovie( value:Loader ):void
		{
			_propertyMovie = value;
			Assert.assertNotNull( value );			
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	xml file.
		*/
		public function get propertyXml():XML
		{
			return _propertyXml;
		}
		
		public function set propertyXml( value:XML ):void
		{
			_propertyXml = value;
			Assert.assertNotNull( value );			
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	text file.
		*/
		public function get propertyText():String
		{
			return _propertyText;
		}
		
		public function set propertyText( value:String ):void
		{
			_propertyText = value;
			Assert.assertNotNull( value );			
		}
		
		/**
		* 	Exposes a property to be populated with the data
		* 	created when fonts in a loaded flash movie were
		* 	registered.
		*/
		public function get propertyFont():Array
		{
			return _propertyFont;
		}
		
		public function set propertyFont( value:Array ):void
		{
			_propertyFont = value;
			Assert.assertNotNull( value );
		}
		
		/**
		* 	Exposes a property to be populated with a loaded
		* 	properties file.
		*/
		public function get propertyMessages():IProperties
		{
			return _propertyMessages;
		}
		
		public function set propertyMessages( value:IProperties ):void
		{
			_propertyMessages = value;
		}
	}
}