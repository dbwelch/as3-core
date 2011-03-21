package org.flashx.swat.core {
	
	import org.flashx.swat.core.IBootstrapLoader;
	import org.flashx.swat.view.IApplication;
	import org.flashx.swat.view.IApplicationPreloader;
	import org.flashx.swat.view.IApplicationPreloadView;
	
	/**
	*	Describes the contract for the main application view.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IApplicationMainController {
		/**
		*	Invoked when all bootstrap assets have been loaded
		*	all references to the configuration have been set
		*	and the application is ready to start.
		*	
		*	If this method returns true the preloader view will
		*	automatically be removed from the display list.
		*	
		*	If this method returns false to defer removal of the preloader,
		*	when you want to remove the preloader view from the stage you
		*	should simply null the view reference on the bootstrap preloader.
		*	
		*	<code>bootstrap.view = null;</code>
		*	
		* 	@param parent The application implementation that loaded the bootstrap data.
		*	@param main The main application preloader that loaded
		*	the main application code base.
		*	@param bootstrap The bootstrap asset preloader.
		*	@param view The view that handled the application preload.
		*	
		*	@return Whether the preloader view should be automatically
		*	removed from the display list.
		*/
		function ready(
			parent:IApplication,
			main:IApplicationPreloader,
			bootstrap:IBootstrapLoader,
			view:IApplicationPreloadView ):Boolean;
	}
}