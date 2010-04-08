package com.ffsys.io.loaders.types {
	
	import com.ffsys.io.loaders.display.IDisplayVideo;
	
	/**
	*	Describes the contract for instances that
	*	offer access to a loaded video.
	*	
	*	@see com.ffsys.io.loaders.display.IDisplayVideo
	*	@see com.ffsys.io.loaders.types.VideoLoader
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IVideoAccess {
		
		/**
		*	The <code>IDisplayVideo</code> created
		*	when the loaded video became available.
		*	
		*	@return An <code>IDisplayVideo</code>
		*	implementation.
		*/
		function get video():IDisplayVideo;
	}
}