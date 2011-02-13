package java.nio
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	* 	
	*/
	public class CharsetConversionTest extends Object
	{
	
		public function CharsetConversionTest()
		{
			super();
		}
		
		[Test]
		public function testCharacterSetConversion():void
		{
			var v:Vector.<Object> = new Vector.<Object>();
			var nm:String = "__AS3__.vec::Vector.<Array>";
			var clazz:Class = getDefinitionByName( nm ) as Class;
			trace("CharsetConversionTest::testCharacterSetConversion()",
				getQualifiedClassName( v ), clazz );
			var instance:Vector.<Array> = ( new clazz() as Vector.<Array> );
			trace("CharsetConversionTest::testCharacterSetConversion()",
				instance );
		}
	}
}