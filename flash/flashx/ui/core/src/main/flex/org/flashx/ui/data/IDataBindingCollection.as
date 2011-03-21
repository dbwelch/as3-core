package org.flashx.ui.data
{	
	/**
	*	Describes the contract for a collection of data bindings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public interface IDataBindingCollection extends IDataBinding
	{
		/**
		* 	The child data bindings.
		*/
		function get children():Vector.<IDataBinding>;
	}
}

