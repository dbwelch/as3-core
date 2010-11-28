package com.ffsys.utils.random {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the random utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.09.2007
	*	
	*/
	public class RandomUtilsTest extends Object {
		
		/**
		* 	Creates a <code>RandomUtilsTest</code> instance.
		*/
		public function RandomUtilsTest()
		{
			super();
		}
		
		[Test]
		public function testGetRandom():void
		{	
			var mn:Number = 3.14;
			var mx:Number = 10.05;
			
			var random:Number;
			
			var i:int = 0;
			var l:int = 1000;
			
			for( ;i < l;i++ )
			{
				random = RandomUtils.getRandom( mn, mx );
				Assert.assertTrue( ( random >= mn ) && ( random <= mx ) );
			}
		}		
		
		[Test]
		public function testGetRandomInteger():void
		{
			var mn:int = 100;
			var mx:int = 10000;
			
			var random:Number;
			
			var i:int = 0;
			var l:int = 1000;
			
			for( ;i < l;i++ )
			{
				random = RandomUtils.getRandomInteger( mn, mx );
				Assert.assertTrue( ( random >= mn ) && ( random <= mx ) );
			}
		}
		
		[Test]
		public function testGetRandomBoolean():void
		{
			var i:int = 0;
			var l:int = 10000;
			
			var falseFound:Boolean = false;
			var trueFound:Boolean = false;
			
			var random:Boolean;
			
			for( ;i < l;i++ )
			{
				random = RandomUtils.getRandomBoolean();
				
				if( !trueFound )
				{
					if( random )
					{
						trueFound = true;
					}
				}
				
				if( !falseFound )
				{
					if( !random )
					{
						falseFound = true;
					}
				}
			}

			Assert.assertTrue( ( trueFound && falseFound ) );
		}
	}
}