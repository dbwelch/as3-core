package org.flashx.utils.geo
{
	/**
	*	Represents a geographical location using a latitude
	* 	and longitude specified in decimal degrees.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 10.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class GeoCoordinate extends Object
		implements IGeoCoordinate
	{
		private var _latitude:Number = NaN;
		private var _longitude:Number = NaN;
	
		/**
		* 	Creates a <code>GeoCoordinate</code> instance.
		* 
		* 	@param latitude The latitude for the location.
		* 	@param longitude The longitude for the location.
		*/
		public function GeoCoordinate(
			latitude:Number = NaN,
			longitude:Number = NaN )
		{
			super();
			this.latitude = latitude;
			this.longitude = longitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get latitude():Number
		{
			return _latitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set latitude( latitude:Number ):void
		{
			_latitude = latitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get longitude():Number
		{
			return _longitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set longitude( longitude:Number ):void
		{
			_longitude = longitude;
		}
	}
}