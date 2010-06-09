package com.ffsys.utils.geo
{
	import flash.geom.Vector3D;
	
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
	{
		private var _latitude:Number;
		private var _longitude:Number;
		private var _query:String;
	
		/**
		* 	Creates a <code>GeoCoordinate</code> instance.
		* 
		* 	@param latitude The latitude for the location.
		* 	@param longitude The longitude for the location.
		*/
		public function GeoCoordinate( latitude:Number = 0, longitude:Number = 0 )
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
		
		/**
		* 	@inheritDoc
		*/
		public function get query():String
		{
			return _query;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set query( query:String ):void
		{
			_query = query;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getSpherical3DCoordinates(
			radius:Number,
			latitudeDegreeOffset:Number = 90,
			longitudeDegreeOffset:Number = 0 ):Vector3D
		{
			//Convert latitude and longitude to radians.
			var lat:Number = Math.PI * this.latitude / 180;
			var long:Number = Math.PI * this.longitude / 180;
			
			//Adjust latitude and longitude by radians.
			lat -= ( latitudeDegreeOffset * ( Math.PI / 180 ) ); // offset latitude by n degrees (in radians).
			long -= ( longitudeDegreeOffset * ( Math.PI / 180 ) ); // offset longitude by n degrees (in radians).
			
			//Spherical to cartesian coordinate conversion formula.
			
			//----		r (radius)				----//
			//----		θ (theta) = latitude	----//
			//----		φ (phi) = longitude		----//
			
			//----		x = r sin θ cos φ		----//
			//----		y = r sin θ sin φ		----//
			//----		z = r cos θ				----//
			
			var x:Number = radius * Math.sin( lat ) * Math.cos( long );
			var y:Number = radius * Math.sin( lat ) * Math.sin( long );
			var z:Number = radius * Math.cos( lat );
			
			//Switch z and y (since z is forward) (see the right-hand rule).
			return new Vector3D( x, z, y );
		}
	}
}