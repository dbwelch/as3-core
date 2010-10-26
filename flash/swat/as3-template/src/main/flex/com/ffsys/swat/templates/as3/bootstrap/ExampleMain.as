package com.ffsys.swat.templates.as3.bootstrap {
	
	import com.ffsys.swat.configuration.ConfigurationParser;
	import com.ffsys.swat.view.SwatApplicationMain;
	
	import com.ffsys.swat.templates.as3.bootstrap.ExampleFlashVariables;
	import com.ffsys.swat.templates.as3.view.ExampleContainer;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	[Frame(factoryClass="com.ffsys.swat.templates.as3.bootstrap.ExampleApplicationPreloader")]
	public class ExampleMain extends SwatApplicationMain {
		
		/**
		*	Creates an <code>ExampleMain</code> instance.
		*/
		public function ExampleMain()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getRuntimeClasses():Array
		{
			var output:Array = new Array();
			output.push( ExampleContainer );
			output.push( ConfigurationParser );
			return output;
		}
	}
}