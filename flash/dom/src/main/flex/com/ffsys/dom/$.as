package com.ffsys.dom
{	
	/**
	* 	The dollar alias for the asquery implementation.
	* 
	* 	@param query The query object.
	* 
	* 	@return An actionscript DOM query.
	*/	
	public var $:Function = function( query:Object = null ):ActionscriptQuery
	{
		return new ActionscriptQuery().handle( query );
	}
}