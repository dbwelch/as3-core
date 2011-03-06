package com.ffsys.swat.as3.view
{
	import com.ffsys.swat.view.DefaultApplicationPreloader;
	
	import com.ffsys.swat.as3.configuration.ApplicationClassPathConfiguration;
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	import com.ffsys.swat.as3.view.ApplicationPreloadView;
	
	/**
	*	Custom application preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
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
		
		override public function getRuntimeClasses():Array
		{
			var output:Array = super.getRuntimeClasses();
			output.push( ApplicationClassPathConfiguration );
			output.push( ApplicationFlashVariables );
			output.push( ApplicationPreloadView );
			return output;
		}
	}
}