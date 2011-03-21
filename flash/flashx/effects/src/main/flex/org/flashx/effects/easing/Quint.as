package org.flashx.effects.easing {

	public class Quint {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * ( t = Number( t ) / d ) * t * t * t * t + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * ( ( t = t / d - 1 ) * t * t * t * t + 1 ) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			if ( ( t = Number( t ) / ( d / 2 ) ) < 1 ) return c / 2 * t * t * t * t * t + b;
			return c / 2 * ( ( t = Number( t ) - 2 ) * t * t * t * t + 2 ) + b;
		}
		
	}
	
}