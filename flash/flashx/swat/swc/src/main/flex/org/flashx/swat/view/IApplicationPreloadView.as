package org.flashx.swat.view {
	
	import org.flashx.swat.events.RslEvent;
	import org.flashx.swat.configuration.IConfiguration;
	import org.flashx.swat.core.IResourceLoadObserver;
	
	/**
	*	Describes the contract for views that handle the application
	*	load process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public interface IApplicationPreloadView
	 	extends IResourceLoadObserver {
		
		/**
		*	Invoked when the instance is added to the display list.
		*/
		function created():void;
	}
}