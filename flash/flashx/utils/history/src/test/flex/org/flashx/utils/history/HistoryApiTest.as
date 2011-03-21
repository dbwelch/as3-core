package org.flashx.utils.history {
	
	import flash.utils.ByteArray;
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the Hhistory utils package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.06.2007
	*/
	public class HistoryApiTest extends Object {
		
		/**
		* 	@private
		*/
		static private const TEST_HISTORY_ITEMS:Array = [
			"a",
			"b",
			"c"
		];
		
		/**
		* 	@private
		*/
		static private const TEST_ADD_HISTORY_ITEM:String = "c";
		
		/**
		* 	Creates a <code>HistoryApiTest</code> instance.
		*/
		public function HistoryApiTest()
		{
			super();
		}
		
		[Test]
		public function testCoreMethods():void
		{
			var history:IHistory = getDefaultHistory();
			
			history.addEventListener( HistoryEvent.CHANGE, historyChanged );
			
			Assert.assertTrue( history.hasItems() );
			
			Assert.assertEquals( TEST_HISTORY_ITEMS.length, history.getLength() );
			Assert.assertEquals( TEST_HISTORY_ITEMS[ 0 ], history.getHistoryItemAt( 0 ) );
			
			history.last();
			
			Assert.assertEquals( history.getLength() - 1, history.position );
			
			Assert.assertTrue( history.hasPrevious() );
			Assert.assertFalse( history.hasNext() );
			
			history.first();
			
			Assert.assertEquals( 0, history.position );
			
			Assert.assertTrue( history.hasNext() );
			Assert.assertFalse( history.hasPrevious() );
			
			Assert.assertEquals( TEST_HISTORY_ITEMS[ 0 ], history.item );
			
			history.next();
			
			Assert.assertEquals( 1, history.position );
			
			history.maximum = 1;
			
			Assert.assertEquals( 1, history.getLength() );
			Assert.assertEquals(
				TEST_HISTORY_ITEMS[ TEST_HISTORY_ITEMS.length - 1 ],
				history.getHistoryItemAt( 0 ) );
				
			trace( "History : "  + history );
				
			Assert.assertEquals(
				TEST_HISTORY_ITEMS[ TEST_HISTORY_ITEMS.length - 1 ],
				history.item );
				
			history.clear();
			Assert.assertFalse( history.hasItems() );
		}
		
		[Test]
		public function testInvalidPosition():void
		{
			var history:IHistory = getDefaultHistory();
			var pos:int = history.position;
			history.position = 100;
			Assert.assertEquals( pos, history.position );
			
			//TODO: integrate with flexunit4
			//now in strict mode
			
			/*
			history.strict = true;
			try {
				history.position = 100;
  			}catch( e:Error )
			{
				trace( e.toString() );
				AssertUtils.assertError( e, Error );
			}
			*/
		}
		
		[Test]
		public function testNullValue():void
		{
			var history:IHistory = getDefaultHistory();
			history.addHistoryItem( null );
			Assert.assertEquals( TEST_HISTORY_ITEMS.length, history.getLength() );
			Assert.assertFalse( history.contains( null ) );
			
			//TODO: integrate with flexunit4			
			//now in strict mode
			
			/*
			history.strict = true;
			try {
				history.addHistoryItem( null );
  			}catch( e:Error )
			{
				trace( e.toString() );
				AssertUtils.assertError( e, Error );
			}
			*/
		}
		
		[Test]
		public function testDuplicateValue():void
		{
			var history:IHistory = getDefaultHistory();
			history.allowDuplicateValues = false;
			history.addHistoryItem( TEST_ADD_HISTORY_ITEM );
			Assert.assertEquals( TEST_HISTORY_ITEMS.length, history.getLength() );
			
			//TODO: integrate with flexunit4			
			//now in strict mode
			
			/*
			history.strict = true;
			try {
				history.addHistoryItem( TEST_ADD_HISTORY_ITEM );
  			}catch( e:Error )
			{
				trace( e.toString() );
				AssertUtils.assertError( e, Error );
			}
			*/
		}					
		
		/**
		* 	@private
		*/
		private function getDefaultHistory():IHistory
		{
			var history:History = new History();
			
			var i:int = 0;
			var l:int = TEST_HISTORY_ITEMS.length;
			
			for( ;i < l;i++ )
			{
				history.addHistoryItem( TEST_HISTORY_ITEMS[ i ] );
			}
			
			return history;
		}
		
		/**
		* 	@private
		*/
		private function historyChanged( event:HistoryEvent ):void
		{
			trace( "HISTORY CHANGED" );
			trace( event.target );
		}
	}
}