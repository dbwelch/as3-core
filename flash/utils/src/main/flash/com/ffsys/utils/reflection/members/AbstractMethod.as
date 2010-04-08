package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.Reflection;
	
	/**
	*	Abstract base class for method type data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class AbstractMethod extends InstanceMember
		implements IMethod {
		
		private var _parameters:Parameters;
		
		private var _returnType:String;
		
		//the return type of this method
		private var _returnTypeClass:Class;
		
		/**
		*	@private
		*/		
		public function AbstractMethod()
		{
			super();
			_parameters = new Parameters();
		}
		
		/**
		*	@private
		*/	
		public function set parameter( val:Parameter ):void
		{
			_parameters.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get parameter():Parameter
		{
			return null;
		}
		
		/**
		*	@private
		*/		
		public function set returnType( val:String ):void
		{
			if( val != Reflection.VOID && val != Reflection.WILDCARD )
			{
				_returnTypeClass = getClassDefinition( val );
			}
			
			_returnType = val;
		}
		
		/**
		*	@private
		*/		
		public function get returnType():String
		{
			return _returnType;
		}
		
		public function get parameters():Parameters
		{
			return _parameters;
		}		
		
		override public function getClass():Class
		{
			return Function;
		}
		
		public function get returnTypeClassName():String
		{
			if( !_returnType )
			{
				
				if( type )
				{
					return parseClassName( type );
				}
				
				return Reflection.VOID;
			}
			
			if( _returnType )
			{
				return parseClassName( _returnType );
			}
			
			return _returnType;
		}
		
		public function get returnTypeClass():Class
		{
			return _returnTypeClass;
		}
		
		private function getMethodContents(
			isOverride:Boolean,
			methodName:String ):String
		{
			var str:String = "";
			
			if( isOverride )
			{
				var superParameters:String = parameters.getActionscriptString( true );
				str += StringUtils.TAB +
					Reflection.getSuperStatement( methodName, superParameters, ( this is Accessor ) ) +
					StringUtils.NEWLINE;
			}
			
			return str;
		}
		
		public function getActionscriptString():String
		{
			var str:String = "";
			
			var methodName:String = sanitizeMethodName( this.name );
			
			///var methodName:String = this.name;
			
			var isOverride:Boolean = ( this.overrides && !( this is Constructor ) );
			
			if( isOverride )
			{
				str += Reflection.OVERRIDE_DECLARATION + StringUtils.SPACE;
			}
			
			str += this.memberType + StringUtils.SPACE;
			str += Reflection.FUNCTION_DECLARATION + StringUtils.SPACE;
			str += methodName;
			str += parameters.getActionscriptString();
		
			if( returnTypeClassName )
			{
				str += Reflection.TYPE_DELIMITER + returnTypeClassName;
			}
			
			str += Reflection.getStartClosure();
			str += StringUtils.SPACE;
			str += StringUtils.NEWLINE;
			
			str += getMethodContents( isOverride, methodName );
			
			str += Reflection.CLOSURE_END;
			
			return str;
		}
		
		public function hasRequiredParameters():Boolean
		{
			var i:int = 0;
			var l:int = parameters.length;
			
			for( ;i < l;i++ )
			{
				if( !parameters[ i ].isOptional() )
				{
					return true;
				}
			}
			
			return false;
		}
		
		protected function sanitizeMethodName( name:String ):String
		{
			return name.replace( /^[^a-z-A-Z0-9]/, "" );
		}
		
		public function get overrides():Boolean
		{
			var match:Array = new Array();
			
			if( name )
			{
				match = name.match( new RegExp( "^" + "\\" + Reflection.OVERRIDE ) );
			}
			
			return match && match.length > 0;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			
			output.name = this.name;
			output.returnType = returnTypeClass ? returnTypeClass : returnType;
			output.overrides = this.overrides;			
			
			return output;
		}
		
		override public function getCommonStringOutputComposites():Array
		{
			var output:Array = super.getCommonStringOutputComposites();
			output.push( parameters );
			output.push( meta );
			return output;
		}
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}
