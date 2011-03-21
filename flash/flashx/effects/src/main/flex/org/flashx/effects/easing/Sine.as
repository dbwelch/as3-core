package org.flashx.effects.easing {

	public class Sine {
		
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return -c * Math.cos( t / d * ( Math.PI / 2 ) ) + c + b;
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return c * Math.sin( t / d * ( Math.PI / 2 ) ) + b;
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0 ):Number
		{
			return -c / 2 * ( Math.cos( Math.PI * t / d ) - 1) + b;
		}
	
	}
	
}