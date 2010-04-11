package com.ffsys.io.loaders.types {
	
	import flash.media.Sound;
	
	/**
	*	Describes the contract for instances
	*	that offer access to a loaded
	*	<code>Sound</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface ISoundAccess {
		
		/**
		*	The <code>Sound</code> used
		*	to load the audio file.
		*	
		*	@return A <code>Sound</code> instance.
		*/		
		function get sound():Sound;
	}
}