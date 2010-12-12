package com.ffsys.di
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.display.*;
	
	/**
	*	Unit tests for instantiating from bean descriptors.
	*/ 
	public class BeanInstanceCreationTest extends AbstractBeanUnit
	{	
		
		/**
		*	Creates a <code>BeanInstanceCreationTest</code> instance.
		*/ 
		public function BeanInstanceCreationTest()
		{
			super();
		}
		
		[Test]
		public function beanInstanceCreationTest():void
		{
			var bean:Object = {};
			bean.id = "my-bean";
			bean.instanceClass = Sprite;
			bean.x = 10;
			bean.y = 20;
			bean.z = 30;
						
			var document:IBeanDocument = new BeanDocument();			
			var descriptor:IBeanDescriptor = new BeanDescriptor( bean );
			Assert.assertEquals( "my-bean", descriptor.id );
			Assert.assertTrue( descriptor.instanceClass is Class );
			
			document.addBeanDescriptor( descriptor );
			var retrieved:Object = document.getBean( "my-bean" );
			
			Assert.assertNotNull( retrieved );
			Assert.assertTrue( retrieved is Sprite );
			
			var sprite:Sprite = Sprite( retrieved );
			Assert.assertEquals( 10, sprite.x );
			Assert.assertEquals( 20, sprite.y );
			Assert.assertEquals( 30, sprite.z );
			
			Assert.assertEquals( 1, document.length );
			Assert.assertEquals( 1, document.beanNames.length );
		}
		
		[Test]
		public function beanSingletonTest():void
		{
			var bean:Object = {};
			bean.id = "my-bean";
			bean.instanceClass = Sprite;
			bean.singleton = true;		
			
			var document:IBeanDocument = new BeanDocument();
			var descriptor:IBeanDescriptor = new BeanDescriptor( bean );
			Assert.assertEquals( "my-bean", descriptor.id );			
			Assert.assertTrue( descriptor.instanceClass is Class );
			Assert.assertTrue( descriptor.singleton );
			
			document.addBeanDescriptor( descriptor );
			var retrieved:Object = document.getBean( "my-bean" );
			
			Assert.assertNotNull( retrieved );
			Assert.assertTrue( retrieved is Sprite );
			
			var alternative:Object = document.getBean( "my-bean" );
			Assert.assertEquals( retrieved, alternative );
		}
	}
}