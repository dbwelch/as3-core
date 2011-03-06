package com.ffsys.swat.configuration
{
	import com.ffsys.io.xml.IParser;
	
	/**
	*  	Describes the contract for the configuration
	*	xml parser.
	*	
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IModuleParser extends IParser
	{
		/**
		*	Parses the configuration data into an object structure.
		*	
		*	@param x The xml to parse.
		*	@param target An optional <code>IModuleConfiguration</code>
		*	implementation to parse the data into.
		*	
		*	@return The parsed <code>IModuleConfiguration</code> implementation.
		*/
		function parse(
			x:XML, target:IModuleConfiguration = null ):IModuleConfiguration;
	}
}