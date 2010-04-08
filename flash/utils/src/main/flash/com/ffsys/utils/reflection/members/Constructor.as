package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;
	import com.ffsys.utils.reflection.Reflection;
	import com.ffsys.utils.reflection.members.AbstractMethod;
	
	/**
	*	Encapsulates information pertaining to the constructor
	*	method of a Class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Constructor extends AbstractMethod {
		
		public function Constructor()
		{
			super();
			this.memberType = MemberType.PUBLIC_TYPE;
		}
		
		override public function get overrides():Boolean
		{
			if( parent && Reflection( parent ).getSuperClass() )
			{
				return true;
			}
			
			return false;
		}
		
		override public function getClassName():String
		{
			if( parent )
			{
				return parent.getClassName();
			}
			
			return super.getClassName();
		}
		
		override public function getActionscriptString():String
		{
			var str:String = memberType + StringUtils.SPACE;
			
			str += Reflection.FUNCTION_DECLARATION + StringUtils.SPACE;
			
			str += getClassName();
			
			str += parameters.getActionscriptString();
			
			str += Reflection.getStartClosure();
			
			str += StringUtils.NEWLINE;
			
			str += StringUtils.TAB + Reflection.getSuperStatement() + StringUtils.NEWLINE;
			
			/*
			str += StringUtils.TAB +

				StringUtils.NEWLINE;
			*/
				
			str += Reflection.CLOSURE_END;
			
			return str;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			
			if( parent )
			{
				output.returnType = parent.getClass();
			}
			
			delete output.name;
			
			return output;
		}		
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}
