package org.flashx.core {
	
	/**
	*	Describes the contract for instances that expose
	*	a <code>strict</code> flag indicating whether
	*	the instance should behave in a
	*	<code>strict</code> manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public interface IStrictMode {
		
		/**
		*	Determines whether this instance is operating
		*	in a <code>strict</code> manner.
		*/
		function set strict( val:Boolean ):void;
		function get strict():Boolean;
	}
}