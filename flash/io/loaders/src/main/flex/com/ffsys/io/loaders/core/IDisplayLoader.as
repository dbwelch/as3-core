package com.ffsys.io.loaders.core {
	
	import flash.display.Loader;
	import flash.system.LoaderContext;
	
	import com.ffsys.io.core.IUnload;
	
	/**
	*	Describes the contract for instances that
	*	load data onto the display list using a composite
	*	<code>Loader</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2007
	*/
	public interface IDisplayLoader
		extends ILoader,
		 		IUnload {
		
		/**
		*	The <code>Loader</code> used for the load
		*	process.	
		*/
		function get loader():Loader;
		
		/**
		*	The <code>LoaderContext</code> used for the load
		*	process.	
		*/
		function set context( val:LoaderContext ):void;
		function get context():LoaderContext;
	}
}