package com.ffsys.fluid
{
	import com.ffsys.dom.core.*;
	
	/**
	* 	Represents a fluid element.
	* 
	* 	Such an element may be of any type whatsoever
	* 	and has the ability to mutate from one type to
	* 	another.
	*/
	public class FluidElement extends Element
	{
		/**
		* 	Creates a <code>FluidElement</code> instance.
		*/
		public function FluidElement()
		{
			super();
		}
		
		/**
		* 	Retrieves the fully qualified package
		* 	for this type.
		*/
		public function get namespacePackage():String
		{
			//TODO
			return null;
		}
	}
}