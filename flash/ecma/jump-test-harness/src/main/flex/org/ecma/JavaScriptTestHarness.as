package org.ecma
{
	import flash.display.Sprite;
	import org.ecma.js;
	import flash.utils.getQualifiedClassName;
	
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
			
			//retrieve and set an existing custom variable
			trace( "eval (aString:before): " + js.aString.valueOf() );
			js.aString = "A new value";
			trace( "eval (aString:after): " + js.aString.valueOf() );
			
			//retrieve a pre-defined variable
			trace("document.location.href: ", js.document.location.href.valueOf() );
			
			//assign a new non-existent variable and retrieve the value
			js.aNewVar = 123;
			var aNewVar:* = js.aNewVar.valueOf();
			trace( "eval (aNewVar:after): ", aNewVar, getQualifiedClassName( aNewVar ) );
			
			//invoke a top-level custom function
			trace("mult(3,4):", js.mult( 3, 4 ) );
			
			//js.alert( "wahoo" );
			//js.func();
			//js.o.func();
		}
	}
}