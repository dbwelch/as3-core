package com.ffsys.ui.runtime {
	
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
		* 	The binding used to access data associated with the parsing
		* 	of this document.
		*/
		function get binding():Object;
		
		/**
		* 	The object used to store mappings between child identifiers
		* 	and the child element reference.
		*/
		function get identifiers():Object;
	}
}