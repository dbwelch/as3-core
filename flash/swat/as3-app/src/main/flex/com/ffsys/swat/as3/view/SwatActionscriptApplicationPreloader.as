package com.ffsys.swat.as3.view
{
	import com.ffsys.swat.view.SwatApplicationPreloader;
	
	import com.ffsys.swat.as3.configuration.SwatActionscriptClassPathConfiguration;
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	
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
		*	@private
		*	
		*	Force compiling of dependent classes.
		*/
		static private var _vars:ApplicationFlashVariables;
		static private var _classes:SwatActionscriptClassPathConfiguration;
		
		/**
		* 	Creates a <code>SwatActionscriptApplicationPreloader</code> instance.
		*/
		public function SwatActionscriptApplicationPreloader()
		{
			super();
		}
	}
}