package org.flashx.effects.tween
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.effects.easing.*;
	
	/**
	*	Unit tests for building tween objects with code.
	*/ 
	public class TweenBuilderTest
	{	
		
		/**
		*	Creates a <code>TweenBuilderTest</code> instance.
		*/ 
		public function TweenBuilderTest()
		{
			super();
		}
		
		[Test]
		public function tweenBuildTest():void
		{
			var tween:ITween = new Tween();
			Assert.assertNotNull( tween );
			
			var parameters:ITweenParameters = new TweenParameters();
			parameters.properties = [ "property" ];
			parameters.easing = [ Quad.easeOut ];
			tween.parameters = parameters;
			
			Assert.assertNotNull( tween.parameters );
			Assert.assertNotNull( tween.parameters.properties );
			Assert.assertNotNull( tween.parameters.easing );
		}
	}
}