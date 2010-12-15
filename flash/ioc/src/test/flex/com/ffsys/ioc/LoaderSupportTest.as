package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.support.*;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Unit tests for the loader builder and loader factory support.
	*/ 
	public class LoaderSupportTest extends AbstractBeanUnit
	{
		private var _factory:LoaderFactory;
		private var _mappings:FileTypeClassMapping;
		private var _lists:ListLoaderBuilder;
		private var _sequence:SequenceLoaderBuilder;
			
		public var sample:String = 
			(<![CDATA[
	
			loader-factory {
				instance-class: class( com.ffsys.ioc.support.LoaderFactory );
				singleton: true;
				extensions: ref( loader-file-extensions );
			}
			
			loader-file-extensions {
				instance-class: class( com.ffsys.ioc.support.FileTypeClassMapping );
				singleton: true;
			}
			
			named-list {
				instance-class: class( com.ffsys.ioc.support.ListLoaderBuilder );
				loader-factory: ref( loader-factory );
				prefix: assets/common/images;
				extension: jpg;
				names: array( my-image, my-next-image, my-other-image );
			}
			
			simple-sequence {
				instance-class: class( com.ffsys.ioc.support.SequenceLoaderBuilder );
				loader-factory: ref( loader-factory );
				prefix: assets/common/movies;
				extension: swf;
				start: 1;
				end: 3;
			}			
			
			named-sequence {
				instance-class: class( com.ffsys.ioc.support.SequenceLoaderBuilder );
				loader-factory: ref( loader-factory );
				prefix: assets/common/xml;
				extension: xml;
				file-name-prefix: document-;
				start: 1;
				end: 5;
			}
			
			reverse-named-sequence {
				instance-class: class( com.ffsys.ioc.support.SequenceLoaderBuilder );
				loader-factory: ref( loader-factory );
				prefix: assets/common/xml;
				extension: xml;
				file-name-prefix: document-;
				start: 5;
				end: 1;
			}			
				
			]]>).toString();
		
		/**
		*	Creates a <code>LoaderSupportTest</code> instance.
		*/ 
		public function LoaderSupportTest()
		{
			super();
		}
		
		[Test]
		public function loaderSupportListTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );

			var factory:ILoaderFactory = ILoaderFactory(
				document.getBean( "loader-factory" ) );
			
			//check the extensions reference
			Assert.assertTrue( factory.extensions is FileTypeClassMapping );
			
			var list:ListLoaderBuilder = ListLoaderBuilder(
				document.getBean( "named-list" ) );
				
			var names:Array = list.names;
			Assert.assertNotNull( names );
			Assert.assertEquals( 3, names.length );
			
			var queue:ILoaderQueue = list.getLoaderQueue();
			Assert.assertNotNull( queue );
			Assert.assertEquals( 3, queue.length );
			
			//verify type
			var loader:ILoaderElement = queue.first();
			Assert.assertTrue( loader is ImageLoader );
			
			//verify urls
			var i1:ILoader = ILoader( queue.getLoaderAt( 0 ) );
			var i2:ILoader = ILoader( queue.getLoaderAt( 1 ) );
			var i3:ILoader = ILoader( queue.getLoaderAt( 2 ) );
			Assert.assertEquals( "assets/common/images/my-image.jpg", i1.uri );
			Assert.assertEquals( "assets/common/images/my-next-image.jpg", i2.uri );
			Assert.assertEquals( "assets/common/images/my-other-image.jpg", i3.uri );
			
			//verify uppercase extensions			
			list.extension = "JPG";
			queue = list.getLoaderQueue();			
			
			i1 = ILoader( queue.getLoaderAt( 0 ) );
			i2 = ILoader( queue.getLoaderAt( 1 ) );
			i3 = ILoader( queue.getLoaderAt( 2 ) );
			Assert.assertEquals( "assets/common/images/my-image.JPG", i1.uri );
			Assert.assertEquals( "assets/common/images/my-next-image.JPG", i2.uri );
			Assert.assertEquals( "assets/common/images/my-other-image.JPG", i3.uri );
		}
		
		[Test]
		public function loaderSupportSimpleSequenceTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );

			var factory:ILoaderFactory = ILoaderFactory(
				document.getBean( "loader-factory" ) );
			
			//check the extensions reference
			Assert.assertTrue( factory.extensions is FileTypeClassMapping );
			
			var list:SequenceLoaderBuilder = SequenceLoaderBuilder(
				document.getBean( "simple-sequence" ) );
				
			var queue:ILoaderQueue = list.getLoaderQueue();
			Assert.assertNotNull( queue );
			Assert.assertEquals( 3, queue.length );
			
			//verify type
			var loader:ILoaderElement = queue.first();
			Assert.assertTrue( loader is MovieLoader );
			
			//verify urls
			var i1:ILoader = ILoader( queue.getLoaderAt( 0 ) );
			var i2:ILoader = ILoader( queue.getLoaderAt( 1 ) );
			var i3:ILoader = ILoader( queue.getLoaderAt( 2 ) );
			Assert.assertEquals( "assets/common/movies/1.swf", i1.uri );
			Assert.assertEquals( "assets/common/movies/2.swf", i2.uri );
			Assert.assertEquals( "assets/common/movies/3.swf", i3.uri );			
		}	
		
		[Test]
		public function loaderSupportNamedSequenceTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );

			var factory:ILoaderFactory = ILoaderFactory(
				document.getBean( "loader-factory" ) );
			
			//check the extensions reference
			Assert.assertTrue( factory.extensions is FileTypeClassMapping );
			
			var list:SequenceLoaderBuilder = SequenceLoaderBuilder(
				document.getBean( "named-sequence" ) );
				
			var queue:ILoaderQueue = list.getLoaderQueue();
			Assert.assertNotNull( queue );
			Assert.assertEquals( 5, queue.length );
			
			//verify type
			var loader:ILoaderElement = queue.first();
			Assert.assertTrue( loader is XmlLoader );
			
			//verify urls
			var i1:ILoader = ILoader( queue.getLoaderAt( 0 ) );
			var i2:ILoader = ILoader( queue.getLoaderAt( 1 ) );
			var i3:ILoader = ILoader( queue.getLoaderAt( 2 ) );
			var i4:ILoader = ILoader( queue.getLoaderAt( 3 ) );
			var i5:ILoader = ILoader( queue.getLoaderAt( 4 ) );
			Assert.assertEquals( "assets/common/xml/document-1.xml", i1.uri );
			Assert.assertEquals( "assets/common/xml/document-2.xml", i2.uri );
			Assert.assertEquals( "assets/common/xml/document-3.xml", i3.uri );	
			Assert.assertEquals( "assets/common/xml/document-4.xml", i4.uri );
			Assert.assertEquals( "assets/common/xml/document-5.xml", i5.uri );
		}
		
		[Test]
		public function loaderSupportReverseNamedSequenceTest():void
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );

			var factory:ILoaderFactory = ILoaderFactory(
				document.getBean( "loader-factory" ) );
			
			//check the extensions reference
			Assert.assertTrue( factory.extensions is FileTypeClassMapping );
			
			var list:SequenceLoaderBuilder = SequenceLoaderBuilder(
				document.getBean( "reverse-named-sequence" ) );
				
			var queue:ILoaderQueue = list.getLoaderQueue();
			Assert.assertNotNull( queue );
			Assert.assertEquals( 5, queue.length );
			
			//verify type
			var loader:ILoaderElement = queue.first();
			Assert.assertTrue( loader is XmlLoader );
			
			//verify urls
			var i1:ILoader = ILoader( queue.getLoaderAt( 0 ) );
			var i2:ILoader = ILoader( queue.getLoaderAt( 1 ) );
			var i3:ILoader = ILoader( queue.getLoaderAt( 2 ) );
			var i4:ILoader = ILoader( queue.getLoaderAt( 3 ) );
			var i5:ILoader = ILoader( queue.getLoaderAt( 4 ) );
			Assert.assertEquals( "assets/common/xml/document-5.xml", i1.uri );
			Assert.assertEquals( "assets/common/xml/document-4.xml", i2.uri );
			Assert.assertEquals( "assets/common/xml/document-3.xml", i3.uri );	
			Assert.assertEquals( "assets/common/xml/document-2.xml", i4.uri );
			Assert.assertEquals( "assets/common/xml/document-1.xml", i5.uri );
		}					
	}
}