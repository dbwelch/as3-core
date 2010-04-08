package com.ffsys.utils.reflection {
	
	/**
	*	Represents a member of a Class whether it be a
	*	constant, public variable or static method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class ClassMember extends AbstractReflection {
		
		private var _name:String;
		
		public function ClassMember()
		{
			super();
		}
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}		
		
	}
	
}
