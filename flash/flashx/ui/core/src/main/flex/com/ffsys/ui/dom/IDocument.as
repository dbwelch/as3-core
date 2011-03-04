package com.ffsys.ui.dom {
	
	import flash.display.DisplayObject;
	import com.ffsys.ui.containers.IContainer;
	
	/**
	*	Describes the contract for documents that encapsulate
	*	a view rendered from an xml definition document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public interface IDocument extends IContainer {
		
		/**
		* 	Attempts to retrieve the lowest document in the
		* 	component hierarchy.
		* 
		* 	If there is no other document in the parent hierarchy
		* 	of this component this document is returned.
		* 
		* 	@return The root document component of this hierarchy.
		*/
		function getRootDocument():IDocument;
	}
}