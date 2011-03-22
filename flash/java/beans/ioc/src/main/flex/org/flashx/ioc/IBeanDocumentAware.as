package org.flashx.ioc
{
	
	/**
	*	Describes the contract for implementations that are
	* 	aware of a bean document.
	* 
	* 	If an implementation of this interface is instantiated
	* 	from a bean document the document reference will be set
	* 	to the bean document that instantiated the bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public interface IBeanDocumentAware
	{
		/**
		* 	A bean document reference.
		*/
		function get document():IBeanDocument;
		function set document( document:IBeanDocument ):void;	
	}
}