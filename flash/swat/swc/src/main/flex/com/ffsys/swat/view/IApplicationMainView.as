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
	*	@author 
	*	@since  16.06.2010
	*/
	public interface IApplicationMainView {
		
		function ready(
			main:IApplicationPreloader,
			runtime:IRuntimeAssetPreloader,
			view:IApplicationPreloadView ):void;
	}
}