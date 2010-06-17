package com.ffsys.swat.configuration.filters {
	
	import flash.filters.BevelFilter;
	
	/**
	*	Represents the configuration for a bevel filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class BevelFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>BevelFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function BevelFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return BevelFilter;
		}		
	}
}