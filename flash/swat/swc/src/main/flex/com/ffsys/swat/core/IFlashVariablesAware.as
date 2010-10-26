package com.ffsys.swat.core
{
	
	import com.ffsys.core.IFlashVariables;

	public interface IFlashVariablesAware
	{
		/**
		* 	The flash variables instantiated when the application
		* 	was started.
		*/
		function get flashvars():IFlashVariables;
		function set flashvars( flashvars:IFlashVariables ):void;
	}
}