package com.ffsys.ioc.support.xml
{
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.ioc.IBeanDocument;
	
	/**
	*	Describes the contract for parser implementations which
	* 	use a bean document for object instantiation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.12.2010
	*/
	public interface IBeanXmlParser extends IParser
	{
		/**
		* 	The bean document containing bean definitions used
		* 	when instantiating objects for xml elements.
		*/
		function get document():IBeanDocument;
		function set document( value:IBeanDocument ):void;	
	}
}