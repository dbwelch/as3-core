package org.flashx.swat.view
{
	import org.flashx.core.IFlashVariables;
	import org.flashx.swat.core.IBootstrapLoader;
	import org.flashx.swat.core.IFlashVariablesAware;
	
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