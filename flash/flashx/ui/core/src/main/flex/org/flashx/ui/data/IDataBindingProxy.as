package org.flashx.ui.data
{

	/**
	* 	Describes the contract for data bindings that proxy to composite
	* 	data bindings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public interface IDataBindingProxy extends IDataBinding
	{
		/**
		* 	Retrieves the first composite data binding of the specified type.
		* 
		* 	@param clazz The type of the data binding to retrieve.
		* 
		* 	@return A composite data binding of the specified type or <code>null</code>
		* 	if none could be found.
		*/
		function getDataBindingByType( clazz:Class ):IDataBinding;
		
		/**
		*	Removes a composite data binding from this proxy.
		* 
		* 	@param binding The data binding to remove.
		* 
		* 	@return A boolean indicating whether the data binding was removed.
		*/
		function removeDataBinding( binding:IDataBinding ):Boolean;
	
		/**
		* 	Determines whether a composite data binding is already encapsulated by this proxy.
		* 
		* 	@param binding The data binding to test for existence.
		* 
		* 	@return A boolean indicating whether this proxy encapsulates the specified data binding.
		*/
		function hasDataBinding( binding:IDataBinding ):Boolean;
	
		/**
		*	Adds a composite data binding to this proxy.
		* 
		* 	@param binding The data binding to add.
		*/
		function addDataBinding( binding:IDataBinding ):void;
	}
}