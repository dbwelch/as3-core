package org.flashx.ui.runtime
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
	public class RuntimeStyleReference extends Object
	{
		/**
		* 	The name of the css style bean that this value
		* 	references.
		*/
		public var style:String;
		
		/**
		* 	Creates a <code>RuntimeStyleReference</code> instance.
		*/
		public function RuntimeStyleReference()
		{
			super();
		}
	}
}