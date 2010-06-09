package com.ffsys.utils.geo
{
	import flash.geom.Vector3D;
	
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
		
		/**
		* 	Gets the optional query string.
		* 
		* 	The query string can be used to retrieve latitude
		* 	and longitude via a web service.
		* 
		* 	@return The query string or null if no query
		* 	string has been set.
		*/
		function get query():String;
		
		/**
		* 	Sets the optional query string.
		* 
		* 	The query string can be used to retrieve latitude
		* 	and longitude via a web service.
		* 
		* 	@param query The query string.
		*/
		function set query( query:String ):void;
		
		/**
		* 	Translates latitude and longitude co-ordinates to 3D space
		* 	co-ordinates.
		* 
		* 	@param radius The radius of the sphere.
		* 	@param latitudeDegreeOffset The amount of degrees to offset the latitude.
		* 	@param longitudeDegreeOffset The amount of degrees to offset the longitude.
		*/
		function getSpherical3DCoordinates(
			radius:Number,
			latitudeDegreeOffset:Number = 90,
			longitudeDegreeOffset:Number = 0 ):Vector3D;
	}
}