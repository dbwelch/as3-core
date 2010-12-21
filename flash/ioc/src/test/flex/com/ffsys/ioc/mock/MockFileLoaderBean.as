package com.ffsys.ioc.mock
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;	
	
	import flash.display.*;
	import flash.media.*;
	
	import com.ffsys.ioc.*;
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.utils.properties.IProperties;
	
	/**
	* 	Example of a bean that is intended solely to load
	* 	and access resources.
	* 
	* 	This implementation 
	*/
	public class MockFileLoaderBean extends LoaderQueue
		implements IBeanLoaderObserver
	{
		private var _propertyBitmap:BitmapData;
		private var _propertySound:Sound;
		private var _propertyMovie:Loader;
		private var _propertyXml:XML;
		private var _propertyText:String;
		private var _propertyFont:Array;
		private var _propertyMessages:IProperties;
		
		public var autoLoad:Boolean = false;
		public var targetQueue:ILoaderQueue = null;
		public var loadedResources:Vector.<IResource> = new Vector.<IResource>();
		public var targetResources:IResourceList;
		
		/**
		* 	Creates a <code>MockFileLoaderBean</code> instance.
		*/
		public function MockFileLoaderBean()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFileLoadBehaviour(
			queue:ILoaderQueue,
			descriptor:IBeanDescriptor,
			files:Vector.<BeanFileDependency> ):Boolean
		{
			Assert.assertNotNull( queue );
			Assert.assertNotNull( descriptor );
			Assert.assertNotNull( files );
			Assert.assertTrue( files.length > 0 );
			autoLoad = true;
			trace("MockFileLoaderBean::getFileLoadBehaviour()", queue, descriptor, files.length );
			//allow the file dependencies to be loaded when this bean is retrieved
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithLoaderQueue(
			queue:ILoaderQueue,
			descriptor:IBeanDescriptor,
			files:Vector.<BeanFileDependency> ):ILoaderQueue
		{
			Assert.assertNotNull( queue );
			Assert.assertNotNull( descriptor );
			Assert.assertNotNull( files );
			Assert.assertTrue( files.length > 0 );	
			trace("MockFileLoaderBean::doWithLoaderQueue()", queue, descriptor, files.length );
			//we are the loader queue in this implementation
			Assert.assertEquals( this, queue );
			this.targetQueue = queue;
			return queue;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldProcessResource(
			resource:IResource,
			descriptor:IBeanDescriptor,
			dependency:BeanFileDependency ):Boolean
		{			
			Assert.assertNotNull( resource );
			Assert.assertNotNull( descriptor );
			Assert.assertNotNull( dependency );
			//we handle setting the property ourselves yet mimic the default behaviour
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithResource(
			resource:IResource,
			descriptor:IBeanDescriptor,
			dependency:BeanFileDependency ):void
		{
			Assert.assertNotNull( resource );
			Assert.assertNotNull( descriptor );
			Assert.assertNotNull( dependency );
			loadedResources.push( resource );
			//mimic the default bean property setting behaviour
			descriptor.setBeanProperty( this, dependency.name, resource.data );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithResourceList(
			resources:IResourceList,
			descriptor:IBeanDescriptor ):void
		{
			this.targetResources = resources;
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