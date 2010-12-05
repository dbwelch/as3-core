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
	}
}