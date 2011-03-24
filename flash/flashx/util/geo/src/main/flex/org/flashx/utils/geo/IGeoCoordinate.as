package org.flashx.utils.geo
{	
	/**
	*	Describes the contract for instances that represent
	* 	a geographical location using latitude and longitude
	* 	expressed in decimal degrees.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 10.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public interface IGeoCoordinate
	{
		/**
		* 	Gets the latitude for the location.
		* 
		* 	@return The location latitude.
		*/
		function get latitude():Number;
		
		/**
		* 	Sets the latitude for the location.
		* 
		* 	@param latitude The location latitude.
		*/
		function set latitude( latitude:Number ):void;
		
		/**
		* 	Gets the longitude for the location.
		* 
		* 	@return The location longitude.
		*/
		function get longitude():Number;
		
		/**
		* 	Sets the longitude for the location.
		* 
		* 	@param longitude The location longitude.
		*/
		function set longitude( longitude:Number ):void;
	}
}