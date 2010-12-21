package com.ffsys.swat.as3.view {
	
	import com.ffsys.swat.view.DefaultApplicationMain;
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	import com.ffsys.swat.configuration.ConfigurationParser;
	
	import com.ffsys.effects.easing.*;
	import com.ffsys.effects.tween.*;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	[Frame(factoryClass="com.ffsys.swat.as3.view.ApplicationPreloader")]
	public class ApplicationMain extends DefaultApplicationMain {
		
		/**
		*	Creates a <code>ApplicationMain</code> instance.
		*/
		public function ApplicationMain()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getRuntimeClasses():Array
		{
			var output:Array = new Array();
			output.push( ApplicationController );
			output.push( ConfigurationParser );
			
			output.push( Tween );
			output.push( TweenGroup );
			output.push( TweenSequence );
			
			output.push( Quad );
			return output;
		}
	}
}