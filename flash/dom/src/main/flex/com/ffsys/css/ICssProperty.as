package com.ffsys.css
{
	/**
	* 	Describes the contract for instances that determine whether
	* 	they should handle setting of a css property internally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2010
	*/	
	public interface ICssProperty
	{
		/**
		* 	Invoked to determine whether the property should be handled
		* 	by the target the css property is being applied to.
		* 
		* 	@param name The name of the property about to be set.
		* 	@param value The value of the property about to be set.
		*/
		function shouldSetCssProperty( name:String, value:* ):Boolean;
		
		/**
		* 	This method will be invoked if the <code>shouldSetCssProperty</code> implementation
		* 	returns <code>true</code>.
		* 
		* 	@param name The name of the property to set.
		* 	@param value The value of the property to set.
		*/
		function setCssProperty( name:String, value:* ):void;
	}
}