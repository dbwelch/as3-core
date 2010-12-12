package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for parsing file dependency expressions.
	*/ 
	public class BeanFileDependenyParseTest extends AbstractBeanUnit
	{	
		public var sample:String = 
			(<![CDATA[

			di-dependencies {
				property-bitmap: img( assets/mock-di-image.jpg );
				property-sound: sound( assets/mock-di-sound.mp3 );
				property-movie: swf( assets/mock-di-movie.swf );
				property-xml: xml( assets/mock-di-xml.xml );
				property-text: text( assets/mock-di-text.txt );				
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>BeanFileDependenyParseTest</code> instance.
		*/ 
		public function BeanFileDependenyParseTest()
		{
			super();
		}
		
		[Test]
		public function beanFileDependencyParseTest():void	
		{
			var parser:BeanTextParser = new BeanTextParser();
			var document:IBeanDocument = parser.parse( sample );
			Assert.assertNotNull( document );
			Assert.assertEquals( 1, document.length );
			assertDependenciesBean( document );
		}
	}
}