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
			trace( "js.message: " + js.message.valueOf() );
			js.message = "A new value";
			trace( "js.message: " + js.message.valueOf() );
			
			//retrieve a pre-defined variable
			var href:String = js.document.location.href.valueOf()
			trace("document.location.href: ", href );
			
			//assign a new non-existent variable and retrieve the value			
			js.integer = 10;
			var integer:int = js.integer.valueOf();			
			
			trace( "js.integer: ", integer, getQualifiedClassName( integer ) );
			
			//invoke a top-level custom function
			trace("mult( 3, 4 ):", js.mult( 3, 4 ).valueOf() );
			
			//invoke a nested function
			trace( "js.o.point( 10, 10 ): ", js.o.point( 10, 10 ).valueOf() );
			
			trace("x.a(): ", js.x.a().valueOf() );
			trace("x.b(): ", js.x.b().valueOf() );
			
			//trace("::::", js.document.getElementById( "wrapper" ).valueOf() );
			
			//show an alert
			//js.alert( "This is an actionscript alert." ).valueOf();
		}
	}
}