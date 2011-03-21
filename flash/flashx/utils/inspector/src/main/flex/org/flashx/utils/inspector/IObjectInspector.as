package org.flashx.utils.inspector {
	
	/**
	*	Describes the contract for instances that expose
	*	a string representation of their state.
	*	
	*	Instances that implement this interface expose
	*	both simple and complex representations of their
	*	internal state. This allows for easy inspection
	*	of instances at runtime.
	*	
	*	Implementing this interface in a super class allows
	*	for sub-implementors to override the appropriate
	*	methods to change their string representation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public interface IObjectInspector {
		
		/**
		*	@private
		*	
		*	Gets an <code>Object</code> whose properties correspond
		*	to member names of methods that should be exposed
		*	in the complex string representation of the instance.
		*	
		*	@return An <code>Object</code> containing the instance
		*	methods and values to expose.
		*/
		function getCommonStringOutputMethods():Object;
		
		/**
		*	@private
		*	
		*	Gets an <code>Object</code> whose properties
		*	correspond to the properties that should be
		*	exposed in the complex string representation
		*	of the instance.
		*	
		*	@return An <code>Object</code> containing the
		*	properties and values to expose.
		*/
		function getCommonStringOutputProperties():Object;
		
		/**
		*	@private
		*	
		*	Gets an <code>Array</code> of composite complex
		*	instances that should also be included in the
		*	complex representation of this instance.
		*	
		*	@return An <code>Array</code> of composite instances.
		*/
		function getCommonStringOutputComposites():Array;
		
		/**
		*	@private
		*	
		*	Gets the complex representation of this instance.
		*	
		*	@return A <code>String</code> representing this instance.
		*/
		function toObjectString():String;
		
		/**
		*	@private
		*	
		*	Gets a simple representation of this instance.
		*	
		*	@return A <code>String</code> representing this instance.
		*/
		function toSimpleString():String;
		
		/**
		*	@private
		*	
		*	Gets either a simple or complex representation
		*	of this instance.
		*	
		*	@param simple Indicates whether the returned value should be
		*	simple or complex.
		*	
		*	@return A <code>String</code> representing this instance.	
		*/
		function getObjectString( simple:Boolean = true ):String;
		
		/*
		*	@private
		*	
		*	IObjectInspector example implementation, provided a copy and
		*	paste set of default methods to declare in a super class and
		*	override in sub classes where appropriate.
		*/
		
		/*
		
		//--> Simplest implementation.
		
		//--> imports
		//import org.flashx.utils.inspector.IObjectInspector;
		//import org.flashx.utils.inspector.ObjectInspector;
		//import org.flashx.utils.inspector.ObjectInspectorOptions;
		//import org.flashx.utils.inspector.IObjectInspectorClassName;
		
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			return output;
		}

		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			//add a detail Object if necessary
			//output.detail = new Object();
			
			//pass in the default methods, properties and composites
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		public function toString():String
		{
			//return getObjectString( true );
			return getObjectString();
		}
		*/
	}
	
}
