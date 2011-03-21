package org.flashx.core.address {
	
	import org.flexunit.Assert;
	
	/**
	*	Tests the behaviour of the address path package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2007
	*/
	public class AddressPathTest extends Object {
		
		/**
		* 	Creates an <code>AddressPathTest</code> instance.
		*/
		public function AddressPathTest()
		{
			super();
		}
		
		[Test]
		public function testRootPaths():void
		{
			var addressPath:IAddressPath;
			
			addressPath = new AddressPath( "" );
			Assert.assertTrue( addressPath.isRootPath() );
			
			addressPath = new AddressPath( "/" );
			Assert.assertTrue( addressPath.isRootPath() );
			
			addressPath = new AddressPath( "//" );
			Assert.assertTrue( addressPath.isRootPath() );
			
			addressPath = new AddressPath( "//////" );
			Assert.assertTrue( addressPath.isRootPath() );					
			
			trace( addressPath );
		}
		
		[Test]
		public function testInvalidPaths():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();			
			
			var addressPath:IAddressPath;
			
			addressPath = new AddressPath( "//a/b/c///" );
			Assert.assertEquals( len, addressPath.getLength() );

			addressPath = new AddressPath( "//a/b//c///" );
			Assert.assertEquals( len, addressPath.getLength() );
			
			addressPath = new AddressPath( "///a//b//c///" );
			Assert.assertEquals( len, addressPath.getLength() );
			
			addressPath = new AddressPath( "///a///b//c///" );
			Assert.assertEquals( len, addressPath.getLength() );											
			
			addressPath = new AddressPath( "/a////b/////c/" );
			Assert.assertEquals( len, addressPath.getLength() );			
			
			trace( addressPath );
		}				
		
		[Test]
		public function testAddressPathApi():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );			
			
			var removed:Boolean = false;
			
			Assert.assertNotNull( addressPath.address );
			
			Assert.assertEquals( len, addressPath.getLength() );
			
			removed = false;
			removed = addressPath.removePathElements( "a" );
			Assert.assertTrue( removed );
			
			Assert.assertEquals( len - 1, addressPath.getLength() );
			
			Assert.assertEquals( "b", addressPath[ 0 ] );
			
			addressPath.addPathElement( "d" );
			
			Assert.assertEquals( len, addressPath.getLength() );
			
			//attempt to set an element less than zero
			//should insert onto the beginning
			addressPath.setPathElementAt( -1, "a" );
			
			Assert.assertEquals( len + 1, addressPath.getLength() );
			
			//remove the element just inserted at the start of the path
			addressPath.removePathElementAt( 0 );
			
			Assert.assertEquals( len, addressPath.getLength() );
			
			trace( addressPath );
		}
		
		[Test]
		public function testRemovePathElementsByMatch():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );			
			
			var removed:Boolean = false;
			
			Assert.assertNotNull( addressPath.address );
			Assert.assertEquals( len, addressPath.getLength() );
			
			addressPath.insertPathElementAt( 1, "//b1/b2///" );
			
			removed = false;
			removed = addressPath.removePathElementsByMatch( /^b[0-9]/ );
			Assert.assertTrue( removed );
			
			Assert.assertEquals( len, addressPath.getLength() );
			
			trace( addressPath );			
		}
		
		[Test]
		public function testAddressPathForLoops():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			//array to hold values for validation on the subsequent for..each loop
			var validations:Object = new Object();
			
			//verify for..in loops match the api method(s)
			var key:String;
			
			for( key in addressPath )
			{
				validations[ addressPath[ key ] ] = parseInt( key );
				Assert.assertEquals(
					addressPath[ key ], addressPath.getPathElementAt( parseInt( key ) ) );
			}
			
			//verify for..each loops behave as expected
			var element:String;
			for each( element in addressPath )
			{
				Assert.assertEquals(
					addressPath.getPathElementIndex( element ), validations[ element ] );
			}
		}
		
		[Test]
		public function testFirstLastPathElements():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );			
			
			Assert.assertNotNull( addressPath.address );
			Assert.assertEquals( len, addressPath.getLength() );

			Assert.assertEquals( "a", addressPath.getFirstPathElement() );
			Assert.assertEquals( "c", addressPath.getLastPathElement() );
			
			var element:String;
			while( element = addressPath.removeLastPathElement() )
			{
				trace("AddressPathTest::removeLastPathElement(), " +
					"removing last path element: " + element );
			}
			
			Assert.assertEquals( 0, addressPath.getLength() );
			
			//re-assign the original path
			addressPath.address = path;
			
			while( element = addressPath.removeFirstPathElement() )
			{
				trace("AddressPathTest::removeFirstPathElement(), " +
					"removing first path element: " + element );
			}
			
			Assert.assertEquals( 0, addressPath.getLength() );
			
			trace( addressPath );
		}
		
		[Test]
		public function testIsRootPath():void
		{
			var addressPath:IAddressPath = new AddressPath( "" );
			Assert.assertTrue( addressPath.isRootPath() );
			
			addressPath = new AddressPath( "/" );
			Assert.assertTrue( addressPath.isRootPath() );			
			
			trace( addressPath );
		}
		
		/*
		*	IAddressPathCompare tests.	
		*/
		
		[Test]
		public function testAddressPathEquals():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );			
			
			var removed:Boolean = false;
			
			Assert.assertNotNull( addressPath.address );
			Assert.assertEquals( len, addressPath.getLength() );
			
			//test for the equals method
			var compare:IAddressPath = new AddressPath( getTestPath() );
			
			Assert.assertTrue( addressPath.equals( compare ) );
				
			compare.addPathElement( "d" );
			
			Assert.assertFalse( addressPath.equals( compare ) );
			
			//restore the comparison to the original path
			compare.address = getTestPath();
			Assert.assertTrue( addressPath.equals( compare ) );
			
			compare[ 1 ] = "d";
			Assert.assertFalse( addressPath.equals( compare ) );
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathStarts():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/a/" );
			Assert.assertTrue( addressPath.starts( compare ) );
			
			compare = new AddressPath( "/a/b/" );
			Assert.assertTrue( addressPath.starts( compare ) );
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertTrue( addressPath.starts( compare ) );
			
			compare = new AddressPath( "/a/b/c/d/" );
			Assert.assertFalse( addressPath.starts( compare ) );
			
			compare = new AddressPath( "/a/b/d/" );
			Assert.assertFalse( addressPath.starts( compare ) );
			
			compare = new AddressPath( "/a/d/c/" );
			Assert.assertFalse( addressPath.starts( compare ) );									
			
			compare = new AddressPath( "/c/" );
			Assert.assertFalse( addressPath.starts( compare ) );		
			
			trace( addressPath );
		}	
		
		[Test]
		public function testAddressPathEnds():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/c/" );
			Assert.assertTrue( addressPath.ends( compare ) );
			
			compare = new AddressPath( "/b/c/" );
			Assert.assertTrue( addressPath.ends( compare ) );
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertTrue( addressPath.ends( compare ) );
			
			compare = new AddressPath( "/d/a/b/d/" );
			Assert.assertFalse( addressPath.ends( compare ) );
			
			compare = new AddressPath( "/a/b/d/" );
			Assert.assertFalse( addressPath.ends( compare ) );
			
			compare = new AddressPath( "/a/d/c/" );
			Assert.assertFalse( addressPath.ends( compare ) );									
			
			compare = new AddressPath( "/b/" );
			Assert.assertFalse( addressPath.ends( compare ) );
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathParent():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/a/b/" );
			Assert.assertTrue( addressPath.parent( compare ) );

			compare = new AddressPath( "/a/c/" );
			Assert.assertFalse( addressPath.parent( compare ) );
			
			compare = new AddressPath( "/a/" );
			Assert.assertFalse( addressPath.parent( compare ) );
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertFalse( addressPath.parent( compare ) );			
			
			compare = new AddressPath( "/a/b/c/d/" );
			Assert.assertFalse( addressPath.parent( compare ) );			
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathAncestor():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/a/b/" );
			Assert.assertTrue( addressPath.ancestor( compare ) );

			compare = new AddressPath( "/a/" );
			Assert.assertTrue( addressPath.ancestor( compare ) );
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertFalse( addressPath.ancestor( compare ) );
			
			compare = new AddressPath( "/a/c/" );
			Assert.assertFalse( addressPath.ancestor( compare ) );
			
			compare = new AddressPath( "/d/" );
			Assert.assertFalse( addressPath.ancestor( compare ) );
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathSibling():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/a/b/d/" );
			Assert.assertTrue( addressPath.sibling( compare ) );
			
			compare = new AddressPath( "/a/b/e/" );
			Assert.assertTrue( addressPath.sibling( compare ) );
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertFalse( addressPath.sibling( compare ) );
			
			compare = new AddressPath( "/a/b/" );
			Assert.assertFalse( addressPath.sibling( compare ) );
			
			compare = new AddressPath( "/a/" );
			Assert.assertFalse( addressPath.sibling( compare ) );
			
			compare = new AddressPath( "/a/b/c/d/" );
			Assert.assertFalse( addressPath.sibling( compare ) );
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathChild():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/a/b/c/d/" );
			Assert.assertTrue( addressPath.child( compare ) );
			
			compare = new AddressPath( "/a/b/c/e/" );
			Assert.assertTrue( addressPath.child( compare ) );
			
			compare = new AddressPath( "/a/b/c/d/e/f/" );
			Assert.assertTrue( addressPath.child( compare ) );	
			
			compare = new AddressPath( "/a/b/c/" );
			Assert.assertFalse( addressPath.child( compare ) );
			
			compare = new AddressPath( "/a/b/" );
			Assert.assertFalse( addressPath.child( compare ) );
			
			compare = new AddressPath( "/a/" );
			Assert.assertFalse( addressPath.child( compare ) );
			
			compare = new AddressPath( "/d/a/c/" );
			Assert.assertFalse( addressPath.child( compare ) );
			
			trace( addressPath );
		}
		
		[Test]
		public function testAddressPathConcat():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			var compare:IAddressPath;
			
			compare = new AddressPath( "/d/e/f/" );
			
			addressPath.concat( compare );
			
			Assert.assertEquals( len * 2, addressPath.getLength() );
			
			var element:String;
			for each( element in addressPath )
			{
				trace("AddressPathTest::testAddressPathConcat(), " + element );
			}
		}
		
		[Test]
		public function testAddressPathFind():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			
			var addressPath:IAddressPath = new AddressPath( path );
			
			var target:Object = getDefaultFindObject();
			
			var found:Object = null;
			
			found = addressPath.find( target );
			Assert.assertEquals( target.a.b.c, found );
			
			addressPath.removeLastPathElement();
			found = addressPath.find( target );
			Assert.assertEquals( target.a.b, found );
			
			//restore
			addressPath.address = path;
			
			//find using method lookup
			found = addressPath.find( target, "getChildByName" );
			Assert.assertEquals( target.a.b.c, found );
			
			//find using invalid method lookup
			found = addressPath.find( target, "getNonexistent" );
			Assert.assertNull( found );	
		}
		
		/*
		*	IDestroy tests.	
		*/
		
		[Test]
		public function testAddressPathDestroy():void
		{
			var path:String = getTestPath();
			var len:int = getTestPathLength();
			var addressPath:IAddressPath = new AddressPath( path );
			
			//test for destroying an IAddressPath instance
			addressPath.destroy();
			Assert.assertNull( addressPath.delimiter );
			Assert.assertNull( addressPath.address );
			
			trace( addressPath );
		}
		
		/**
		* 	@private
		*/
		private function getDefaultFindObject():Object
		{
			var getChildByName:Function = function( name:String ):Object
			{
				return this[ name ];
			}
			
			var out:Object = new Object();
			out.getChildByName = getChildByName;
			out.toString = function():String
			{
				return "[Object FindRoot]";
			}
			
			out.a = new Object();
			
			out.a.getChildByName = getChildByName;
			
			out.a.toString = function():String
			{
				return "[Object a]";
			}			
			
			out.a.b = new Object();
			
			out.a.b.getChildByName = getChildByName;
			
			out.a.b.toString = function():String
			{
				return "[Object b]";
			}
			
			out.a.b.c = new Object();
			
			out.a.b.c.getChildByName = getChildByName;
			
			out.a.b.c.toString = function():String
			{
				return "[Object c]";
			}
			
			return out;
		}
		
		/**
		* 	@private
		*/
		private function getTestPath():String
		{
			return "/a/b/c/";
		}
		
		/**
		* 	@private
		*/
		private function getTestPathLength():int
		{
			return 3;
		}				
	}
}