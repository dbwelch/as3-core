package org.flashx.utils.byte {
	
	import flash.utils.ByteArray;
	
	import org.flashx.utils.string.StringUtils;
	
	
	/**
	*	Utility methods for converting byte
	*	values to <code>String</code> representations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2007
	*/
	public class ByteStringUtils extends Object {
		
		/**
		*	Constants representing a <code>String</code>
		*	value used to indicate a bit is switched on.
		*/
		static public const BIT_ON:String = "1";
		
		/**
		*	Constants representing a <code>String</code>
		*	value used to indicate a bit is switched off.
		*/		
		static public const BIT_OFF:String = "0";
		
		/**
		*	Default suffixes used when generating a formatted
		*	total bytes value.
		*/		
		static public var FORMAT_SUFFIXES:Array = [
			"KB",
			"MB",
			"GB",
			"TB",
			"PB"
		];
		
		/**
		*	@private	
		*/
		public function ByteStringUtils()
		{
			super();
		}
		
		/**
		*	Gets a formatted <code>String</code> representation
		*	of the number of bytes.
		*	
		*	@example
		*	
		*	<pre>1024 => 1 KB</pre>
		*	
		*	@param bytes The total number of bytes.
		*	@suffixes An <code>Array</code> of suffixes to
		*	use when formatting.
		*	
		*	@return The formatted <code>String</code> value.
		*/
		static public function format(
			bytes:uint = 0,
			suffixes:Array = null ):String
		{
			return StringUtils.formatToDivisorString(
				bytes, 1024, suffixes ? suffixes : FORMAT_SUFFIXES );
		}
		
		/**
		*	Converts a <code>Number</code> to a binary
		*	<code>String</code> representation.
		*	
		*	@example
		*	
		*	<pre>8 => 00001000</pre>
		*	
		*	@param byte The <code>Number</code> to convert.
		*	
		*	@return The converted <code>String</code> representation.
		*/
		static public function toBinaryString( byte:Number ):String
		{
			var len:int = ByteUtils.getBitLength( byte );
			
			var output:String = "";
			
			if( !byte )
			{
				return StringUtils.repeat( BIT_OFF, len );
			}
			
			//maximum value for the bit length
			if( byte == ( Math.pow( 2, len ) - 1 ) )
			{
				output = StringUtils.repeat( BIT_ON, len );
			}else{
			
				var i:int = 0;
				var bitIndexValue:int;
			
				for( ;i < len; i++ )
				{
					bitIndexValue = ByteUtils.getBitIndexValue( len, i );
					
					if( ( byte && ( ( byte / bitIndexValue ) >= 1 ) ) )
					{
						output += BIT_ON;
						byte -= bitIndexValue;
					}else{
						output += BIT_OFF;
					}
				}
			
			}
			
			return output;
		}
		
		/**
		*	Converts a <code>Number</code> to an
		*	uppercase <code>String</code> hexadecimal
		*	representation.
		*	
		*	@param byte The <code>Number</code> to convert.
		*	
		*	@return A hexadecimal <code>String</code> value.
		*/
		static public function toHexString( byte:Number ):String
		{
			var hex:String = byte.toString( 16 );
			
			//zero pad single character values
			if( hex.length == 1 )
			{
				hex = BIT_OFF + hex;
			}
			
			return hex.toUpperCase();
		}
		
		/**
		*	Gets a complex <code>String</code> representation
		*	of the contents of a <code>ByteArray</code>.
		*	
		*	Attempts to get data for all the bytes from the
		*	current position in the <code>ByteArray</code>
		*	until the end of the <code>ByteArray</code> by
		*	default.
		*	
		*	The <code>maximum</code> value indicates a maximum
		*	number of bytes read from the current position and
		*	overrides the default behaviour if non zero.
		*	
		*	@param bytes The source <code>ByteArray</code>.
		*	@param maximum The <code>maximum</code> number
		*	of bytes to read.
		*	@param formatter An <code>IByteDumpFormatter</code> used to format
		*	the output.
		*	
		*	@return A <code>String</code> representation of the
		*	<code>ByteArray</code>.
		*/
		static public function dump(
			bytes:ByteArray,
			maximum:int = 0,
			formatter:IByteDumpFormatter = null ):String
		{
			if( !bytes )
			{
				bytes = new ByteArray();
			}
			
			if( !formatter )
			{
				formatter = new ByteDumpFormatter();
			}
			
			var columns:int = formatter.columns;
			
			var output:String = "";
			
			var pos:uint = bytes.position;
			var cloned:ByteArray = ByteUtils.clone( bytes );
			cloned.position = pos;
			
			var i:int = pos;
			var l:int = bytes.length;
			
			if( maximum && ( maximum <= bytes.length ) )
			{
				l = pos + maximum;
			}
			
			/*
			trace("ByteStringUtils::dump(), i " + i );
			trace("ByteStringUtils::dump(), l " + l );			
			*/
			
			var modAddition:int = ( ( i % 2 ) == 0 ) ? 1 : 0
			
			var byte:uint;
			
			var hex:String;
			var bin:String;
			var char:String;
			var str:String;
			
			for( ;i < l;i++ )
			{
				byte = cloned.readUnsignedByte();
				char = String.fromCharCode( byte );
				
				hex = toHexString( byte );
				bin = toBinaryString( byte );
				
				
				/*
				str = byte + "\t" + bin +
					" " + hex + " " +
					( byte > 13 ? char : "" ) + "\t\t";
				*/
				
				str = formatter.format( byte, char, hex, bin );
				
				output += str;
				
				if( ( i + modAddition ) % columns == 0 )
				{
					output += StringUtils.NEWLINE;
				}
			}
			
			bytes.position = pos;
			
			return output;
		}	
	}	
}