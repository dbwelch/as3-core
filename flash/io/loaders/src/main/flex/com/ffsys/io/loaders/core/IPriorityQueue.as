package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for a LoaderQueue that can
	*	prioritise it's underlying ILoader instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public interface IPriorityQueue {
		
		function prioritize( loader:ILoaderElement, priority:int ):Boolean;
		function prioritizeById( id:String, priority:int ):Boolean;
		
	}
}