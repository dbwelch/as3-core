package com.ffsys.swat.core
{
	import com.ffsys.swat.configuration.IPaths;
	
	
	
	public interface IPathsAware
	{
		
		/**
		* 	The application resource path configuration.
		*/
		function get paths():IPaths;
		function set paths( value:IPaths ):void;
	}
}