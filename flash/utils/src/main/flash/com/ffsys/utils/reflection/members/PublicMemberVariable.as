package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.reflection.Reflection;
	
	/**
	*	Encapsulates a variable (public member) contained by an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class PublicMemberVariable extends MemberVariable {
		
		public function PublicMemberVariable()
		{
			super();
			this.memberType = MemberType.PUBLIC_TYPE;
		}
		
	}
	
}
