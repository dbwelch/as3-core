package com.ffsys.utils.identifier {
	
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	Utility methods for working with
	*	camel case <code>String</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.10.2007
	*/
	public class CamelCaseUtils extends Object {
		
		/**
		*	@private	
		*/
		public function CamelCaseUtils()
		{
			super();
		}
		
		/**
		*	Determines whether <code>source</code> is a camel
		*	case style <code>String</code>.
		*	
		*	@param source the source <code>String</code> to inspect
		*	
		*	@return a Boolean indicating whether the <code>source</code>
		*	is camel case
		*/
		static public function isCamelCase( source:String = "" ):Boolean
		{
			var re:RegExp = /[a-z][A-Z]+/g;
			var matches:Array = source.match( re );
			return matches && matches.length;
		}
		
		/**
		*	Converts a 
		*
		*	@param str the String to convert to camel case
		*
		*	@return the camel case representation of the String
		*/
		static public function toCamelCase(
			str:String,
			delimiter:String = "_",
			maintainCase:Boolean = false ):String
		{	
			//var re:RegExp = /[a-zA-Z0-9]{1,1}_[a-zA-Z0-9]{1,1}/g;
			
			var re:RegExp = new RegExp( "[a-zA-Z0-9]{1,1}" + delimiter + "[a-zA-Z0-9]{1,1}", "g" );
			
			var output:String = str;
			var matches:Array = str.match( re );
			
			var i:int = 0;
			var l:int = matches.length;
			
			var part:String;
			var replaced:String;
			
			for( ;i < l;i++ )
			{
				part = matches[ i ];
				replaced = part.charAt( 0 ) + part.charAt( 2 ).toUpperCase();
				output = output.replace( part, replaced );
			}
			
			if( !maintainCase )
			{
				str = str.toLowerCase();
			}			
			
			return output;
		}		
		
		/**
		*	Converts a String from a camel case representation to an
		*	underscore separated representation and converts
		*	the entire String to lower case, if you don't the String
		*	to be lower cased specify the second parameter as false.
		*
		*	@param str the String to convert from camel case
		*	@param lowerCase a Boolean indicating whether the output
		*	String should be lowercase
		*
		*	@return the converted underscore separated String 
		*/
		static public function fromCamelCase(
			str:String,
			delimiter:String = "_",
			maintainCase:Boolean = false ):String
		{
			var re:RegExp = /[a-z]{1,1}[A-Z0-9]{1,1}/g;
			var output:String = str;
			var matches:Array = str.match( re );
			
			var i:int = 0;
			var l:int = matches.length;
			
			var part:String;
			var replaced:String;
			
			for( ;i < l;i++ )
			{
				part = matches[ i ];
				replaced = part.charAt( 0 ) + delimiter + part.charAt( 1 ).toLowerCase();
				output = output.replace( part, replaced );
			}
			
			if( !maintainCase )
			{
				output = output.toLowerCase();
			}
			
			return output;
		}
		
		/**
		*	Converts a camel case <code>String</code> representation
		*	to title case. Converting to title case will create
		*	a word boundary using a space wherever a camel case
		*	notation is found and then capitalize the first character
		*	of each resulting word.
		*	
		*	@param source the camel case <code>String</code> to convert
		*	to title case
		*	
		*	@return the converted title case <code>String</code> value
		*/
		static public function camelCaseToTitleCase( source:String = "" ):String
		{
			//seperate into words
			source = source.replace( /([a-z0-9])([A-Z])/g, "$1 $2" );
			source = source.replace( /([a-zA-Z])([0-9])/g, "$1 $2" );
			
			//convert to title case
			return StringUtils.toTitleCase( source );
		}
	}
}