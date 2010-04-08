package com.ffsys.utils.reflection.members {
	
	/**
	*	Represents protected member variable.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class ProtectedMemberVariable extends MemberVariable {
		
		public function ProtectedMemberVariable()
		{
			super();
			this.memberType = MemberType.PROTECTED_TYPE;
		}
		
	}
	
}
