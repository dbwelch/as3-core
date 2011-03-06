package com.ffsys.fluid.core {
	
	import flash.display.DisplayObject;
	import com.ffsys.swat.core.DefaultFlashVariables;
	
	/**
	*	Encapsulates the data passed in via flash variables
	*	from the container embedding this movie.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.01.2011
	*/
	public class ApplicationFlashVariables extends DefaultFlashVariables {
		
		/**
		*	Creates a <code>ApplicationFlashVariables</code> instance.
		*	
		*	@param root The root of the display list hierarchy.
		*/
		public function ApplicationFlashVariables( root:DisplayObject )
		{
			super( root );
		}
	}
}