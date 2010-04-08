package com.ffsys.io.loaders.types {
	
	import flash.utils.ByteArray;
	
	/**
	*	Describes the contract for instances that provide
	*	access to loaded binary data as a <code>ByteArray</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IBinaryAccess {
		
		/**
		*	The loaded binary data as a
		*	<code>ByteArray</code>.
		*	
		*	@return A <code>ByteArray</code>
		*	instance.
		*/		
		function get bytes():ByteArray;
	}
}