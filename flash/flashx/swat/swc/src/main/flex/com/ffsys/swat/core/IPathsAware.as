package com.ffsys.swat.core
{
	import com.ffsys.swat.configuration.IPaths;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the global resource paths.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IPathsAware
	{
		/**
		* 	The application resource path configuration.
		*/
		function get paths():IPaths;
		function set paths( value:IPaths ):void;
	}
}