package com.ffsys.css
{
	
	/**
	*	Describes the contract for implementations that
	* 	wish to be notified of a style object just before
	* 	the style properties are assigned to the target.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public interface ICssStyleInterceptor
	{
		/**
		* 	Allows targets that are having a style object
		* 	applied to perform modifications to a style
		* 	object just before the style properties are set.
		* 
		* 	@param style The style about to be applied.
		* 
		* 	@return The implementation should either return
		* 	the source style intact or a modified version.
		*/
		function doWithStyleObject( style:Object ):Object;
	}
}