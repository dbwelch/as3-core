package com.ffsys.effects.easing {

	public class Cubic {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * ( t = Number( t ) / d ) * t * t + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * ( ( t = t / d - 1 ) * t * t + 1 ) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			if( ( t = Number( t ) / ( d / 2 ) ) < 1 ) return c / 2 * t * t * t + b;
			return c / 2 * ( ( t = Number( t ) - 2 ) * t * t + 2 ) + b;
		}
	
	}
	
}