package com.ffsys.effects.easing {

	public class Circ {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return -c * ( Math.sqrt( 1 - ( t = Number( t ) / d ) * t ) - 1 ) + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * Math.sqrt( 1 - ( t = t / d - 1 ) * t ) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			if( ( t = Number( t ) / ( d / 2 ) ) < 1 ) return -c / 2 * ( Math.sqrt( 1 - ( t * t ) ) - 1 ) + b;
			return ( c / 2 ) * ( Math.sqrt( 1 - ( ( t = Number( t ) - 2 ) * t ) ) + 1 ) + b;
		}
	
	}
	
}