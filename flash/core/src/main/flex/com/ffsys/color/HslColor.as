package com.ffsys.color
{

	public class HslColor extends RgbColor
	{
		private var _hue:Number = NaN;
		private var _saturation:Number = NaN;
		private var _luminosity:Number = NaN;
		
		/**
		* 	Creates an <code>HslColor</code> instance.
		* 
		* 	@param hue The hue for this color.
		* 	@param saturation The saturation for this color.
		* 	@param luminosity The luminosity for this color.
		*/
		public function HslColor(
			hue:Number = 0,
			saturation:Number = 1,
			luminosity:Number = 1 )
		{
			super();
			hsl( hue, saturation, luminosity );
		}
		
		/**
		* 	Sets the hue, saturation and luminosity of this color.
		* 
		* 	@param hue The hue for this color.
		* 	@param saturation The saturation for this color.
		* 	@param luminosity The luminosity for this color.
		* 
		* 	@return The decimal value of this color.
		*/
		public function hsl(
			hue:Number = 0,
			saturation:Number = 1,
			luminosity:Number = 1 ):uint
		{
			var hsl:HslColorDefinition = toHsl();
			hsl.hue = hue;
			hsl.saturation = saturation;
			hsl.luminosity = luminosity;
			fromHsl( hsl );
			return this.color;
		}
		
		/**
		* 	The hue of this colour in the range
		* 	0 to 360.
		*/
		public function get hue():Number
		{
			if( isNaN( _hue ) )
			{
				return toHsl().hue;
			}
			return _hue;
		}
		
		public function set hue( value:Number ):void
		{
			var hsl:HslColorDefinition = new HslColorDefinition(
				value, this.saturation, this.luminosity );
			fromHsl( hsl );
			_hue = value;
		}
		
		/**
		* 	The saturation of this colour in the range
		* 	0 to 1.
		*/
		public function get saturation():Number
		{
			if( isNaN( _saturation ) )
			{
				return toHsl().saturation;
			}
			return _saturation;
		}
		
		public function set saturation( value:Number ):void
		{
			var hsl:HslColorDefinition = new HslColorDefinition(
				this.hue, value, this.luminosity );		
			hsl.saturation = value;			
			fromHsl( hsl );
			_saturation = value;
		}
		
		/**
		* 	The luminosity of this colour in the range
		* 	0 to 1.
		*/
		public function get luminosity():Number
		{
			if( isNaN( _luminosity ) )
			{
				return toHsl().luminosity;
			}
			return _luminosity;
		}
		
		public function set luminosity( value:Number ):void
		{
			var hsl:HslColorDefinition = new HslColorDefinition(
				this.hue, this.saturation, value );
			hsl.luminosity = value;		
			fromHsl( hsl );	
			_luminosity = value;			
		}
		
		private function fromHsl( definition:HslColorDefinition ):void
		{
			var h:Number = definition.hue;
			var s:Number = definition.saturation
			var v:Number = definition.luminosity;
			
		    var r:Number = 0;
		    var g:Number = 0;
		    var b:Number = 0;

		    var tempS:Number = s;
		    var tempV:Number = v;

		    var hi:int = Math.floor( h / 60 ) % 6;
		    var f:Number = h / 60 - Math.floor( h / 60 );
		
		    var p:Number = (tempV * (1 - tempS));
		    var q:Number = (tempV * (1 - f * tempS));
		    var t:Number = (tempV * (1 - (1 - f) * tempS));

		    switch(hi){
		        case 0: r = tempV; g = t; b = p; break;
		        case 1: r = q; g = tempV; b = p; break;
		        case 2: r = p; g = tempV; b = t; break;
		        case 3: r = p; g = q; b = tempV; break;
		        case 4: r = t; g = p; b = tempV; break;
		        case 5: r = tempV; g = p; b = q; break;
		    }
			
			//update our colour value based on the calculated RGB
		    this.rgb(
				Math.round( r * 255 ),
				Math.round( g * 255 ),
				Math.round( b * 255 ) );
		}
		
		
		/*
		
		RGB values between 0 to 255
		Hexadecimal in RRGGBB format
		Hue values between 0 to 360
		Saturation and Value between 0 to 100
		
		*/
		
		/**
		* 	@private
		* 
		* 	Gets a representation of this color as an
		* 	HSL color.
		*/
		private function toHsl():HslColorDefinition
		{
			var r:uint = this.red;
			var g:uint = this.green;
			var b:uint = this.blue;
			
		    var max:uint = Math.max( r, g, b );
		    var min:uint = Math.min( r, g, b );

		    var hue:Number = 0;
		    var saturation:Number = 0;
		    var value:Number = 0;

		    if(max == min){
		        hue = 0;
		    }else if(max == r){
		        hue = (60 * (g-b) / (max-min) + 360) % 360;
		    }else if(max == g){
		        hue = (60 * (b-r) / (max-min) + 120);
		    }else if(max == b){
		        hue = (60 * (r-g) / (max-min) + 240);
		    }
		    value = max;
		    if(max == 0){
		        saturation = 0;
		    }else{
		        saturation = (max - min) / max;
		    }
		    return new HslColorDefinition(
				Math.round(hue),
				saturation,
				value / 255 );
		}		
	}
}

class HslColorDefinition {
	
	public var hue:Number;
	public var saturation:Number;
	public var luminosity:Number;
	
	/**
	* 	Creates a <code>HslColorDefinition</code> instance.
	*/
	public function HslColorDefinition(
		hue:Number = 0,
		saturation:Number = 1,
		luminosity:Number = 1 )
	{
		super();
		this.hue = hue;
		this.saturation = saturation;
		this.luminosity = luminosity;		
	}
}