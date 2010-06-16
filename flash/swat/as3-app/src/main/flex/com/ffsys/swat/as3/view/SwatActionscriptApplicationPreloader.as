package com.ffsys.swat.as3.view
{
	import com.ffsys.swat.view.SwatApplicationPreloader;
	
	import com.ffsys.swat.as3.configuration.SwatActionscriptClassPathConfiguration;
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	import com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloadView;
	
	/**
	*	Custom application preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatActionscriptApplicationPreloader extends SwatApplicationPreloader
	{		
		/**
		* 	Creates a <code>SwatActionscriptApplicationPreloader</code> instance.
		*/
		public function SwatActionscriptApplicationPreloader()
		{
			super();
		}
		
		override public function getRuntimeClasses():Array
		{
			var output:Array = super.getRuntimeClasses();
			output.push( SwatActionscriptClassPathConfiguration );
			output.push( ApplicationFlashVariables );
			output.push( SwatActionscriptApplicationPreloadView );
			return output;
		}
	}
}