package com.ffsys.utils.substitution {
	
	/**
	*	Represents a string substitution setting.
	*
	*	A String substitution takes the form of a dot-style
	*	property lookup enclosed in curly braces:
	*
	*	{object.property}
	*
	*	During XML deserialization this can occur
	*	(in any attribute or node text value) zero or more times.
	*
	*	By default the DeserializerInterpreter attempts to
	*	lookup the referenced property in the deserialized
	*	Object structure.
	*
	*	In addition, by default this lookup behaviour calls toString()
	*	on the referenced instance if it can be found, otherwise
	*	it leaves the original String intact - unless the
	*	DeserializeInterpreter instance is set to perform
	*	strict String substitution, in which case a runtime
	*	error is thrown if the target instance cannot be located.
	*
	*	Adding custom Binding instances
	*	allows us to specify prefixes for these substitutions.
	*
	*	The prefix takes the form of:
	*
	*	{string:object.property}
	*
	*	A prefix is associated with a root Object instance to
	*	perform the property lookup on. And an optional String
	*	method name can specify a method to call on the penultimate
	*	instance passing a String of the last node as the sole
	*	argument to the method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.07.2007
	*/
	public class Binding extends Object
		implements IBinding {
		
		static public var DELIMITER:String = ":";
		
		private var _prefix:String;
		private var _target:Object;
		private var _methodName:String;
		private var _methodParts:int;
		
		public function Binding(
			prefix:String,
			target:Object,
			methodName:String = null,
			methodParts:int = 0 )
		{
			super();
			_prefix = prefix;
			_target = target;
			_methodName = methodName;
			_methodParts = methodParts;
		}
		
		public function set prefix( val:String ):void
		{
			_prefix = val;
		}
		
		public function get prefix():String
		{
			return _prefix;
		}
		
		
		public function set target( val:Object ):void
		{
			_target = val;
		}		
		
		public function get target():Object
		{
			return _target;
		}
		
		
		public function set methodName( val:String ):void
		{
			_methodName = val;
		}		
		
		public function get methodName():String
		{
			return _methodName;
		}
		
		
		public function set methodParts( val:int ):void
		{
			_methodParts = val;
		}
		
		public function get methodParts():int
		{
			return _methodParts;
		}
		
		public function merge( substitutionNamespace:IBinding ):void
		{
			this.prefix = substitutionNamespace.prefix;
			this.target = substitutionNamespace.target;
			this.methodName = substitutionNamespace.methodName;
			this.methodParts = substitutionNamespace.methodParts;
		}
		
		public function clone():IBinding
		{
			return new Binding(
				prefix,
				target,
				methodName,
				methodParts );
		}
	}
}