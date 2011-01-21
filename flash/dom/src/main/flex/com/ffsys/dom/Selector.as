package com.ffsys.dom
{

	public class Selector extends Object
	{
		/**
		* 	A regular expression used to determine whether
		* 	a query contains attribute selector filters.
		*/
		public static const ATTRIBUTE_SELECTOR:RegExp = /\[([^\]]+)\]/g;
		
		/**
		* 	The delimiter between multiple selectors.
		*/
		public static const DELIMITER:String = ",";
		
		/**
		* 	The wildcard selector used to select all elements.
		*/
		public static const WILDCARD:String = "*";		
		
		/**
		* 	The character that defines an identifier selector.
		*/
		public static const IDENTIFIER:String = "#";
		
		/**
		* 	The character that defines a class level selector.
		*/
		public static const CLASS:String = ".";
		
		/**
		* 	The character that defines a child selector.
		*/
		public static const CHILD:String = ">";
		
		/**
		* 	The character that defines a descendant selector.
		*/
		public static const DESCENDANT:String = " ";
		
		/**
		* 	Creates a <code>Selector</code> instance.
		*/
		public function Selector()
		{
			super();
		}
	}
}