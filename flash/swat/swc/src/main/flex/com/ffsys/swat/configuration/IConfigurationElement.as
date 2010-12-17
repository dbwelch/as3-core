package com.ffsys.swat.configuration {
	
	import flash.events.IEventDispatcher;
	import com.ffsys.ioc.IBeanAccess;
	import com.ffsys.swat.core.IFlashVariablesAware;
	
	/**
	*	Describes the contract for objects that
	*	encapsulate configuration information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IConfigurationElement
		extends IFlashVariablesAware,
				IMessageAccess,
				IMediaAccess,
				IBeanAccess,
				IEventDispatcher {
		
		/**
		* 	The path settings for this configuration.
		*/
		function get paths():IPaths;
		function set paths( paths:IPaths ):void;
	}
}