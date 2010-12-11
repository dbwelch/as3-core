package com.ffsys.io.loaders.core {
	
	/**
	*	Encapsulates constants that describe the types of
	*	prioritization that can occur.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.10.2007
	*/
	public class LoaderPriority extends Object {
		/**
		*	Constant to indicate prioritizing to the top
		*	of the queue - becomes the first item to be loaded.
		*/
		static public const TOP:int = -1024;
		
		/**
		*	Constant to indicate prioritizing up one position.
		*/		
		static public const UP:int = -512;
		
		/**
		*	Constant to indicate prioritizing down one position.
		*/
		static public const DOWN:int = -128;
		
		/**
		*	Constant to indicate prioritizing to the bottom
		*	of the queue - becomes the last item to be loaded.	
		*/	
		static public const BOTTOM:int = -64;
		
		/**
		*	Constant to indicate prioritizing to the current
		*	index of the ILoaderQueue effectively this means
		*	switching the currently ILoader being loaded with
		*	the one that you want to load immediately.
		*/	
		static public const CURRENT:int = -32;
	}
}