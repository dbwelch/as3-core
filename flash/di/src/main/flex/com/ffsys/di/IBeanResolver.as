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
		
		/**
		* 	The name of the bean that holds this reference.
		*/
		function get beanName():String;
		function set beanName( value:String ):void;
		
		/**
		* 	The name of the bean property that holds this reference.
		*/
		function get name():String;
		function set name( value:String ):void;
		
		/**
		* 	The refrerence value extracted when this reference was parsed.
		*/
		function get value():Object;
		function set value( value:Object ):void;		
	}
}