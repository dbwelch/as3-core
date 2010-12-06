/*
*	This package does not have a description.
*/
package com.ffsys.asdoc.undocumented
{
	/*
	*	Tests for a class that has not been documented properly.
	*/
	public class AsdocUndocumented extends Object
		implements IAsdocUndocumented
	{	
		/*
		*	An undocumented public varaible.
		*/
		public var number:Number = 1;
		
		/*
		*	Forgot to document the constructor properly.
		*/
		public function AsdocUndocumented()
		{
			super();
		}
		
		/*
		*	Naughty forgot to document this one properly.
		*/
		public function notDocumented():void
		{
			//
		}
		
		/**
		*	This is a method that has not had it's parameters documented properly.
		*/
		public function missingParameterDocumentation( param1:int, param2:int ):void
		{
			//
		}	
		
		/**
		*	This is a method that has not had it's return value documented properly.
		*/
		public function missingReturnDocumentation():String
		{
			return null;
		}
		
		/*
		*	An undocumented getter accessor.
		*/
		public function get id():String
		{
			return null;
		}
		
		/**
		*	This is a documented method in an undocumented class to test
		* 	certain special characters.
		* 
		* 	Such as underscores in <code>inline_code</code> and dollar signs <code>$</code>
		* 	as well as the backslash escape character <code>\some text</code>.
		* 
		* 	It's nice to test the circumflex ^ and the tilde ~ too.
		* 
		* 	We also want to check in the pre tag:
		* 
		* 	<pre>private var _under_score:String =
		*		doSomething( $_super_private, "\n");</pre>
		*/
		public function get value():String
		{
			return null;
		}
	}
}