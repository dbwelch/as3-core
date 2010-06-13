package com.ffsys.swat.configuration
{
	/**
	*	Default implementation of the class path configuration
	* 	contract.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class ClassPathConfiguration extends Object
		implements IClassPathConfiguration {
		
		/**
		* 	Creates a <code>ClassPathConfiguration</code> instance.
		*/
		public function ClassPathConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getMainClassPath():String
		{
			return "com.ffsys.swat.view.SwatApplication";
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.swat.core.SwatFlashVariables";
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getPreloadViewClassPath():String
		{
			return "com.ffsys.swat.view.ApplicationPreloadView";
		}
	}
}