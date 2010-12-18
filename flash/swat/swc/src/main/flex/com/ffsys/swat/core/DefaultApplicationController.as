package com.ffsys.swat.core  {

	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloader;
	import com.ffsys.swat.view.IApplicationPreloadView;	
	
	/**
	*	A controller implementation designed to serve as the main
	* 	entry point for an application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class DefaultApplicationController extends DefaultController
		implements IApplicationMainController {
		
		/**
		*	Creates an <code>DefaultApplicationController</code> instance.
		*/
		public function DefaultApplicationController()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function ready(
			parent:IApplication,
			main:IApplicationPreloader,
			bootstrap:IBootstrapLoader,
			view:IApplicationPreloadView ):Boolean
		{
			return true;
		}
	}
}