package com.ffsys.color
{
	import flash.geom.ColorTransform;
	
	public class RgbColor extends ColorTransform
	{
		
		/**
		* 	Creates a <code>RgbColor</code> instance.
		* 
		* 	@param r The red value.
		* 	@param g The green value.
		* 	@param b The blue value.
		*/
		public function RgbColor( r:uint = 0, g:uint = 0, b:uint = 0 )
		{
			super();
			rgb( r, g, b );
		}
		
		/*
		function tintClip():void {
		var color:uint=picker.selectedColor;
		var mul:Number=slider.value/100;
		var ctMul:Number=(1-mul);
		var ctRedOff:Number=Math.round(mul*extractRed(color));
		var ctGreenOff:Number=Math.round(mul*extractGreen(color));
		var ctBlueOff:Number=Math.round(mul*extractBlue(color));
		ct=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
		clip.transform.colorTransform=ct;
		infoBox.text=String(mul*100)+"%";
		}		
		*/
		
		/**
		* 	Parses a string representation of a colour value
		* 	into this instance.
		*/
		public function parse( hex:String ):uint
		{
			//TODO: account for # notation
			
			this.color = parseInt( hex, 16 );
			
			return this.color;
		}
		
		/**
		* 	Sets this color value from the specified
		* 	red, green and blue color parts.
		* 
		* 	@param r The red value.
		* 	@param g The green value.
		* 	@param b The blue value.
		* 
		* 	@return The resulting decimal value for the color.
		*/
		public function rgb( r:uint, g:uint, b:uint ):uint
		{
			this.color = ( r << 16 | g << 8 | b );
			return this.color;
		}
		
		/**
		* 	Gets the red part of the colour value.
		*/
		public function get red():uint
		{
			return ( ( this.color >> 16 ) & 0xFF );
		}

		/**
		* 	Gets the green part of the colour value.
		*/
		public function get green():uint
		{
			return ( ( this.color >> 8 ) & 0xFF );
		}
		
		/**
		* 	Gets the blue part of the colour value.
		*/
		public function get blue():uint
		{
			return ( this.color & 0xFF );
		}
	}
}