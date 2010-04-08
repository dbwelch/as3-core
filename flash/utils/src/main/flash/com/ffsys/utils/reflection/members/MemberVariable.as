package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;

	import com.ffsys.utils.reflection.Reflection;	
	
	/**
	*	Represents a member variable whether it be public, private or protected.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class MemberVariable extends InstanceMember
		implements IMemberVariable {
		
		/**
		*	@private
		*/		
		public function MemberVariable()
		{
			super();
		}
		
		public function get value():*
		{
			if( parent && !uri )
			{
				var val:* = Reflection( parent ).target[ name ];
				return val;
			}			
		}
		
		/*
		public function getValue():*
		{
			if( parent && !uri )
			{
				var val:* = Reflection( parent ).target[ name ];
				return val;
			}
		}
		*/
		
		public function getFormattedValue():String
		{
			var val:* = this.value;
			
			if( val is String )
			{
				val = '"' + val + '"';
			}
			
			return "" + val;
		}
		
		override public function getClassName():String
		{
			var val:String = super.getClassName();
			
			if( !val )
			{
				val = Reflection.WILDCARD;
			}
			
			return val;
		}
		
		public function getActionscriptString():String
		{
			var str:String = this.memberType + StringUtils.SPACE;
			str += Reflection.VARIABLE_DECLARATION + StringUtils.SPACE;
			
			str += name + Reflection.TYPE_DELIMITER + getClassName();
			
			str += StringUtils.SPACE +
				Reflection.ASSIGNMENT +
				StringUtils.SPACE +
				getFormattedValue();
			
			str += Reflection.DECLARATION_DELIMITER;
			
			return str;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			output.name = this.name;
			return output;
		}		
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
