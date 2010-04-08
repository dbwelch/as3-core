package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that expose
	*	an <code>id</code> property that corresponds to
	*	a database table primary key.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.12.2007
	*/
	public interface IPrimaryKey {
		
		/**
		*	The primary key value as an unsigned integer.	
		*/
		function set id( val:uint ):void;
		function get id():uint;
	}
}