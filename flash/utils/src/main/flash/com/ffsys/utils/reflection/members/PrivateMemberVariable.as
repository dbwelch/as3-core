package com.ffsys.utils.reflection.members {
	
	/**
	*	Represents a private member variable.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class PrivateMemberVariable extends MemberVariable {
		
		public function PrivateMemberVariable()
		{
			super();
			this.memberType = MemberType.PRIVATE_TYPE;
		}
		
	}
	
}
