package com.ffsys.swat.view {
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.core.IModuleLoadListener;
	
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
	 	extends IModuleLoadListener {
		
		/**
		*	Invoked when the instance is added to the display list.
		*/
		function created():void;
		
		/**
		*	Invoked while the main code is being loaded.
		* 
		* 	@param event The load event.
		*/
		function code( event:RslEvent ):void;
	}
}