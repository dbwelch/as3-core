package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.Reflection;
	
	/**
	*	Represents an accessor method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Accessor extends AbstractMethod
		implements IAccessor {
		
		static public const READ_ONLY:String = "readonly";
		static public const WRITE_ONLY:String = "writeonly";
		static public const READ_WRITE:String = "readwrite";
		
		private var _access:String;

		public function Accessor()
		{
			super();
			this.memberType = MemberType.PUBLIC_TYPE;
		}
		
		public function isWritable():Boolean
		{
			return ( _access == WRITE_ONLY || _access == READ_WRITE );
		}
		
		public function isReadable():Boolean
		{
			return ( _access == READ_ONLY || _access == READ_WRITE );
		}
		
		public function set access( val:String ):void
		{
			_access = val;
		}
		
		public function get access():String
		{
			return _access;
		}
		
		override public function set type( val:String ):void
		{
			super.type = val;
			
			//create our default parameter
			if( parameters.length == 0 )
			{
				var param:Parameter = new Parameter();
				param.type = this.type;
				param.name = Reflection.ACCESSOR_PARAMETER_NAME;
				parameters.push( param );
			}
		}
		
		override public function getActionscriptString():String
		{
			var str:String = "";
			
			if( isWritable() )
			{
				if( this.overrides )
				{
					str += Reflection.OVERRIDE_DECLARATION + StringUtils.SPACE; 	
				}
				
				str += memberType +
					StringUtils.SPACE +
					Reflection.FUNCTION_DECLARATION +
					StringUtils.SPACE +
					Reflection.SET_DECLARATION + StringUtils.SPACE +
					sanitizeMethodName( name ) +
					parameters.getActionscriptString() +
					Reflection.TYPE_DELIMITER +
					Reflection.VOID;
					
				str += Reflection.getStartClosure();
				str += StringUtils.NEWLINE;
				
				str += Reflection.CLOSURE_END;
			}
			
			if( isReadable() )
			{
				if( str.length )
				{
					str += StringUtils.NEWLINE;
				}
				
				if( this.overrides )
				{
					str += Reflection.OVERRIDE_DECLARATION + StringUtils.SPACE; 	
				}				
				
				str += memberType +
					StringUtils.SPACE +
					Reflection.FUNCTION_DECLARATION +
					StringUtils.SPACE +
					Reflection.GET_DECLARATION +
					StringUtils.SPACE + 
					sanitizeMethodName( name ) +
					Reflection.METHOD_CLOSURE +
					Reflection.TYPE_DELIMITER +
					returnTypeClassName;
					
				str += Reflection.getStartClosure();
				str += StringUtils.NEWLINE;
				
				str += Reflection.CLOSURE_END;						
			}
			
			return str;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			output.access = this.access;
			return output;
		}
		
		override public function getCommonStringOutputComposites():Array
		{
			var output:Array = super.getCommonStringOutputComposites();
			return output;
		}		
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
