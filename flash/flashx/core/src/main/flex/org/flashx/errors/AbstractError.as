package org.flashx.errors {

	import org.flashx.utils.string.StringSubstitutor;
	
	/**
	*	Super class for all custom
	*	<code>Error</code> instances.
	*	
	*	Allows for substitution of <code>%s</code> instances
	*	within the error message <code>String</code> to be
	*	replaced with relevant information pertaining to
	*	the error encountered.
	*	
	*	@see com.ffsys.utils.string.StringSubstitutor
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2007
	*/
	public class AbstractError extends Error {
		
		//
		private var _code:uint = 0;	
	
		/**
		*	Creates an <code>AbstractError</code>
		*	instance.
		*	
		*	@param message The <code>Error</code> message.
		*	@param substitutions The <code>message</code>
		*	substitution values.
		*/
		public function AbstractError(
			message:String = "",
			substitutions:Array = null,
			code:int = 0 )
		{	
			var substitutor:StringSubstitutor = 
				new StringSubstitutor();
			message = substitutor.replace( message, substitutions );
			this.code = code;
			super( message, code );
		}
		
		/**
		* 	Ensures that the error identifier
		* 	reflects the <code>code</code> property.
		*/
		override public function get errorID():int
		{
			return int( code );
		}
		
		/**
		* 	The code for this error.
		*/
		public function get code():uint
		{
			return _code;
		}
		
		public function set code( value:uint ):void
		{
			_code = value;
		}
	}
}