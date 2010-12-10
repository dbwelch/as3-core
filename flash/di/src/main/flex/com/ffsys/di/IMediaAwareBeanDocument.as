package com.ffsys.di {
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Describes the contract for bean stores that are capable
	* 	of loading rich media assets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IMediaAwareBeanDocument
		extends	IBeanDocument {
		
		/**
		*	A queue that represents the dependencies that
		*	were found when the beans were parsed.
		*/
		function get dependencies():ILoaderQueue;
		
		/**
		*	Parses the text into this instance
		*	and returns a loader queue implementation
		*	responsible for loading any external dependencies
		*	declared in the beans.
		*	
		*	@param text The beans text to parse.
		*	
		*	@return The loader queue responsible for loading
		*	external dependencies.
		*/
		function parse( text:String ):ILoaderQueue;
	}
}