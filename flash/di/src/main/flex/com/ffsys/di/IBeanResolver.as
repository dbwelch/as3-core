package com.ffsys.di
{
	public interface IBeanResolver {

		/**
		* 	Attempts to resolve this reference in the context
		* 	of the specified document.
		* 
		* 	@param document The document context for to resolve
		* 	this reference in.
		* 	@param style The style object.
		* 
		* 	@return The object this reference refers to or null if no corresponding
		* 	reference value was found.
		*/
		function resolve( document:IBeanDocument, style:Object ):Object;
	}
}