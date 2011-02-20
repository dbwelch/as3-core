package java.nio.charset
{
	/**
	* 	A typesafe enumeration for coding-error actions.
	* 
	* 	Instances of this class are used to specify how
	* 	malformed-input and unmappable-character errors
	* 	are to be handled by charset decoders and encoders.
	*/
	public class CodingErrorAction extends Object
	{
		/**
		* 	Action indicating that a coding error is to be handled
		* 	by dropping the erroneous input and resuming the coding operation.
		*/
		public static const IGNORE:CodingErrorAction = new CodingErrorAction( "IGNORE" );
		
		/**
		*	Action indicating that a coding error is to be handled by
		* 	dropping the erroneous input, appending the coder's replacement
		* 	value to the output buffer, and resuming the coding operation.
		*/
		public static const REPLACE:CodingErrorAction = new CodingErrorAction( "REPLACE" );		
		
		/**
		* 	Action indicating that a coding error is to be reported, either
		* 	by returning a CoderResult object or by throwing a CharacterCodingException,
		* 	whichever is appropriate for the method implementing the coding process.
		*/
		public static const REPORT:CodingErrorAction = new CodingErrorAction( "REPORT" );
		
		private var _value:String;
		
		/**
		* 	@private
		* 
		* 	Creates a <code>CodingErrorAction</code> instance.
		* 
		* 	@param value The value for the error action.
		*/
		public function CodingErrorAction( value:String )
		{
			super();
		}
		
		/**
		* 	Returns a string describing this action.
		* 
		* 	@return A descriptive string.
		*/
		public function toString():String
		{
			return _value;
		}
	}
}