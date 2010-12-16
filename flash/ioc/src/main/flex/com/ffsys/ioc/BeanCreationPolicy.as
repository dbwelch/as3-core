package com.ffsys.ioc
{
	/**
	*	Encapsulates constants that represent the available bean creation policies.
	* 
	* 	A bean creation policy is used to determine the behaviour when an attempt
	* 	is made to add a bean to a document with the same <code>id</code>
	* 	as an existing bean.
	* 
	* 	The bean creation policy can only be used when the existing bean definition
	* 	bean definition is not <code>locked</code>.
	* 
	* 	This forces the behaviour that you must specifically mark as bean as 
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	* 
	* 	@see com.ffsys.ioc.BeanDescriptor
	* 	@see com.ffsys.ioc.BeanDocument
	*/
	public class BeanCreationPolicy extends Object
	{
		/**
		* 	The policy indicates that no action should be taken.
		* 
		* 	The existing bean will be kept intact and the duplicate
		* 	will be discarded.
		* 
		* 	This is the default policy used by all beans.
		*/
		public static const NONE:String = "noBeanCreationPolicy";
		
		/**
		* 	The policy indicates that the duplicate bean definition
		* 	should completely replace the existing bean definition.
		*/
		public static const REPLACE:String = "replaceBeanCreationPolicy";
		
		/**
		* 	The policy indicates that the instance class of the existing
		* 	bean should be changed.
		*
		* 	This creation policy copies the instance class from the
		* 	duplicate bean definition to the existing definition
		* 	just <em>changing</em> the implementation to instantiate.
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
		* 
		* 	New properties that do not exist on the existing bean definition
		* 	will be created.
		* 
		* 	The bean descriptor reference stored by the document will be
		* 	the <em>original</em> bean descriptor, the duplicate is discarded
		* 	after the merge has been performed.
		*/
		public static const MERGE:String = "mergeBeanCreationPolicy";
	}
}