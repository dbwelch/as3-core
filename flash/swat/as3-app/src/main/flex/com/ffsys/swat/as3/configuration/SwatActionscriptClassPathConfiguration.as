package com.ffsys.swat.as3.configuration
{
	import com.ffsys.swat.configuration.ClassPathConfiguration;
	
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	import com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloadView;
	
	/**
	*	Custom class path configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class SwatActionscriptClassPathConfiguration extends ClassPathConfiguration
	{
		static private var _vars:ApplicationFlashVariables;
		static private var _view:SwatActionscriptApplicationPreloadView;
		
		/**
		* 	Creates a <code>SwatActionscriptClassPathConfiguration</code> instance.
		*/
		public function SwatActionscriptClassPathConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.swat.as3.core.ApplicationFlashVariables";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getPreloadViewClassPath():String
		{
			return "com.ffsys.swat.as3.view.SwatActionscriptApplicationPreloadView";
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getMainViewClassPath():String
		{
			return "com.ffsys.swat.as3.view.SwatActionscriptContainer";
		}
	}
}