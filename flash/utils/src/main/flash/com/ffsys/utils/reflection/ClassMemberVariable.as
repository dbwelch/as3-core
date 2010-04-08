package com.ffsys.utils.reflection {
	
	/**
	*	Class that encapsulates a class level member variable.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class ClassMemberVariable extends ClassMember {
		
		public function ClassMemberVariable()
		{
			super();
		}
		
		public function get value():*
		{
			return Reflection( parent ).target[ name ];
		}
		
	}
	
}
