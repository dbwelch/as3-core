package com.ffsys.effects.easing {

	public class Back {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, s:Number = 1.70158 ):Number
		{
			return c * ( t = Number( t ) / d ) * t * ( ( s + 1 ) * t - s ) + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, s:Number = 1.70158 ):Number
		{
			return c * ( ( t = t / d - 1 ) * t * ( ( s + 1 ) * t + s ) + 1) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, s:Number = 1.70158 ):Number
		{
			if( ( t = Number( t ) / ( d / 2 ) ) < 1 ) return c / 2 * ( t * t * ( ( ( s = Number( s ) * ( 1.525 ) ) + 1 ) * t - s ) ) + b;
			return c / 2 * ( ( t = Number( t ) - 2 ) * t * ( ( ( s = Number( s ) * ( 1.525 ) ) + 1 ) * t + s ) + 2 ) + b;
		}
	
	}
	
}