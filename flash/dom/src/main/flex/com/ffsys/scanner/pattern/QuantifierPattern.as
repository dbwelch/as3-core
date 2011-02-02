package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a qualifier rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class QuantifierPattern extends MetaCharacter
	{
		/**
		* 	Creates a <code>QuantifierPattern</code> instance.
		* 
		* 	@param char The character representing the qualifier.
		*/
		public function QuantifierPattern( char:String = null )
		{
			super( char );
		}
	}
}