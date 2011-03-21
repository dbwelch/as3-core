package org.flashx.io.connection {
	
	import org.flashx.io.core.IClose;
	
	/**
	*	Describes the contract for instances that manage
	*	a collection of <code>IConnection</code>
	*	implementations.
	*	
	*	@see com.ffsys.io.core.IClose
	*	@see com.ffsys.io.connection.IConnection
	*	@see com.ffsys.io.connection.ConnectionManager
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IConnectionManager
		extends IClose {
		
		/**
		*	Adds an <code>IConnection</code>
		*	to this instance.
		*	
		*	@param connection The <code>IConnection</code>
		*	to add.
		*/
		function addConnection( connection:IConnection ):void;
		
		/**
		*	Removes an <code>IConnection</code>
		*	from this instance.
		*	
		*	@param connection The <code>IConnection</code>
		*	to remove.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	<code>connection</code> was removed.
		*/		
		function removeConnection( connection:IConnection ):Boolean;
		
		/**
		*	Clears all stored <code>IConnection</code>
		*	instances.
		*/
		function clear():void;
		
		/**
		*	An <code>Array</code> of all the stored
		*	<code>IConnection</code> instances.
		*/
		function get connections():Array;
	}
}