package com.ffsys.ui.core
{
	import com.ffsys.core.IEnabled;
	
	import com.ffsys.ui.text.TextFieldFactory;
	
	/**
	*	Describes the contract for all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponent extends IEnabled
	{
		
		/**
		* 	The text field factory used to create textfields.
		*/
		function get textFieldFactory():TextFieldFactory;
	}
}