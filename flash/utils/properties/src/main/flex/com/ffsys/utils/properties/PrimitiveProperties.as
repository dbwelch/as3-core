package com.ffsys.utils.properties {

	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.primitives.PrimitiveParser;
	
	/**
	*	Represents a collection of properties that supports
	* 	primitive data types.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	dynamic public class PrimitiveProperties extends Properties{
		
		/**
		*	Creates a <code>PrimitiveProperties</code> instance.
		*	
		*	@param locale A locale associated with these properties.
		*/
		public function PrimitiveProperties( locale:ILocale = null )
		{
			super( locale );
			_types = [ IProperties, String, Number, Boolean, Array ];
		}
		
		/**
		* 	Performs parsing of the property value.
		* 
		* 	This implementation attempts to convert the property
		* 	value to a primitive.
		* 
		* 	@param name The name of the property.
		* 	@param value The value of the property.
		* 
		* 	@return The parsed property value.
		*/
		override protected function getPropertyValue(
			name:String, value:Object ):Object
		{
			if( value is String )
			{
				//TODO : investigate why the values are padded with a space on either side
				//trace("PrimitiveProperties::getPropertyValue()", "'", value, "'" );
				
				var input:String = value as String;
				input = input.replace( /^\s+/, "" );
				input = input.replace( /\s+$/, "" );
				
				//trace("PrimitiveProperties::getPropertyValue() parsing input: ", input );
				
				//TODO: instantiate and destroy this parser when the object lifecycle is fixed
				var parser:PrimitiveParser = new PrimitiveParser();
				return parser.parse( input, true );
			}
			return value;
		}
	}
}