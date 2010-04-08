package com.ffsys.utils.reflection {
	
	/**
	*	Represents the factory node present when calling
	*	describeType() on a Class rather than an instance
	*	of a Class.
	*
	*	When a Reflection encounters a factory node it attempts
	*	to create a new instance of the Class and pass it to the
	*	Factory constructor.
	*
	*	This enables calls to describeType() that are Class
	*	references to contain information pertaining to an instance
	*	of the Class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Factory extends Reflection {
		
		public function Factory( target:Object )
		{
			super( target );
		}
		
	}
	
}
