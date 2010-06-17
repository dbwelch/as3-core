package com.ffsys.swat.configuration.filters {
	
	import flash.filters.DropShadowFilter;
	
	/**
	*	Represents the configuration for a drop shadow filter.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class DropShadowFilterConfiguration extends AbstractFilterConfiguration {
		
		/**
		*	Creates a <code>DropShadowFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function DropShadowFilterConfiguration( id:String = null )
		{
			super( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilterClass():Class
		{
			return DropShadowFilter;
		}
	}
}