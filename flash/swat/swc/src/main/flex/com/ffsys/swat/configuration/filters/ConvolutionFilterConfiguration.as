package com.ffsys.swat.configuration.filters {
	
	import flash.filters.ConvolutionFilter;
	
	/**
	*	Represents the configuration for a convolution filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ConvolutionFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>ConvolutionFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function ConvolutionFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return ConvolutionFilter;
		}		
	}
}