package com.ffsys.effects.easing {

	public class Linear {
		
		static public function easeNone( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return ( ( c * Number( t ) ) / d ) + b;
		}
		
	}
	
}