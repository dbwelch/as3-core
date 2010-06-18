package com.ffsys.swat.configuration.filters {
	
	import flash.filters.GradientBevelFilter;
	
	/**
	*	Represents the configuration for a gradient bevel filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.06.2010
	*/
	public class GradientBevelFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>GradientBevelFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function GradientBevelFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getFilterClass():Class
		{
			return GradientBevelFilter;
		}
	}
}