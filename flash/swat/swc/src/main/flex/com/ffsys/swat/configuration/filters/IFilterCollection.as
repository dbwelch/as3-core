package com.ffsys.swat.configuration.filters {
	
	import flash.filters.BitmapFilter;
	
	/**
	*	Describes the contract for instances that encapsulate
	*	a collection of filter configurations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface IFilterCollection {
		
		function removeFilterById( id:String ):Boolean;
		
		function getFilterById(
			id:String ):BitmapFilter;
		
		function addFilter( filter:IFilterConfiguration ):Boolean;
	}
}