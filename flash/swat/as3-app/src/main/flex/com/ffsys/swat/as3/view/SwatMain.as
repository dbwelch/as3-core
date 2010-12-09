package com.ffsys.swat.as3.view {
	
	import com.ffsys.swat.view.SwatApplicationMain;
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
	[Frame(factoryClass="com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloader")]
	public class SwatMain extends SwatApplicationMain {
		
		/**
		*	Creates a <code>SwatMain</code> instance.
		*/
		public function SwatMain()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getRuntimeClasses():Array
		{
			var output:Array = new Array();
			output.push( SwatActionscriptContainer );
			output.push( ConfigurationParser );
			
			output.push( Tween );
			output.push( TweenGroup );
			output.push( TweenSequence );
			
			output.push( Quad );
			return output;
		}
	}
}