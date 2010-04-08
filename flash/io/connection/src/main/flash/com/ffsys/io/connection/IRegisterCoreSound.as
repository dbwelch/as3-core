package com.ffsys.io.connection {
	
	import com.ffsys.io.connection.flash.ICoreSound;
	
	/**
	*	Describes the contract for instances
	*	that can register an <code>ICoreSound</code>
	*	with an underlying <code>IConnectionManager</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IRegisterCoreSound {
		
		/**
		*	Registers an <code>ICoreSound</code>
		*	with this instance.
		*	
		*	@param sound The sound to register.
		*/		
		function registerCoreSound(
			sound:ICoreSound = null ):ICoreSound;
	}
}