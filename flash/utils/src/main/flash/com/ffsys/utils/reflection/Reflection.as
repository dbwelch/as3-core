package com.ffsys.utils.reflection {
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.object.ClassStringUtils;
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.parser.DescribeTypeParser;
	
	/**
	*	Acccepts an XML representation of a call to describeType()
	*	and parses it into an Object reference structure.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class Reflection extends Instance {
		
		//symbols + delimiters
		static public const DOT_SYMBOL:String = StringUtils.DOT;
		static public const WILDCARD:String = "*";	
		static public const OVERRIDE:String = "$";
		static public const ASSIGNMENT:String = "=";
		static public const CLOSURE_START:String = "{";
		static public const CLOSURE_END:String = "}";
		
		static public const METHOD_CLOSURE_START:String = "(";
		static public const METHOD_CLOSURE_END:String = ")";
		static public const METHOD_CLOSURE:String =
			METHOD_CLOSURE_START + METHOD_CLOSURE_END;
		
		static public const TYPE_DELIMITER:String = ":";
		static public const CLASS_DELIMITER:String =
			ClassStringUtils.CLASS_DELIMITER;
		
		static public const DECLARATION_DELIMITER:String = ";";
		
		static public const STATEMENT_DELIMITER:String = StringUtils.COMMA;
		
		//the argument name to use for accessors
		static public const ACCESSOR_PARAMETER_NAME:String = "value";
		
		//keywords
		static public const VOID:String = "void";
		static public const OVERRIDE_DECLARATION:String = "override";
		static public const PACKAGE_DECLARATION:String = "package";
		static public const CLASS_DECLARATION:String = "class";
		static public const SUPER_DECLARATION:String = "super";
		static public const FUNCTION_DECLARATION:String = "function";
		static public const SET_DECLARATION:String = "set";
		static public const GET_DECLARATION:String = "get";
		static public const VARIABLE_DECLARATION:String = "var";
		//static public const PUBLIC_DECLARATION:String = "public";
		static public const RETURN_DECLARATION:String = "return";
		
		//-->
	//	static public const PRIVATE_DECLARATION:String = "private";
	//	static public const PROTECTED_DECLARATION:String = "protected";
		
		static public const STATIC_DECLARATION:String = "static";
		static public const FINAL_DECLARATION:String = "final";
		static public const DYNAMIC_DECLARATION:String = "dynamic";
		
		static public const EXTENDS_DECLARATION:String = "extends";
		static public const IMPLEMENTS_DECLARATION:String = "implements";
		
		static public const INT_KEYWORD:String = "int";
		static public const UINT_KEYWORD:String = "uint";
		static public const NUMBER_KEYWORD:String = "Number";
		static public const FUNCTION_KEYWORD:String = "Function";
		static public const STRING_KEYWORD:String = "String";
		static public const BOOLEAN_KEYWORD:String = "Boolean";
		
		//variable name to use when encountering a * type
		static public const WILDCARD_KEYWORD:String = "wildcard";
		
		//variable name to use when encountering a Function type
		static public const METHOD_KEYWORD:String = "method";
		
		static public var closureOnNewLine:Boolean = true;
		
		public function Reflection( target:Object = null )
		{
			super();
			this.target = target;
		}
		
		static public function getStartClosure( noNewLine:Boolean = false ):String
		{	
			var wrap:String = closureOnNewLine ? StringUtils.NEWLINE: StringUtils.SPACE;
			
			if( noNewLine )
			{
				wrap = StringUtils.SPACE;
			}
			
			return wrap + CLOSURE_START;
		}
		
		static public function getSuperStatement(
			methodName:String = null,
			parameters:String = "", assignment:Boolean = false ):String
		{
			var str:String = SUPER_DECLARATION;
			
			if( methodName )
			{
				str += DOT_SYMBOL + methodName;
			}
			
			if( !assignment )
			{			
				if( parameters == "" )
				{
					str += METHOD_CLOSURE;
				}else{
					str += parameters;
				}
			}else{
				str += StringUtils.SPACE + ASSIGNMENT + StringUtils.SPACE;
				str += parameters;
			}
			
			str += DECLARATION_DELIMITER;
			return str;
		}
		
		private function parse( target:Object, xml:XML = null ):void
		{
			_target = target;
			
			if( !xml )
			{
				/*
				//always point to the Class if we're an instance
				if( !isClass() )
				{
					target = target.constructor;
				}
				*/
				
				xml = describeType( target );
				
				//trace( xml );
				
				var parser:DescribeTypeParser = new DescribeTypeParser( Reflection );
				parser.parse( xml, this );
				
				return;
			}
			
		}
		
		public function set target( val:Object ):void
		{
			parse( val );
		}		
		
	}
	
}
