package com.ffsys.swat.configuration.filters {
	
	import flash.filters.GlowFilter;
	
	/**
	*	Represents the configuration for a glow filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.06.2010
	*/
	public class GlowFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>GlowFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function GlowFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return GlowFilter;
		}
	}
}