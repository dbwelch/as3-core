package com.ffsys.swat.view
{
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.swat.core.IBootstrapLoader;
	import com.ffsys.swat.core.IFlashVariablesAware;
	
	/**
	*	Describes the contract for the application view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IApplication
	{
		/**
		* 	The preloader that handled preloading assets
		* 	during the bootstrap phase.
		*/
		function get preloader():IBootstrapLoader;
	}
}