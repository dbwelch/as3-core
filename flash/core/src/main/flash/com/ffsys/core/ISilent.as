package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that expose
	*	a <code>silent</code> flag indicating whether
	*	the instance should behave in a <code>silent</code>
	*	manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface ISilent {
		
		/**
		*	Determines whether this instance is operating
		*	in a <code>silent</code> manner.
		*/
		function set silent( val:Boolean ):void;
		function get silent():Boolean;		
	}
	
}