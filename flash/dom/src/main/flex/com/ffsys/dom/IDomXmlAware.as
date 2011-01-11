package com.ffsys.dom
{
	/**
	*	Describes the contract for implementations that
	* 	wish to be notified of the <code>XML</code> that defined
	* 	the component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public interface IDomXmlAware
	{
		/**
		* 	Invoked for display objects that wish to be assigned
		* 	the xml definition that created them.
		*/
		function get xml():XML;
		function set xml( value:XML ):void;	
	}
}