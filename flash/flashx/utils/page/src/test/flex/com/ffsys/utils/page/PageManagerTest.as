package com.ffsys.utils.page
{
	import org.flexunit.Assert;
	
	/**
	*	Unit tests for <code>PageManagerTest</code>.
	*/ 
	public class PageManagerTest
	{
		
		/**
		*	Creates an <code>PageManagerTest</code> instance.
		*/ 
		public function PageManagerTest()
		{
			super();
		}

		[Test]
		public function emptyPageManagerTest():void
		{
			var manager:IPageManager = new PageManager();
			
			Assert.assertEquals( 0, manager.maximum );
			Assert.assertEquals( 0, manager.total );
			Assert.assertEquals( 0, manager.pages );
			Assert.assertEquals( 0, manager.index );
			Assert.assertEquals( 0, manager.start );
			Assert.assertEquals( 0, manager.end );
			Assert.assertEquals( 0, manager.items );
			Assert.assertEquals( 0, manager.page );
			
			Assert.assertFalse( manager.hasPages() );
			Assert.assertFalse( manager.isFirstPage() );
			Assert.assertFalse( manager.isLastPage() );
			Assert.assertFalse( manager.hasNextPage() );
			Assert.assertFalse( manager.hasPreviousPage() );
			Assert.assertFalse( manager.next() );
			Assert.assertFalse( manager.previous() );
			
			Assert.assertFalse( manager.first() );
			Assert.assertFalse( manager.last() );
		}
		
		[Test]
		public function simplePageManagerTest():void
		{
			var page:Array = null;
			var items:Array = [ 1,2,3,4,5,6,7,8,9,10 ];
			
			var manager:IPageManager = new PageManager( 3, 10 );
			
			Assert.assertEquals( 3, manager.maximum );
			Assert.assertEquals( 10, manager.total );
			Assert.assertEquals( 4, manager.pages );
			
			Assert.assertEquals( 0, manager.index );
			Assert.assertEquals( 0, manager.start );
			Assert.assertEquals( 3, manager.end );
			Assert.assertEquals( 3, manager.items );
			Assert.assertEquals( 1, manager.page );
			
			page = items.slice( manager.start, manager.end );
			Assert.assertEquals( 3, page.length );
			Assert.assertEquals( 1, page[ 0 ] );
			Assert.assertEquals( 2, page[ 1 ] );
			Assert.assertEquals( 3, page[ 2 ] );
			
			Assert.assertFalse( manager.hasPreviousPage() );
			Assert.assertTrue( manager.hasNextPage() );
			
			Assert.assertTrue( manager.isFirstPage() );
			Assert.assertFalse( manager.isLastPage() );
			
			//move on to next page
			Assert.assertTrue( manager.next() );
			
			page = items.slice( manager.start, manager.end );
			Assert.assertEquals( 3, page.length );
			Assert.assertEquals( 4, page[ 0 ] );
			Assert.assertEquals( 5, page[ 1 ] );
			Assert.assertEquals( 6, page[ 2 ] );
			
			Assert.assertEquals( 1, manager.index );
			Assert.assertEquals( 3, manager.start );
			Assert.assertEquals( 6, manager.end );
			Assert.assertEquals( 3, manager.items );
			Assert.assertEquals( 2, manager.page );
			
			//move on to next page
			Assert.assertTrue( manager.next() );
			
			page = items.slice( manager.start, manager.end );
			Assert.assertEquals( 3, page.length );
			Assert.assertEquals( 7, page[ 0 ] );
			Assert.assertEquals( 8, page[ 1 ] );
			Assert.assertEquals( 9, page[ 2 ] );			
			
			Assert.assertEquals( 2, manager.index );
			Assert.assertEquals( 6, manager.start );
			Assert.assertEquals( 9, manager.end );
			Assert.assertEquals( 3, manager.items );
			Assert.assertEquals( 3, manager.page );
			
			//move on to last page
			Assert.assertTrue( manager.next() );
			Assert.assertTrue( manager.isLastPage() );
	
			page = items.slice( manager.start, manager.end );
			Assert.assertEquals( 1, page.length );
			Assert.assertEquals( 10, page[ 0 ] );
			
			Assert.assertEquals( 3, manager.index );
			Assert.assertEquals( 9, manager.start );
			Assert.assertEquals( 10, manager.end );
			Assert.assertEquals( 1, manager.items );
			Assert.assertEquals( 4, manager.page );
			
			Assert.assertFalse( manager.next() );
			Assert.assertTrue( manager.previous() );
			Assert.assertEquals( 2, manager.index );
			Assert.assertEquals( 3, manager.page );
			
			Assert.assertTrue( manager.first() );
			Assert.assertTrue( manager.last() );
		}
	}
}