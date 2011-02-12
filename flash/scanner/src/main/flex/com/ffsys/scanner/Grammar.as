package com.ffsys.scanner
{
	
	/**
	*	Represents a grammar definition for a scanner
	* 	scan process. 	
	*/
	dynamic public class Grammar extends TokenList
	{
		/**
		* 	Creates a <code>Grammar</code> instance.
		*/
		public function Grammar()
		{
			super();
		}
		
		/**
		* 	Configures this grammar in the context of
		* 	a scanner.
		*/
		public function configure( scanner:Scanner ):Grammar
		{
			
			
			return this;
		}
	}
}