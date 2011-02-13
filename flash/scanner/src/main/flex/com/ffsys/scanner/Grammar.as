package com.ffsys.scanner
{
	/**
	*	Represents a grammar definition for a scanner
	* 	scan process. 	
	*/
	public class Grammar extends TokenList
	{
		/**
		* 	Creates a <code>Grammar</code> instance.
		*/
		public function Grammar()
		{
			super();
			configure( this );
		}
		
		/**
		* 	Configures this grammar in the context of
		* 	a scanner.
		*/
		public function configure( grammar:Grammar ):Grammar
		{
			if( grammar == null )
			{
				grammar = this;
			}
			doWithGrammar( grammar );		
			return grammar;
		}
		
		/**
		* 	Derived implementations should overide
		* 	this method to configure the tokens for
		* 	the grammar.
		* 
		* 	@param grammar The grammar being configured.
		* 
		* 	@return The configured grammar.
		*/
		protected function doWithGrammar( grammar:Grammar ):Grammar
		{
			return grammar;
		}
	}
}