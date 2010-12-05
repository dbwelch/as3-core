package com.ffsys.asdoc.undocumented
{
	/*
	*	Tests for a class that has not been documented properly.
	*/
	public class AsdocUndocumented extends Object
	{	
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
	}
}