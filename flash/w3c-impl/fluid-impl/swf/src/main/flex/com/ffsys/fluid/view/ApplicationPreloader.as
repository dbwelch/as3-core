package com.ffsys.fluid.view
{
	import org.flashx.swat.view.DefaultApplicationPreloader;	
	
	import org.flashx.fluid.core.ApplicationFlashVariables;
	import org.flashx.fluid.core.BootstrapConfiguration;
	
	/**
	*	The entry point for the application.
	* 
	* 	This class is responsible for the linking the classes
	* 	to be compiled on the first frame of the movie.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.01.2011
	*/
	public class ApplicationPreloader extends DefaultApplicationPreloader
	{
		/**
		* 	Creates a <code>ApplicationPreloader</code> instance.
		*/
		public function ApplicationPreloader()
		{
			super();
		}
		
		/**
		* 	A list of classes to compile on to the first frame.
		*/
		override public function getRuntimeClasses():Array
		{
			var output:Array = super.getRuntimeClasses();
			output.push( ApplicationFlashVariables );			
			output.push( BootstrapConfiguration );
			output.push( ApplicationPreloadView );
			return output;
		}
	}
}