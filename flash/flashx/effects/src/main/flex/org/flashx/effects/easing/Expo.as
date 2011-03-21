package org.flashx.effects.easing {

	public class Expo {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return ( t == 0 ) ? b : c * Math.pow( 2, 10 * ( t / d - 1 ) ) + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return ( t == d ) ? b + c : c * ( -Math.pow( 2, -10 * t / d ) + 1) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			if( t == 0 ) return b;
			if( t == d ) return b + c;
			if( ( t = Number( t ) / ( d / 2 ) ) < 1) return c / 2 * Math.pow( 2, 10 * ( Number( t ) - 1 ) ) + b;
			return c / 2 * ( -Math.pow( 2, -10 * Number( --t ) ) + 2 ) + b;
		}
	
	}
	
}