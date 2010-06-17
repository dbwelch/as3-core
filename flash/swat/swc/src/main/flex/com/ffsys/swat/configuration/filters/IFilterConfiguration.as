package com.ffsys.swat.configuration.filters {
	
	import flash.filters.BitmapFilter;
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for filter configurations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface IFilterConfiguration
		extends IStringIdentifier {
		
		/**
		*	Gets the class of bitmap filter to instantiate
		*	when the clone method is called.
		*	
		*	@return The bitmap filter class.	
		*/
		function getFilterClass():Class;
		
		/**
		*	Creates a clone of this filter.
		*	
		*	@return An instance of the bitmap filter class.
		*/
		function clone():BitmapFilter;
	}
}