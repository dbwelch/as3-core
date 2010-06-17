package com.ffsys.swat.configuration.filters {
	
	import flash.filters.ColorMatrixFilter;
	
	/**
	*	Represents the configuration for a color matrix filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ColorMatrixFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>ColorMatrixFilterConfiguration</code> instance.	
		*/
		public function ColorMatrixFilterConfiguration()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return ColorMatrixFilter;
		}		
	}
}