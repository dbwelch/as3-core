package org.ecma
{
	import flash.display.Sprite;
	import org.ecma.js;
	
	/**
	* 	A test harness for the Javascript bridge.
	*/
	public class JavaScriptTestHarness extends Sprite
	{
		/**
		* 	Creates a <code>JavaScriptTestHarness</code> instance.
		*/
		public function JavaScriptTestHarness()
		{
			super();
			
			trace( "eval: " + js.eval( "aString" ) );
			
			//js.alert( "wahoo" );
			//js.func();
			//js.o.func();
		}
	}
}