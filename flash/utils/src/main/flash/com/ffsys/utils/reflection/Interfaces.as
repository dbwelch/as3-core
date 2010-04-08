package com.ffsys.utils.reflection {
	
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	Encapsulated the interfaces implemented by an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class Interfaces extends AbstractReflectionCollection {
		
		public function Interfaces()
		{
			super();
		}
		
		override public function getActionscriptString(
			ignoreTypeInformation:Boolean = false ):String
		{
			var str:String = Reflection.IMPLEMENTS_DECLARATION;
			
			var i:int = 0;
			var l:int = this.length;
			
			for( ;i < l;i++ )
			{
				str += StringUtils.NEWLINE +
					StringUtils.TAB +
					this[ i ].getActionscriptString();
					
				if( i < ( l - 1 ) )
				{
					str += Reflection.STATEMENT_DELIMITER;
				}
			}
			
			return StringUtils.rtrim( str );
		}		
		
	}
	
}
