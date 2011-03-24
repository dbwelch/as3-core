package org.flashx.utils.substitution {
	
	import org.flashx.errors.AbstractError;
	
	/**
	*	<code>Error</code> thrown when a problem
	*	occurs during processing of
	*	<code>String</code> substitutions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.09.2007
	*/
	public class SubstitutionError extends AbstractError {
		
		/**
		*	<code>Error</code> message thrown when a property
		*	could not be found.
		*/
		static public const LOOKUP_FAILURE:String = 
			"Could not find string replacement property : %s";
		
		/**
		*	<code>Error</code> message thrown when a method
		*	could not be invoked.
		*/			
		static public const METHOD_INVOKE_FAILURE:String = 
			"Error invoking method '%s' on : %s";
			
		//--> duplicate of LOOKUP_FAILURE ???
		/**
		*	<code>Error</code> message thrown when a target
		*	property could not be found.
		*/
		static public const PROPERTY_LOOKUP_FAILURE:String =
			"Property lookup failure, null Object " +
			"encountered in lookup tree with property : %s";
			
		/**
		*	<code>Error</code> message thrown when a target
		*	instance does not have a property.
		*/
		static public const HAS_PROPERTY_FAILURE:String =
			"Property lookup failure, target does not have property: %s";
		
		/**
		*	Creates a <code>SubstitutionError</code>
		*	instance.
		*	
		*	@param message The <code>Error</code> message.
		*	@param ...args The <code>message</code>
		*	substitution values.
		*/
		public function SubstitutionError(
			message:String, ...args:Array )
		{
			super( message, args );
		}
	}
}