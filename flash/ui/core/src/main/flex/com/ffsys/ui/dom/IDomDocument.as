package com.ffsys.ui.dom
{
	
	/**
	*	Describes the contract for implementations that
	* 	form the root of a <code>DOM</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public interface IDomDocument extends IDomElement
	{
		/**
		* 	The head of the document containing document meta data.
		*/
		function get head():IDocumentHead;
		function set head( value:IDocumentHead ):void;
		
		/**
		* 	The document element.
		* 	
		* 	The body of the document containg visual elements to render.
		*/
		function get body():IDocumentBody;
		function set body( value:IDocumentBody ):void;
		
		function get documentElement():IDocumentBody;
	}
}