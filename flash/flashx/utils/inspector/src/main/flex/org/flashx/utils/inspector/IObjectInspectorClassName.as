package org.flashx.utils.inspector {
	
	/**
	*	Describes the contract for instances that supply
	*	a class name to use when an <code>ObjectInspector</code>
	*	produces <code>String</code> output.
	*	
	*	
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.09.2007
	*/
	public interface IObjectInspectorClassName {
		function getOutputClassName():String;
	}
	
}
