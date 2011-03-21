package org.flashx.core {
	
	/**
	*	Describes the contact for instances that maintain
	*	a <code>fatal</code> flag that determines whether
	*	the instance should fail in a <code>fatal</code> manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IFatal {
		
		/**
		*	Determines whether this instance should behave
		*	in a <code>fatal</code> manner.	
		*/
		function set fatal( val:Boolean ):void;
		function get fatal():Boolean;
	}
	
}
