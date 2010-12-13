package com.ffsys.swat.view {
	
	import com.ffsys.swat.core.IRuntimeAssetPreloader;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	/**
	*	Describes the contract for the main application view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IApplicationMainView {
		
		/**
		*	Invoked when all runtime assets have been loaded
		*	all references to the configuration have been set
		*	and the application is ready to start.
		*	
		*	If this method returns true the preloader view will
		*	automatically be removed from the display list.
		*	
		*	If this method returns false to defer removal of the preloader,
		*	when you want to remove the preloader view from the stage you
		*	should simply null the view reference on the runtime preloader.
		*	
		*	<code>runtime.view = null;</code>
		*	
		*	@param main The main application preloader that loaded
		*	the main application code base.
		*	@param runtime The runtime asset preloader.
		*	@param view The view that handled the application preload.
		*	
		*	@return Whether the preloader view should be automatically
		*	removed from the display list.
		*/
		function ready(
			main:IApplicationPreloader,
			runtime:IRuntimeAssetPreloader,
			view:IApplicationPreloadView ):Boolean;
	}
}