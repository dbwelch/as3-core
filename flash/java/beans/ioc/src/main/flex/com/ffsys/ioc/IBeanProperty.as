package com.ffsys.ioc
{
	/**
	* 	Describes the contract for instances that determine whether
	* 	they should handle setting of a bean property internally.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2010
	*/	
	public interface IBeanProperty
	{
		/**
		* 	Invoked to determine whether the property should be handled
		* 	by the target the bean property is being applied to.
		* 
		* 	@param name The name of the property about to be set.
		* 	@param value The value of the property about to be set.
		* 
		* 	@return Whether this implementation should set the bean property.
		*/
		function shouldSetBeanProperty( name:String, value:* ):Boolean;
		
		/**
		* 	This method will be invoked if the <code>shouldSetBeanProperty</code> implementation
		* 	returns <code>true</code>.
		* 
		* 	@param name The name of the property to set.
		* 	@param value The value of the property to set.
		*/
		function setBeanProperty( name:String, value:* ):void;
	}
}