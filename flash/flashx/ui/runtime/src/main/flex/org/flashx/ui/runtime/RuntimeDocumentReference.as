package org.flashx.ui.runtime
{
	import org.flashx.core.IStringIdentifier;
	
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
	public class RuntimeDocumentReference extends Object
		implements IStringIdentifier
	{
		private var _id:String;
		private var _property:String;
		
		/**
		* 	The parent object this reference applies to.
		*/
		internal var parent:Object;
		
		/**
		* 	The name of the property to be set on the parent
		* 	when the reference has been resolved.
		*/
		internal var name:String;
		
		/**
		* 	Creates a <code>RuntimeDocumentReference</code> instance.
		*/
		public function RuntimeDocumentReference()
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
		
		/**
		* 	A property path look up to resolve on the target
		* 	object when resolving this reference.
		*/
		public function get property():String
		{
			return _property;
		}
		
		public function set property( value:String ):void
		{
			_property = value;
		}
	}
}