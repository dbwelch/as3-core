package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;
	import com.ffsys.utils.reflection.Reflection;
	import com.ffsys.utils.reflection.AbstractReflectionCollection;
	
	/**
	*	Encapusulates the parameters for a method of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class Parameters extends AbstractReflectionCollection {
		
		public function Parameters()
		{
			super();
		}
		
		override public function getActionscriptString(
			ignoreTypeInformation:Boolean = false ):String
		{
			var str:String = Reflection.METHOD_CLOSURE_START;
			var i:int = 0;
			var l:int = this.length;
			
			if( l > 0 )
			{	
				str += StringUtils.SPACE;
			}
			
			var parameter:Parameter;
			
			var paramContents:String = "";
			
			for( ;i < l;i++ )
			{
				parameter = this[ i ];
				
				paramContents += parameter.getActionscriptString( ignoreTypeInformation );
				
				if( i < ( l -1 ) )
				{
					paramContents += Reflection.STATEMENT_DELIMITER + StringUtils.SPACE;
				}
			}
			
			//if there is more than one parameter
			//we format them onto multiple lines				
			if( l > 1 )
			{
				var re:RegExp = new RegExp( Reflection.STATEMENT_DELIMITER + StringUtils.SPACE, "g" );
				paramContents = paramContents.replace( re,
					Reflection.STATEMENT_DELIMITER + StringUtils.NEWLINE );
				
				paramContents = paramContents.replace(
					new RegExp( "(\\" + Reflection.METHOD_CLOSURE_START + ")" + "\\s" ),
					"$1" + StringUtils.NEWLINE );
					
				paramContents = StringUtils.ltrim( paramContents );
				
				paramContents = StringUtils.NEWLINE + 
					StringUtils.rtrim( StringUtils.padLines( paramContents, StringUtils.TAB ) );
			}
			
			str += paramContents;
			
			if( l > 0 )
			{	
				str += StringUtils.SPACE;
			}			
			
			str += Reflection.METHOD_CLOSURE_END;
			
			return str;
		}		
		
	}
	
}
