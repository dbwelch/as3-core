package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that perform
	*	complete destruction.
	*	
	*	When this method is invoked the instance should
	*	clean any registered listeners and <code>null</code>
	*	references to composite instances, close any open
	*	connections, <code>unload</code> or <code>dispose</code>
	*	of any loaded non-persistent data and remove any
	*	child <code>DisplayObject</code> where appropriate.
	*	
	*	If the instance encapsulates composite
	*	<code>IDestroy</code> instances the <code>destroy</code>
	*	method of the composite instance(s) should be invoked when
	*	<code>destroy</code> is invoked.
	*	
	*	@see com.ffsys.core.Destroyer
	*	@see com.ffsys.core.IDestroyListeners
	*	@see com.ffsys.core.IDispose
	*	@see com.ffsys.io.core.IClose
	*	@see com.ffsys.io.core.IUnload
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.11.2007
	*/
	public interface IDestroy {
		
		/**
		*	Performs destruction on this instance, allowing
		*	this instance and any composite instances to
		*	be freed for garbage collection.
		*	
		*	You should not attempt to call any methods
		*	or access any properties after this
		*	method has been called.
		*/
		function destroy():void;
	}
	
}
