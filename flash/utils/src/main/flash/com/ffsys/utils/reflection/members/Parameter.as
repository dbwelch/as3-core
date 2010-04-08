package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.Reflection;
	import com.ffsys.utils.reflection.AbstractReflection;
	
	/**
	*	Represents a parameter to an instance method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Parameter extends AbstractReflection {
		
		private var _index:int;
		private var _optional:Boolean;
		
		private var _name:String;
		private var _variableName:String;

		public function Parameter()
		{
			super();
		}
		
		public function getIndex():int
		{
			return _index;
		}
		
		public function isOptional():Boolean
		{
			return _optional;
		}
		
		override public function set type( val:String ):void
		{
			super.type = val;
			this.name = getTypeString();
			setVariableName();
		}		
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function setVariableName():void
		{
			if( !_variableName )
			{
				_variableName = inferVariableNameFromType( getTypeString() );
			}
		}
		
		public function get variableName():String
		{
			return _variableName;
		}		
		
		private function inferVariableNameFromType( typeString:String ):String
		{	
			
			if( typeString == Reflection.WILDCARD )
			{
				return Reflection.WILDCARD_KEYWORD;
			}
			
			if( typeString == Reflection.INT_KEYWORD || 
				typeString == Reflection.UINT_KEYWORD )
			{
				return Reflection.NUMBER_KEYWORD.toLowerCase();
			}
			
			if( typeString == Reflection.FUNCTION_KEYWORD )
			{
				return Reflection.METHOD_KEYWORD;
			}
				
			var varName:String = typeString;
			
			//matches a possible interface name, remove the I
			if( varName.match( /^I[A-Z]/ ) )
			{
				varName = varName.substr( 1 );
			}
			
			varName = StringUtils.firstCharToLowerCase( varName );
			
			return varName;			
		}
		
		private function getTypeString():String
		{
			var typeString:String = null;
			
			if( getClassName() )
			{
				typeString = getClassName();
			}else if( type )
			{
				typeString = type;
			}
			
			return typeString;			
		}
		
		public function getActionscriptString(
			ignoreTypeInformation:Boolean ):String
		{
			var typeString:String = getTypeString();
			var str:String = this.variableName;
			
			if( !ignoreTypeInformation )
			{
				str += Reflection.TYPE_DELIMITER + typeString;
			}
			
			return str;
		}	
		
		/*
		*	Begin XML Deserialization implementation.
		*/
		
		/**
		*	@private
		*
		*	Converts the index parameter to a zero
		*	based integer value
		*/
		public function set index( val:String ):void
		{
			_index = parseInt( val ) - 1;
		}
		
		/**
		*	@private
		*/
		public function get index():String
		{
			return null;
		}
		
		/**
		*	@private
		*
		*	Converts the optional paramater to a Boolean
		*/
		public function set optional( val:String ):void
		{
			_optional = toBoolean( val );
		}
		
		/**
		*	@private
		*/
		public function get optional():String
		{
			return null;
		}
		
		/*
		*	End XML Deserialization implementation.
		*/
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			output.index = getIndex();
			output.optional = isOptional();
			return output;
		}			
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
