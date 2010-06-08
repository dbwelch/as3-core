package com.ffsys.swat.configuration
{
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
	public interface IConfigurationParser 
	{
		/**
		*	Parses the configuration data into an object structure.
		*	
		*	@param x The xml to parse.
		*	@param target An optional <code>IConfiguration</code>
		*	implementation to parse the data into.
		*	
		*	@return The parsed <code>IConfiguration</code> implementation.
		*/
		function parse(
			x:XML, target:IConfiguration = null ):IConfiguration;
	}
}