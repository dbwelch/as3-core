package com.ffsys.utils.reflection {
	
	/**
	*	Describes the contract for instances that represent
	*	a data type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public interface IDataType {
		
		/**
		*	Gets the qualified class path to the Class.
		*/
		function getQualifiedClassPath():String;
		
		/**
		*	Gets the package part of the qualified class path,
		*	if the Class is top-level and therefore does not belong
		*	to a package this will return a blank String.
		*
		*	@return a String of the package name
		*/	
		function getPackageName():String;
		
		/**
		*	Gets the String class name of the Class.
		*
		*	@return a String of the class name
		*/
		function getClassName():String;
		
		/**
		*	Gets the underlying Class of the data type.
		*
		*	@return the Class of this data type
		*/
		function getClass():Class;
		
		/**
		*	Determines whether this data type is void.
		*
		*	Only applies to the return type from a method
		*	but declared for aLL data types.
		*
		*	@return a Boolean indicating whether this data type is void
		*/
		function isVoid():Boolean;
		
		/**
		*	Determines whether this type is a wildcard (*) type.
		*
		*	@return a Boolean indicating whether this type is a wildcard type
		*/
		function isWildcardType():Boolean;		 
		
		/**
		*	Determines whether this type is of a given Class.
		*/
		//function isClass( classReference:Class ):Boolean;
	
		/**
		*	Determines whether this member is an intrinsic type,
		*	an intrinsic type is a built in Object such as:
		*
		*	Object, Number, Boolean, String, Array, XML,
		*	XMLList, Date, RegExp
		*
		*	Note that both the void and wildcard (*) types are considered
		*	intrinsic.
		*/
		//function isIntrinsicType():Boolean;
		
		/**
		*	Determines whether a type is a primitive intrinsic type.
		*	A data type is considered to be primitive if it's Class
		*	is one of te following:
		*
		*	Boolean, String, Number
		*
		*	Note that both int and uint are included by the comparison
		*	against the Number Class.
		*/
		//function isPrimitiveType():Boolean;
		
		/**
		*	Determines whether this data type is a complex intrinsic
		*	type. Complex types are considered to be:
		*
		*	Object, Array, XML, XMLList, Date and RegExp
		*/
		//function isComplexType():Boolean;
		
		/**
		*	Determines whether this a custom type that has been
		*	declared using a Class definition.
		*/
		//function isCustomType():Boolean;		
	}
	
}
