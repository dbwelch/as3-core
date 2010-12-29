package com.ffsys.ui.runtime
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;

	/**
	*	Unit tests for verifying runtime view documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.12.2010
	*/
	public class RuntimeLoadTest extends AbstractRuntimeUnit
	{
		/**
		* 	Creates a <code>RuntimeLoadTest</code> instance.
		*/
		public function RuntimeLoadTest()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function assertLoadedView(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			//
			trace("RuntimeLoadTest::assertLoadedView()", this );
		}
		
		[Test(async)]
		public function loadRuntimeViewDocument():void
		{
			//
		}
	}
}