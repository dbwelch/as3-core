package com.ffsys.utils.substitution {
	
	/**
	*	Base class for all substitution formatters.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.09.2007
	*/
	public class SubstitutionFormatter extends Object
		implements ISubstitutionFormatter {
		
		public function SubstitutionFormatter()
		{
			super();
		}
		
		public function format( replacement:Object ):Object
		{
			return replacement;
		}
		
	}
	
}
