package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.reflection.AbstractReflectionCollection;
	
	/**
	*	Encapsulates the variables or public member properties of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class Variables extends AbstractReflectionCollection {
		
		public function Variables()
		{
			super();
		}
		
		public function hasVariable( variableName:String ):Boolean
		{
			return hasMember( variableName );
		}
		
	}
	
}
