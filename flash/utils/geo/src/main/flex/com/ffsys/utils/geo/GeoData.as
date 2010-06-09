package com.ffsys.utils.geo
{
	import flash.geom.Vector3D;
	
	/**
	*	Encapsulates geographical data including latitude and longitude
	* 	coordinates.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 10.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class GeoData extends Object
		implements IGeoData
	{
		private var _coordinates:IGeoCoordinate;
		private var _query:String;
	
		/**
		* 	Creates a <code>GeoData</code> instance.
		* 
		* 	@param latitude The latitude for the location.
		* 	@param longitude The longitude for the location.
		*/
		public function GeoData(
			latitude:Number = NaN,
			longitude:Number = NaN )
		{
			super();
			this.coordinates = new GeoCoordinate(
				latitude, longitude );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get coordinates():IGeoCoordinate
		{
			return _coordinates;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set coordinates( coordinates:IGeoCoordinate ):void
		{
			_coordinates = coordinates;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get latitude():Number
		{
			if( this.coordinates == null )
			{
				return NaN;
			}
			
			return this.coordinates.latitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set latitude( latitude:Number ):void
		{
			if( this.coordinates != null )
			{
				this.coordinates.latitude = latitude;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get longitude():Number
		{
			if( this.coordinates == null )
			{
				return NaN;
			}			
			
			return this.coordinates.longitude;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set longitude( longitude:Number ):void
		{
			if( this.coordinates != null )
			{
				this.coordinates.longitude = longitude;
			}
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
			lat -= ( latitudeDegreeOffset * ( Math.PI / 180 ) );
			long -= ( longitudeDegreeOffset * ( Math.PI / 180 ) );
			
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