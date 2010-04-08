package com.ffsys.utils.reflection {
	
	import com.ffsys.utils.reflection.members.Constructor;
	
	import com.ffsys.utils.reflection.members.Methods;
	import com.ffsys.utils.reflection.members.Accessors;
	import com.ffsys.utils.reflection.members.Variables;
	
	/**
	*	Describes the interface for IReflection instances that provide
	*	an API for querying the information about the Class they represent.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public interface IReflector {
		
		/**
		*	Gets the underlying target Object that created the Reflection.
		*/
		function get target():Object;		
		
		/**
		*	Gets the inheritance hierarchy for the Object.
		*/
		function get inheritance():Inheritance;
		
		/**
		*	Gets the interfaces implemented by the Object.
		*/
		function get interfaces():Interfaces;
		
		/**
		*	Gets a reference to the Constructor function for the Object.
		*/
		function get constructorFunction():Constructor;
		
		/**
		*	Gets all methods declared on the Object.
		*/
		function get methods():Methods;
		
		/**
		*	Gets all accessors declared on the Object.
		*/
		function get accessors():Accessors;
		
		/**
		*	Gets all the member variables of the Object.
		*/
		function get variables():Variables;
		
		/**
		*	Gets the Class of the super class.
		*/
		function getSuperClass():Class;
		
		/**
		*	Gets the String name of the super class.
		*/
		function getSuperClassName():String;
		
		/**
		*	Gets an Array of all the member instances. Essentially
		*	concatenates the Methods, Accessors and Variables together
		*	and returns the result.
		*/
		//function getMembers():Array;	
		
		/**
		*	Determines whether the underlying target Object is a Class.
		*/
		function isClass():Boolean;
		
		/**
		*	Determines whether the class is static.
		*
		*	@return a Boolean indicating whether the Class is static
		*/
		function isStaticClass():Boolean;
		
		/**
		*	Determines whether the class is final.
		*
		*	@return a Boolean indicating whether the Class is final		
		*/		
		function isFinalClass():Boolean;
		
		/**
		*	Determines whether the class is dynamic.
		*
		*	@return a Boolean indicating whether the Class is dynamic
		*/		
		function isDynamicClass():Boolean;	
		
		/**
		*	Determines whether this Class inherits from another Class.
		*
		*	@param classReference a Class to test for existence in the inheritance hierarchy
		*
		*	@return a Boolean indicating if the given Class is a super class of this Class
		*/
		function inherits( classReference:Class ):Boolean;
		
		/**
		*	Determines whether this Class adheres to a given interface.
		*
		*	@param classReference a Class to test for existence in the implemented interfaces
		*
		*	@return a Boolean indicating if the given interface Class is implemented by this Class
		*/
		function adheres( classReference:Class ):Boolean;
		
		/**
		*	Determines whether the target Object is a plain Object
		*	instance.
		*
		*	@return a Boolean indicating whether the target Object was
		*	constructed using the Object Class or the target Object is
		*	the Object Class.
		*/
		function isObject():Boolean;
		
		/**
		*	Gets an Array of String names of all the methods of this Class.
		*
		*	@return an Array of the method names
		*/
		function getMethodNames():Array;
		
		/**
		*	Gets an Array of String names of all the accessor methods of this Class.
		*
		*	@return an Array of the accessor method names
		*/
		function getAccessorNames():Array;
		
		/**
		*	Gets an Array of String names of all the variables of this Class.
		*
		*	@return an Array of the accessor method names
		*/		
		function getVariableNames():Array;
		
		/**
		*	Gets an Array of String names of all members of this Class.
		*
		*	@return an Array of the member names
		*/		
		function getMemberNames():Array;
		
		/**
		*	Gets an Array of Function references for all the methods
		*	declared on this Class.
		*/
		function getMethods():Array;
		
		/**
		*	Gets a method definition based on the memberName.
		*
		*	@return a Function reference of the method
		*/
		function getMethod( memberName:String ):Function;
		
		/**
		*	Determines whether the target Object implements
		*	any interfaces.
		*
		*	@return a Boolean indicating whether any interfaces
		*	are implemented
		*/
		function hasInterfaces():Boolean;
		
		/**
		*	Determines whether the target Object has any
		*	methods declared.
		*
		*	@return a Boolean indicating whether any
		*	methods are declared
		*/
		function hasMethods():Boolean;
		
		/**
		*	Determines whether the target Object has any
		*	accessor methods declared.
		*
		*	@return a Boolean indicating whether any
		*	accessor methods are declared
		*/
		function hasAccessors():Boolean;
		
		/**
		*	Determines whether the target Object has any
		*	public member variables declared.
		*
		*	@return a Boolean indicating whether any
		*	public member variables are declared
		*/
		function hasVariables():Boolean;
		
		/**
		*	Determines whether a method of a given
		*	name exists on the target Object.
		*
		*	@param the methodName to test for existence
		*
		*	@return a Boolean indicating whether the method exists
		*/
		function hasMethod( methodName:String ):Boolean;
		
		/**
		*	Determines whether an accessor method of a given
		*	name exists on the target Object.
		*
		*	@param the methodName to test for existence
		*
		*	@return a Boolean indicating whether the accessor method exists
		*/
		function hasAccessor( accessorName:String ):Boolean;
		
		/**
		*	Determines whether a variable of a given
		*	name exists on the target Object.
		*
		*	@param the methodName to test for existence
		*
		*	@return a Boolean indicating whether the method exists
		*/
		function hasVariable( variableName:String ):Boolean;		
		
		/**
		*	Gets an Object with the keys being the name of the member
		*	and the values being the corresonding IMethod instance.
		*/
		//function getMethodObject():Object;
		
		/**
		*	Gets an Object with the keys being the name of the member
		*	and the values being the corresonding IMemberVariable instance.
		*/		
		//function getVariableObject():Object;
		
		/**
		*	Gets an Object with the keys being the name of the member
		*	and the values being the corresonding IAccessor instance.
		*/		
		//function getAccessorObject():Object;
		
		/**
		*	Gets an Array of the values for all the public member variables
		*	declared on this Class.
		*/
		//function getVariableValues():Array;
	
		/**
		*	Gets the Class of a given member based on the name of the
		*	member. The member can be a method or variable.
		*/
		//function getClassOfMember( memberName:String ):Class;			
	}
	
}
