package com.ffsys.utils.string
{
	/**
	*	Converter responsible for converting an input value to
	* 	a valid property name.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.10.2010
	*/
	public class PropertyNameConverter extends Object
		implements IStringConverter
	{
		/**
		* 	Creates a <code>PropertyNameConverter</code> instance.
		*/
		public function PropertyNameConverter()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function convert( value:String ):String
		{
			if( value.indexOf( "-" ) > -1 )
			{
				var parts:Array = value.split( "-" );
				var output:String = "";
				for( var i:int = 0;i < parts.length;i++ )
				{
					output += StringUtils.firstCharToUpperCase( parts[ i ] );
				}
				value = StringUtils.firstCharToLowerCase( output );
			}
			
			return value;
		}
	}
}