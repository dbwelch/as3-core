package com.ffsys.io.loaders.responder {
	
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.CumulativeSizeCompleteEvent;	
	
	/**
	*	Describes the contract for instances that can receive
	*	progress events that are based on the cumulative bytesTotal
	*	of all external resources to be loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadCumulativeResponder extends ILoadResponder {
		
		/* function cumulativeSizeStart( event:Event ):void; */
		/* function cumulativeSizeLoad( event:HeaderLoadEvent ):void; */
		/* function cumulativeSizeComplete( event:CumulativeSizeCompleteEvent ):void; */
		
		function cumulativeResourceLoadProgress( event:LoadProgressEvent ):void;
		
	}
	
}
