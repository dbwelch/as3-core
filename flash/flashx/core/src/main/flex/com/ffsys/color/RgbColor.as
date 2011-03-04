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
		
		/**
		* 	Tints this colour.
		* 	
		* 	@param color The colour to use for the tint.
		* 	@param amount The amount of tint to apply in the range
		* 	0 to 1.
		*/
		public function tint(
			color:uint = NaN,
			amount:Number = 1 ):void
		{
			if( isNaN( color ) )
			{
				color = this.color;
			}
			
			//invert the amount
			var inverted:Number = ( 1 - amount );
			var tintRed:Number = Math.round( amount * getRed( color ) );
			var tintGreen:Number = Math.round( amount * getGreen( color ) );
			var tintBlue:Number = Math.round( amount * getBlue( color ) );

			this.redMultiplier = this.greenMultiplier = this.blueMultiplier = inverted;
			this.alphaMultiplier = 1;
			this.redOffset = tintRed;
			this.greenOffset = tintGreen;
			this.blueOffset = tintBlue;
			this.alphaOffset = 0;
		}
		
		/**
		* 	The brightness of this colour in the range 0 to 1.
		*/
	    public function get brightness():Number
	    {
	        return this.redOffset ? ( 1 - this.redMultiplier ) : ( this.redMultiplier - 1 );
	    }

		public function set brightness( value:Number ):void
		{
			if ( value > 1 ) 
			{
				value = 1;
			}else if( value < -1 )
			{
				value = -1;
			}
			var percent:Number = 1 - Math.abs( value );
			var offset:Number = 0;
			if( value > 0 )
			{
				offset = value * 255;
			}
			
			this.redMultiplier = this.greenMultiplier = this.blueMultiplier = percent;
			this.redOffset     = this.greenOffset     = this.blueOffset     = offset;
		}		
		
		/**
		* 	Parses a string representation of a colour value
		* 	into this instance.
		* 
		* 	@param hex A string representing a hexadecimal colour.
		* 
		* 	@return The parsed decimal value.
		*/
		public function parse( hex:String ):uint
		{
			//TODO: account for # notation
			
			this.color = parseInt( hex, 16 );
			
			return this.color;
		}
		
		/**
		* 	Sets this color value from the specified
		* 	red, green and blue colour parts.
		* 
		* 	@param r The red value.
		* 	@param g The green value.
		* 	@param b The blue value.
		* 
		* 	@return The resulting decimal value for the colour.
		*/
		public function rgb( r:uint, g:uint, b:uint ):uint
		{
			this.color = ( r << 16 | g << 8 | b );
			return this.color;
		}
		
		/**
		* 	Gets the red part of this colour.
		*/
		public function get red():uint
		{
			return getRed( this.color );
		}

		/**
		* 	Gets the green part of this colour.
		*/
		public function get green():uint
		{
			return getGreen( this.color );
		}
		
		/**
		* 	Gets the blue part of this colour.
		*/
		public function get blue():uint
		{
			return getBlue( this.color );
		}
		
		/**
		* 	Gets the red part of a colour.
		* 
		* 	@param color The decimal colour.
		* 
		* 	@return The red part of the colour.
		*/
		public function getRed( color:uint = 0 ):uint
		{
			return ( ( color >> 16 ) & 0xFF );
		}
		
		/**
		* 	Gets the green part of a colour.
		* 
		* 	@param color The decimal colour.
		* 
		* 	@return The green part of the colour.
		*/
		public function getGreen( color:uint = 0 ):uint
		{
			return ( ( color >> 8 ) & 0xFF );
		}
		
		/**
		* 	Gets the blue part of a colour.
		* 
		* 	@param color The decimal colour.
		* 
		* 	@return The blue part of the colour.
		*/
		public function getBlue( color:uint = 0 ):uint
		{
			return ( color & 0xFF );
		}						
	}
}