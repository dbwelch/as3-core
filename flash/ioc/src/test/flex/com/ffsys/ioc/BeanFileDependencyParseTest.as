package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
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
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>BeanFileDependencyParseTest</code> instance.
		*/ 
		public function BeanFileDependencyParseTest()
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