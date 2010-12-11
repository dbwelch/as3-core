package com.ffsys.di
{
	/**
	*	Describes the contract for implementations that
	* 	resolve bean references.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public interface IBeanResolver {

		/**
		* 	Attempts to resolve this reference in the context
		* 	of the specified document.
		* 
		* 	@param document The document context for to resolve
		* 	this reference in.
		* 	@param bean The bean object.
		* 
		* 	@return The object this reference refers to or null if no corresponding
		* 	reference value was found.
		*/
		function resolve( document:IBeanDocument, bean:Object ):Object;
	}
}