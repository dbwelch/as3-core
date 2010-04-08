package com.ffsys.io.loaders.types {
	
	import com.ffsys.io.loaders.display.IDisplayMovie;
	
	/**
	*	Describes the contract for instances that
	*	offer access to a loaded swf movie.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IMovieAccess {
		
		/**
		*	The <code>IDisplayMovie</code> created
		*	when the loaded swf movie became available.
		*	
		*	@return An <code>IDisplayMovie/code>
		*	implementation.
		*/
		function get movie():IDisplayMovie;
	}
}