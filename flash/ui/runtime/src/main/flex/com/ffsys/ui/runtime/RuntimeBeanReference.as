package com.ffsys.ui.runtime
{
	
	/**
	*	Represents a reference to a bean within
	* 	a runtime view document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.12.2010
	*/
	public class RuntimeBeanReference extends Object
	{
		/**
		* 	The name of the bean that this value
		* 	references.
		*/
		public var ref:String;
		
		/**
		* 	Creates a <code>RuntimeBeanReference</code> instance.
		*/
		public function RuntimeBeanReference()
		{
			super();
		}
	}
}