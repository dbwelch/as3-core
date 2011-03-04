package com.ffsys.utils.primitives {
	
	import com.ffsys.utils.boolean.BooleanUtils;
	import com.ffsys.utils.string.StringTrim;
	
	/**
	*	Responsible for parsing string values into the corresponding
	*	primitive value.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.10.2010
	*/
	public class PrimitiveParser extends Object {
		
		/**
		*	Represents the string value for <code>NaN</code>.
		*/
		public static const NAN:String = "NaN";
		
		/**
		*	Represents the string value for <code>null</code>.	
		*/
		public static const NULL:String = "null";		
		
		/**
		*	Represents the string value for <code>undefined</code>.	
		*/
		public static const UNDEFINED:String = "undefined";
		
		/**
		*	Creates a <code>PrimitiveParser</code> instance.
		*/
		public function PrimitiveParser()
		{
			super();
		}
		
		/**
		*	Parses a string value into the corresponding
		*	primitive value.
		*	
		*	When this method is invoked in extended mode, if the
		*	value parsed still remains a string then this method will
		*	attempt to parse the string into an array based on the
		*	specified delimiter.
		*	
		*	Note that the extended array parsing will only create
		*	a flat array, it does not support nested arrays.
		*	
		*	@param value The string value.
		*	@param extended Whether to operate in extended mode.
		*	@param delimiter The delimiter used when parsing arrays.
		*	@stripWhiteSpace Whether leading and trailing whitespace
		*	within array elements should be stripped before sending
		*	the array elements to be parsed to primitives.
		*	
		*	@return A primitive representation of the value
		*	or the input string if no matching primitive could be
		*	found.
		*/
		public function parse(
			value:String,
			extended:Boolean = false,
			delimiter:String = ",",
			stripWhiteSpace:Boolean = true ):*
		{
			if( value == NAN )
			{
				return NaN;
			}else if( value == NULL )
			{
				return null;
			}else if( value == UNDEFINED )
			{
				return undefined;
			}else if( BooleanUtils.stringIsBoolean( value ) )
			{
				return BooleanUtils.stringToBoolean( value );
			}
			
			var numericValue:Number = Number( value );
			
			if( !isNaN( numericValue ) )
			{
				return numericValue;
			}
			
			if( extended && value.indexOf( delimiter ) > -1 )
			{
				return parseArrayValue( value, delimiter, stripWhiteSpace );
			}
			
			return value;
		}
		
		/**
		*	@private	
		*/
		private function parseArrayValue(
			value:String,
			delimiter:String,
			stripWhiteSpace:Boolean = true ):Array
		{
			var parts:Array = value.split( delimiter );
			var value:String = null;
			var trimmer:StringTrim = null;
			for( var i:int = 0;i < parts.length;i++ )
			{
				value = parts[ i ];
				if( stripWhiteSpace )
				{
					value = new StringTrim( value ).trim();
				}
				parts[ i ] = parse( value );
			}
			
			return parts;
		}
	}
}