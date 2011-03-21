package org.flashx.effects.easing {

	public class Elastic {
	
		static public function easeIn( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, a:Number = 0, p:Number = 0 ):Number
		{
			var s:Number;
		
			if( t == 0 ) return b;
			if( ( t = Number( t ) / d ) == 1 ) return b + c;
			if( !p ) p = d * .3;
			if ( !a || a < Math.abs( c ) )
			{
				a = c;
				s = p / 4;
			}else{
				s = p / ( 2 * Math.PI ) * Math.asin( c / a );
			}
			
			return -( a * Math.pow( 2, 10 * ( t = Number( t ) - 1 ) ) * Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) ) + b;
					
		}
		
		static public function easeOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, a:Number = 0, p:Number = 0 ):Number
		{
			var s:Number;
			
			if( t == 0 ) return b;
			if( ( t = Number( t ) / d ) == 1 ) return b + c;
			if( !p ) p = d * .3;
			if( !a || a < Math.abs( c ) )
			{
				a = c;
				s = p / 4;
			}else{
				s = p / ( 2 * Math.PI ) * Math.asin( c / a );
			}
			
			return ( a * Math.pow( 2, -10 * Number( t ) ) * Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) + c + b );
		}
		
		static public function easeInOut( t:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0, a:Number = 0, p:Number = 0 ):Number
		{
			var s:Number;
			
			if( t == 0 ) return b;
			if( ( t = Number( t ) / ( d / 2 ) ) == 2 ) return b + c;
			if( !p ) p = d * ( .3 * 1.5 );
			if( !a || a < Math.abs( c ) )
			{
				a = c;
				s = p / 4;
			}else{
				s = p / ( 2 * Math.PI ) * Math.asin( c / a );
			}
			
			if( t < 1 ) return -.5 * ( a * Math.pow( 2, 10 * ( t = Number( t ) - 1 ) ) * Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) ) + b;
			return a * Math.pow( 2, -10 * ( t = Number( t ) - 1 ) ) * Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) * .5 + c + b;
		}
	
	}
	
}