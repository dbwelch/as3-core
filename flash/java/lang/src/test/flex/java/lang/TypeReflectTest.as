package java.lang
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	* 	
	*/
	public class TypeReflectTest extends Object
	{	
		/**
		* 	Creates a <code>TypeReflectTest</code> instance.
		*/
		public function TypeReflectTest()
		{
			super();
		}
		
		[Test]
		public function testType():void
		{
			var t:T = T.getInstance( this );
			Assert.assertNotNull( t );
			
			trace("TypeReflectTest::testType()", t, t.name, t.path, t.pkg, t.definition, t.xml );
		}
	}
}