package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.core.*;	
	
	/**
	*	Unit tests for parsing file dependency expressions.
	*/ 
	public class BeanFileDependencyParseTest extends AbstractBeanUnit
	{	
		public var sample:String = 
			(<![CDATA[

			di-dependencies {
				property-bitmap: img( assets/mock-di-image.jpg );
				property-sound: sound( assets/mock-di-sound.mp3 );
				property-movie: swf( assets/mock-di-movie.swf );
				property-xml: xml( assets/mock-di-xml.xml );
				property-text: text( assets/mock-di-text.txt );
				property-font: font( assets/mock-di-fonts.swf );
				property-messages: messages( assets/mock-di-messages.properties );
				property-settings: settings( assets/mock-di-settings.properties );
				property-import: import( assets/mock-import-beans.css );
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>BeanFileDependencyParseTest</code> instance.
		*/ 
		public function BeanFileDependencyParseTest()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function assertDependenciesBean( document:IBeanDocument ):void
		{
			//test the bean exists
 			var dependencies:Object = document.getBean( "di-dependencies" );
			Assert.assertNotNull( dependencies );
			
			var total:Number = 9;

			//test the document level file dependencies were added
			Assert.assertEquals( total, document.files.length );
			Assert.assertTrue( document.files[ 0 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 1 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 2 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 3 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 4 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 5 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 6 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 7 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 8 ] is BeanFileDependency );	
			
			var queue:ILoaderQueue = document.dependencies;
			Assert.assertNotNull( queue );
			Assert.assertEquals( total, queue.length );
		}
		
		[Test]
		public function beanFileDependencyParseTest():void	
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			assertDependenciesBean( document );
		}
	}
}