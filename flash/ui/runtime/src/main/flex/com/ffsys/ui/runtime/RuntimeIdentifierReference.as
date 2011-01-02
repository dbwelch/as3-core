package com.ffsys.ui.runtime
{
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Represents a reference to an instance of a bean
	* 	within a runtime document by identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public class RuntimeIdentifierReference extends Object
		implements IStringIdentifier
	{
		private var _id:String;
		
		/**
		* 	The parent object this reference applies to.
		*/
		public var parent:Object;
		
		/**
		* 	The name of the property to be set on the parent
		* 	when the reference has been resolved.
		*/
		public var name:String;
		
		/**
		* 	Creates a <code>RuntimeIdentifierReference</code> instance.
		*/
		public function RuntimeIdentifierReference()
		{
			super();
		}
		
		/**
		* 	The identifier of the implementation that
		* 	this reference refers to.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
	}
}