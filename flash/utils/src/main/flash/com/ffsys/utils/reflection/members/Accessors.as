package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.reflection.AbstractReflectionCollection;
	
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	Encapsulates the accesor methods of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class Accessors extends AbstractReflectionCollection {
		
		public function Accessors()
		{
			super();
			_actionscriptNewlineBreak = StringUtils.repeat( StringUtils.NEWLINE, 2 );
		}
		
		public function hasAccessor( accessorName:String ):Boolean
		{
			return hasMember( accessorName );
		}
		
	}
	
}
