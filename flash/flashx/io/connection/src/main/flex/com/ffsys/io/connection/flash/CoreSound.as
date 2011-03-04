package com.ffsys.io.connection.flash {
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	*	Adds <code>IConnection</code> functionality
	*	to <code>Sound</code>.
	*	
	*	By adhering to the <code>IConnection</code> interface
	*	<code>CoreSound</code> instances can be registered
	*	with the connection manager.
	*	
	*	@see com.ffsys.io.connection.IConnection
	*	@see com.ffsys.io.connection.ConnectionManager
	*	@see com.ffsys.io.connection.IConnectionManager
	*	@see com.ffsys.io.connection.flash.ICoreSound
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public class CoreSound extends Sound
		implements ICoreSound {
		
		/**
		*	Creates a <code>CoreSound</code>
		*	instance.
		*	
		*	@param request The <code>URLRequest</code>
		*	to load an audio file from.
		*	@param context The <code>SoundLoaderContext</code>
		*	for this instance.
		*/
		public function CoreSound(
			request:URLRequest = null,
			context:SoundLoaderContext = null )
		{
			super( request, context );
		}
	}
}