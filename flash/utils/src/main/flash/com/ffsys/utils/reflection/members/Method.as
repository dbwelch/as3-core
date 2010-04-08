package com.ffsys.utils.reflection.members {
	
	/**
	*	Encapsulates an instance method of a Class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class Method extends AbstractMethod {
		
		public function Method()
		{
			super();
			this.memberType = MemberType.PUBLIC_TYPE;
		}
		
	}
	
}
