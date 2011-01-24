package com.ffsys.css
{
	/**
	* 	Represents an attribute selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class AttributeSelector extends OperatorSelector
		implements SimpleSelector
	{
		
		/**
		* 	An empty attribute operator indicating attribute existence.
		*/
		public static const HAS:String = "";
		
		/**
		* 	An attribute operator indicating equality comparison.
		*/
		public static const EQUALITY:String = "=";
		
		/**
		* 	An attribute operator indicating the attribute should
		* 	contain whitespace delimited values one of which
		* 	should be the value.
		*/
		public static const WHITESPACE_LIST_CONTAINS:String = "~=";
		
		/**
		* 	An attribute operator indicating the attribute should
		* 	begin with the value.
		*/
		public static const STARTS_WITH:String = "^=";
		
		/**
		* 	An attribute operator indicating the attribute should
		* 	end with the value.
		*/
		public static const ENDS_WITH:String = "$=";
		
		/**
		* 	An attribute operator indicating the attribute should
		* 	contain the value.
		*/
		public static const CONTAINS:String = "*=";
		
		/**
		* 	An attribute operator indicating the attribute should
		* 	contain comma delimited values one of which may match
		* 	the value.
		*/
		public static const COMMA_LIST_CONTAINS:String = "|=";
		
		/**
		* 	Creates a <code>AttributeSelector</code> instance.
		* 
		* 	@param operand The name of the attribute.
		* 	@param operator An operator for the selector.
		* 	@param value A value to compare to the attribute value.
		*/
		public function AttributeSelector(
			operand:String = null,
			operator:String = null,
			value:String = null )
		{
			super( operand, operator, value );
		}
		
		
		/*
		
		E[foo]	an E element with a "foo" attribute	Attribute selectors	2
		E[foo="bar"]	an E element whose "foo" attribute value is exactly equal to "bar"	Attribute selectors	2
		E[foo~="bar"]	an E element whose "foo" attribute value is a list of whitespace-separated values, one of which is exactly equal to "bar"	Attribute selectors	2
		E[foo^="bar"]	an E element whose "foo" attribute value begins exactly with the string "bar"	Attribute selectors	3
		E[foo$="bar"]	an E element whose "foo" attribute value ends exactly with the string "bar"	Attribute selectors	3
		E[foo*="bar"]	an E element whose "foo" attribute value contains the substring "bar"	Attribute selectors	3
		E[foo|="en"]	an E element whose "foo" attribute has a hyphen-separated list of values beginning (from the left) with "en"	
		
		*/
	}
}