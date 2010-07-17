package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
	/**
	*	Describes the contract for implementations that encapsulate
	*	the resource collections for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	public interface IResourceCollectionAware {
		
		/**
		*	The collection of message properties files.
		*/
		function get messages():IRuntimeResourceCollection;
		function set messages( value:IRuntimeResourceCollection ):void;
		
		/**
		*	The collection of error properties files.
		*/
		function get errors():IRuntimeResourceCollection;
		function set errors( value:IRuntimeResourceCollection ):void;
		
		/**
		*	The collection of font files.
		*/
		function get fonts():IRuntimeResourceCollection;
		function set fonts( value:IRuntimeResourceCollection ):void;
		
		/**
		*	The collection of runtime shared library resources.
		*/
		function get rsls():IRuntimeResourceCollection;
		function set rsls( rsls:IRuntimeResourceCollection ):void;	
	}
}