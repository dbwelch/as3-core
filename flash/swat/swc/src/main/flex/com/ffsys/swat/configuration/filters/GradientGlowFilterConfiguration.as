package com.ffsys.swat.configuration.filters {
	
	import flash.filters.GradientGlowFilter;
	
	/**
	*	Represents the configuration for a gradient glow filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.06.2010
	*/
	public class GradientGlowFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>GradientGlowFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function GradientGlowFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return GradientGlowFilter;
		}
	}
}