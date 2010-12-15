package com.ffsys.di
{
	/**
	*	Encapsulates constants that represent the available bean policies.
	* 
	* 	A bean policy is used to determine the behaviour when an attempt
	* 	is made to add a bean to a document with the same <code>id</code>
	* 	as an existing bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class BeanCreationPolicy extends Object
	{
		/**
		* 	The policy indicates that no action should be taken.
		* 
		* 	The existing bean will be kept intact and the duplicate
		* 	will be discarded.
		*/
		public static const NONE:String = "noBeanCreationPolicy";
		
		/**
		* 	The policy indicates that the duplicate bean definition
		* 	should completely replace the existing bean definition.
		*/
		public static const REPLACE:String = "replaceBeanCreationPolicy";
		
		/**
		* 	The policy indicates that the duplicate bean definition
		* 	should be just change the implementation instantiated by the
		* 	existing bean definition.
		* 
		* 	This creation policy copies the instance class from the
		* 	duplicate bean definition to the existing definition.
		* 
		* 	No other properties of the existing bean are modified.
		*/
		public static const CHANGE:String = "changeBeanCreationPolicy";
		
		/**
		* 	The policy indicates that the duplicate bean definition
		* 	should be merged with the existing bean definition.
		* 
		* 	When a duplicate bean is merged with an existing bean
		* 	any instance class from the duplicate bean will overwrite
		* 	the existing definition and all the properties associated
		* 	with the duplicate definition will overwrite properties associated
		* 	with the existing bean definition.
		*/
		public static const MERGE:String = "mergeBeanCreationPolicy";
	}
}