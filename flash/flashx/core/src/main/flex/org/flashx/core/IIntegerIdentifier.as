package org.flashx.core
{

	/**
	*	Describes the contract for instances that expose an
	* 	integer identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.06.2010
	*/
	public interface IIntegerIdentifier
	{
		/**
		* 	Gets the id for the instance.
		* 
		* 	@return The id for the instance.
		*/
		function get id():int;
		
		/**
		* 	Sets the id for the instance.
		* 
		* 	@param id The id for the instance.
		*/
		function set id( id:int ):void;	
	}
}