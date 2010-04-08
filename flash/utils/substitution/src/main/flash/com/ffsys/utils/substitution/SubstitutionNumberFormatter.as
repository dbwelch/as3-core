package com.ffsys.utils.substitution {
	
	import mx.formatters.NumberFormatter;
	
	/**
	*	Performs formatting of Number values that are
	*	found during substitution lookup.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.09.2007
	*/
	public class SubstitutionNumberFormatter extends SubstitutionFormatter {
		
		public function SubstitutionNumberFormatter()
		{
			super();
		}
		
		override public function format( replacement:Object ):Object
		{
			if( replacement is Number )
			{
				var formatter:NumberFormatter =
					new NumberFormatter();
				
				formatter.useThousandsSeparator = true;
				formatter.precision = 2;
				
				if( replacement is int )
				{
					formatter.precision = -1;
				}
				
				return formatter.format( replacement );
			}
			
			return replacement;
		}
		
	}
	
}