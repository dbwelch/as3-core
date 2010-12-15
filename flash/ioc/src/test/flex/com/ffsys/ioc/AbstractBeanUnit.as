package com.ffsys.ioc
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import flash.display.*;
	import flash.filters.*;
	import flash.net.*;	
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.io.loaders.core.*;
	
	public class AbstractBeanUnit extends Object
	{
		
		/**
		* 	Creates an <code>AbstractBeanUnit</code> instance.
		*/
		public function AbstractBeanUnit()
		{
			super();
		}
		
		protected function assertDependenciesBean( document:IBeanDocument ):void
		{
			//test the bean exists
 			var dependencies:Object = document.getBean( "di-dependencies" );
			Assert.assertNotNull( dependencies );

			//test the file dependencies were added
			Assert.assertEquals( 7, document.files.length );
			Assert.assertTrue( document.files[ 0 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 1 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 2 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 3 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 4 ] is BeanFileDependency );
			Assert.assertTrue( document.files[ 5 ] is BeanFileDependency );
			
			var queue:ILoaderQueue = document.dependencies;
			
			Assert.assertNotNull( queue );
			Assert.assertEquals( 7, queue.length );
		}
		
		protected function assertFilterBean( document:IBeanDocument ):void
		{
 			var filter:BevelFilter = BevelFilter( document.getBean( "bevel" ) );
			Assert.assertNotNull( filter );
			Assert.assertEquals( 1, filter.distance );
			Assert.assertEquals( 16711680, filter.highlightColor );
			Assert.assertEquals( 6710886, filter.shadowColor );
			Assert.assertEquals( 0.6, filter.shadowAlpha );
			Assert.assertEquals( true, filter.knockout );
			Assert.assertEquals( 5, filter.blurX );
			Assert.assertEquals( 10, filter.blurY );
			Assert.assertEquals( 20, filter.strength );
			
			//verify filters are returned as different instances
			var bevel:BevelFilter = BevelFilter( document.getBean( "bevel" ) );
			Assert.assertTrue( filter != bevel );		
		}
		
		protected function assertPrimitivesBean( document:IBeanDocument ):void
		{
			var primitives:Object = document.getBean( "primitives" );
			Assert.assertNotNull( primitives );

			Assert.assertEquals( "a test string", primitives.propertyString );
			Assert.assertEquals( 10, primitives.propertyNumber );
			Assert.assertEquals( 1.67, primitives.propertyFloat );
			Assert.assertTrue( primitives.propertyTrue );
			Assert.assertFalse( primitives.propertyFalse );
			Assert.assertNull( primitives.propertyNull );
			Assert.assertTrue( primitives.propertyUndefined == undefined );
			Assert.assertTrue( isNaN( primitives.propertyNan ) );
			Assert.assertTrue( primitives.propertyArray is Array );
			Assert.assertEquals( 4, primitives.propertyArray.length );
			Assert.assertEquals( "apples", primitives.propertyArray[ 0 ] );
			Assert.assertEquals( 10, primitives.propertyArray[ 1 ] );
			Assert.assertEquals( 3.14, primitives.propertyArray[ 2 ] );
			Assert.assertEquals( true, primitives.propertyArray[ 3 ] );			
		}
		
		protected function assertGraphicBeans( document:IBeanDocument ):void
		{
			var rectangle:RectangleGraphic = RectangleGraphic( document.getBean( "rectangle" ) );
			var fill:SolidFill = SolidFill( document.getBean( "default-fill" ) );
			var stroke:Stroke = Stroke( document.getBean( "default-stroke" ) );
			
			Assert.assertNotNull( rectangle );
			Assert.assertNotNull( fill );
			Assert.assertNotNull( stroke );
			
			Assert.assertNotNull( rectangle.fill );
			
			Assert.assertNotNull( rectangle.stroke );
			Assert.assertEquals( 1, rectangle.stroke.thickness );
			Assert.assertEquals( 16711680, rectangle.stroke.color );
			Assert.assertEquals( 0.5, rectangle.stroke.alpha );			
		}	
		
		protected function assertExpressions( document:IBeanDocument ):void
		{
			var style:Object = document.getBean( "expressions" );
			Assert.assertNotNull( style );

			Assert.assertTrue( style.classExpression is Class );
			Assert.assertTrue( style.urlExpression is URLRequest );
			Assert.assertEquals( Sprite, style.classExpression );
			Assert.assertEquals( 16711680, style.red );
			
			var singleton:Object = document.getBean( "stylable" );
			Assert.assertEquals( singleton, document.constants.stylable );
			
			Assert.assertEquals( singleton, document.getBean( "stylable" ) );			
			
			var arrays:Object = document.getBean( "arrays" );
			Assert.assertNotNull( arrays );			
			
			Assert.assertTrue( arrays.values is Array );
			
			Assert.assertEquals( 16711680, arrays.values[ 0 ] );
			Assert.assertEquals( "hello world", arrays.values[ 1 ] );
			Assert.assertEquals( singleton, arrays.values[ 2 ] );			
		}	
	}
}