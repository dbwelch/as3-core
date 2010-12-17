package com.ffsys.ioc
{
	import flash.display.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for verifying the bean creation policy behaviour.
	*/ 
	public class BeanCreationPolicyTest extends AbstractBeanUnit
	{	
		/**
		*	Creates a <code>BeanCreationPolicyTest</code> instance.
		*/ 
		public function BeanCreationPolicyTest()
		{
			super();
		}
		
		[Test]
		public function beanNoCreationPolicyTest():void
		{
			var id:String = "bean";
			var retrieved:Object = null;
			var document:IBeanDocument = new BeanDocument();
			document.locked = false;
			document.policy	= BeanCreationPolicy.NONE;				
			
			var a:Object = {};
			a.instanceClass = Sprite;
			a.x = 10;
			
			var b:Object = {};
			b.instanceClass = Shape;
			b.x = 20;
			
			var d1:IBeanDescriptor = new BeanDescriptor( id, a );
			var d2:IBeanDescriptor = new BeanDescriptor( id, b );
			
			//add the first bean
			Assert.assertTrue( document.addBeanDescriptor( d1 ) );
			Assert.assertEquals( 1, document.length );
			
			//with the default policy we can't add a duplicate
			Assert.assertFalse( document.addBeanDescriptor( d2 ) );
			Assert.assertEquals( 1, document.length );	
			
			//should be the original values untouched
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Sprite );
			Assert.assertEquals( 10, retrieved.x );
			
			//remove the existing definition
			Assert.assertTrue( document.removeBeanDescriptor( d1 ) );
			Assert.assertEquals( 0, document.length );
		}
		
		[Test]
		public function beanReplaceCreationPolicyTest():void
		{
			var id:String = "bean";
			var retrieved:Object = null;
			var document:IBeanDocument = new BeanDocument();
			document.locked = false;
			document.policy	= BeanCreationPolicy.REPLACE;			
			
			var a:Object = {};
			a.instanceClass = Sprite;
			a.x = 10;
			
			var b:Object = {};
			b.instanceClass = Shape;
			b.x = 20;
			
			var d1:IBeanDescriptor = new BeanDescriptor( id, a );
			var d2:IBeanDescriptor = new BeanDescriptor( id, b );

			//add the first bean and check the initial bean property value
			Assert.assertTrue( document.addBeanDescriptor( d1 ) );
			Assert.assertEquals( 1, document.length );
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Sprite );
			Assert.assertEquals( 10, retrieved.x );
			
			//replace the first bean definition with the new one
			Assert.assertTrue( document.addBeanDescriptor( d2 ) );
			Assert.assertEquals( 1, document.length );
			
			//check the replaced bean property value
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Shape );
			Assert.assertEquals( 20, retrieved.x );
			
			//remove the existing definition
			Assert.assertTrue( document.removeBeanDescriptor( d2 ) );
			Assert.assertEquals( 0, document.length );			
		}
		
		[Test]
		public function beanChangeCreationPolicyTest():void
		{
			var id:String = "bean";
			var retrieved:Object = null;
			var document:IBeanDocument = new BeanDocument();
			document.locked = false;
			document.policy	= BeanCreationPolicy.CHANGE;	
			
			var a:Object = {};
			a.instanceClass = Sprite;			
			a.x = 10;
			
			var b:Object = {};
			b.instanceClass = Shape;
			b.policy = BeanCreationPolicy.CHANGE;			
			b.x = 20;
			
			var d1:IBeanDescriptor = new BeanDescriptor( id, a );
			var d2:IBeanDescriptor = new BeanDescriptor( id, b );
			
			//add the first bean and check the initial bean property value
			Assert.assertTrue( document.addBeanDescriptor( d1 ) );
			Assert.assertEquals( 1, document.length );
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Sprite );
			Assert.assertEquals( 10, retrieved.x );
			
			//add the duplicate bean
			Assert.assertTrue( document.addBeanDescriptor( d2 ) );
			
			//check the implementation is different
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Shape );
			//but the previous properties remain intact
			Assert.assertEquals( 10, retrieved.x );
			
			//remove the existing definition
			Assert.assertTrue( document.removeBeanDescriptor( d1 ) );
			Assert.assertEquals( 0, document.length );			
		}
		
		[Test]
		public function beanMergeCreationPolicyTest():void
		{
			var id:String = "bean";
			var retrieved:Object = null;
			var document:IBeanDocument = new BeanDocument();
			document.locked = false;
			document.policy	= BeanCreationPolicy.MERGE;			
			
			var a:Object = {};
			a.instanceClass = Sprite;			
			a.x = 10;
			
			var b:Object = {};
			b.instanceClass = Shape;
			b.x = 20;
			b.y = 40;
			
			var d1:IBeanDescriptor = new BeanDescriptor( id, a );
			var d2:IBeanDescriptor = new BeanDescriptor( id, b );
			
			//add the first bean and check the initial bean property value
			Assert.assertTrue( document.addBeanDescriptor( d1 ) );
			Assert.assertEquals( 1, document.length );
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Sprite );
			Assert.assertEquals( 10, retrieved.x );
			
			//add the duplicate bean
			Assert.assertTrue( document.addBeanDescriptor( d2 ) );
			
			//check the implementation is different
			retrieved = document.getBean( id );
			Assert.assertTrue( retrieved is Shape );
			//and that the defined properties were overwritten
			Assert.assertEquals( 20, retrieved.x );
			//and new properties were added
			Assert.assertEquals( 40, retrieved.y );
			
			//remove the existing definition
			Assert.assertTrue( document.removeBeanDescriptor( d1 ) );
			Assert.assertEquals( 0, document.length );			
		}		
	}
}