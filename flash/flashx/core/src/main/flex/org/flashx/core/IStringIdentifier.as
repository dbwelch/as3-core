package org.flashx.core {
	
	/**
	*	Describes the contract for instances that
	*	can be identified using an <code>id</code> property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.05.2007
	*/
	public interface IStringIdentifier {
		
		/**
		*	The <code>id</code> value for the instance.	
		*/
		function get id():String;
		function set id( val:String ):void;
	}
}