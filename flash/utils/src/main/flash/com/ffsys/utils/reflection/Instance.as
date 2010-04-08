package com.ffsys.utils.reflection {
	
	import com.ffsys.utils.array.ArrayUtils;	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.members.IMember;
	import com.ffsys.utils.reflection.members.Constructor;
	import com.ffsys.utils.reflection.members.Method;
	import com.ffsys.utils.reflection.members.Methods;
	import com.ffsys.utils.reflection.members.Accessor;
	import com.ffsys.utils.reflection.members.Accessors;
	import com.ffsys.utils.reflection.members.PublicMemberVariable;
	import com.ffsys.utils.reflection.members.Variables;	
	import com.ffsys.utils.reflection.members.MemberType;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;	
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Represents an instance of an Object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Instance extends AbstractReflection
		implements 	IReflector {
			
		protected var _target:Object;
			
		private var _superClass:Class;
		private var _superClassName:String;
		
		private var _isStatic:Boolean;
		private var _isFinal:Boolean;
		private var _isDynamic:Boolean;
		
		private var _constants:Constants;
		private var _factory:Factory;
		
		private var _inheritance:Inheritance;
		private var _interfaces:Interfaces;
		private var _constructorMethod:Constructor;
		private var _methods:Methods;
		private var _accessors:Accessors;
		private var _variables:Variables;

		public function Instance()
		{
			super();
			
			_constants = new Constants();
			
			_inheritance = new Inheritance();
			_interfaces = new Interfaces();
			_constructorMethod = new Constructor();
			_methods = new Methods();
			_accessors = new Accessors();
			_variables = new Variables();
		}
		
		public function get target():Object
		{
			return _target;
		}		
		
		public function getSuperClass():Class
		{
			return _superClass;	
		}
		
		public function getSuperClassName():String
		{
			return _superClassName;	
		}		

		public function get constants():Constants
		{
			return _constants;
		}
		
		public function get factory():Factory
		{
			return _factory;
		}		
		
		public function get inheritance():Inheritance
		{
			return _inheritance;
		}
		
		public function get interfaces():Interfaces
		{
			return _interfaces;
		}
		
		public function get constructorFunction():Constructor
		{
			return _constructorMethod;
		}
		
		public function get methods():Methods
		{
			return _methods;
		}
		
		public function get accessors():Accessors
		{
			return _accessors;
		}
		
		public function get variables():Variables
		{
			return _variables;
		}
		
		public function isClass():Boolean
		{
			return ( target is Class );
		}
		
		/*
		*	IReflector implementation.
		*/
		
		public function isStaticClass():Boolean
		{
			return _isStatic;
		}
		
		public function isFinalClass():Boolean
		{
			return _isFinal;
		}		
		
		public function isDynamicClass():Boolean
		{
			return _isDynamic;
		}
		
		public function inherits( classReference:Class ):Boolean
		{
			return ArrayUtils.contains( inheritance.getClassDefinitions(), classReference );
		}
		
		public function adheres( classReference:Class ):Boolean
		{
			//shortcut using the is operator
			if( this.target is classReference )
			{
				return true;
			}
			
			return ArrayUtils.contains( interfaces.getClassDefinitions(), classReference );
		}
		
		public function isObject():Boolean
		{
			return ( ( getClass() == Object ) && ( inheritance.length == 0 ) );
		}
		
		public function getMethodNames():Array
		{
			return methods.getMemberNames();
		}
		
		public function getAccessorNames():Array
		{
			return accessors.getMemberNames();
		}
		
		public function getVariableNames():Array
		{
			return variables.getMemberNames();
		}				
		
		public function getMemberNames():Array
		{
			var output:Array = methods.getMemberNames();
			output.concat( accessors.getMemberNames() );
			output.concat( variables.getMemberNames() );
			return output;
		}
		
		private var _methodDefinitions:Array;
		
		public function getMethods():Array
		{
			if( !_methodDefinitions )
			{
				_methodDefinitions = new Array();
				
				var i:int = 0;
				var l:int = methods.length;
			
				var method:Method;
				
				var func:Function;
			
				for( ;i < l;i++ )
				{
					method = ( methods[ i ] as Method );
					
					//if there is a URI
					//the member may have been declared internal
					//or using a namespace
					if( !method.uri )
					{
						func = target[ method.name ];
						_methodDefinitions.push( func );
					}
				}
			}
			
			return _methodDefinitions;
		}
		
		public function getMethod( memberName:String ):Function
		{
			var methods:Array = getMethods();
			var method:Function = target[ memberName ];
			if( ArrayUtils.contains( methods, method ) )
			{
				return method;
			}
			
			return null;
		}
		
		public function getActionscriptString():String
		{
			var str:String = "";
			
			//start package definition
			str += Reflection.PACKAGE_DECLARATION;
			if( getPackageName() )
			{
				str += StringUtils.SPACE + getPackageName();
			}
			str += Reflection.getStartClosure( true ) + StringUtils.NEWLINE;
			
			//start class defintition
			str += StringUtils.TAB;
			
			if( isDynamicClass() )
			{
				str += Reflection.DYNAMIC_DECLARATION + StringUtils.SPACE;
			}
			
			if( isStaticClass() )
			{
				str += Reflection.STATIC_DECLARATION + StringUtils.SPACE;
			}
			
			if( isFinalClass() )
			{
				str += Reflection.FINAL_DECLARATION + StringUtils.SPACE;
			}			
			
			str += MemberType.PUBLIC_TYPE + StringUtils.SPACE;
			str += Reflection.CLASS_DECLARATION + StringUtils.SPACE;
			
			str += name;
			
  			if( getSuperClass() )
			{
				str += StringUtils.SPACE + Reflection.EXTENDS_DECLARATION;
				str += StringUtils.SPACE + getSuperClassName();
			}
			
			var memberIndent:String = StringUtils.repeat( StringUtils.TAB, 2 );
			
			if( hasInterfaces() )
			{
				//-->
				str += StringUtils.NEWLINE;
				str += StringUtils.padLines( interfaces.getActionscriptString(),
					memberIndent );
			}
			
			//start class
			str += StringUtils.TAB + Reflection.getStartClosure( true );
			str += StringUtils.NEWLINE;
			
			//now public member variables
			if( hasVariables() )
			{
				str += StringUtils.NEWLINE;
				str += StringUtils.padLines( variables.getActionscriptString(),
				 	memberIndent );
			}
			
			//constructor function
			str += StringUtils.NEWLINE;
			str += StringUtils.padLines(
				constructorFunction.getActionscriptString(),
				memberIndent );
			str += StringUtils.NEWLINE;
			
			//accessor methods
			if( hasAccessors() )
			{
				str += StringUtils.padLines( accessors.getActionscriptString(),
				 	memberIndent );
			}
			
			//plain methods
			if( hasMethods() )
			{
				str += StringUtils.padLines( methods.getActionscriptString(),
				 	memberIndent );
			}			
			
			//close up class definition
			str += StringUtils.TAB + Reflection.CLOSURE_END;
			
			//close up package definition
			str += StringUtils.NEWLINE + Reflection.CLOSURE_END;
			
			return str;
		}
		
		public function hasInterfaces():Boolean
		{
			return ( interfaces.length > 0 );
		}
		
		public function hasMethods():Boolean
		{
			return ( methods.length > 1 );
		}
		
		public function hasAccessors():Boolean
		{
			return ( accessors.length > 1 );
		}
		
		public function hasVariables():Boolean
		{
			return ( variables.length > 1 );
		}
		
		public function hasMethod( methodName:String ):Boolean
		{
			return methods.hasMethod( methodName );
		}
		
		public function hasAccessor( accessorName:String ):Boolean
		{
			return accessors.hasAccessor( accessorName );
		}
		
		public function hasVariable( variableName:String ):Boolean
		{
			return variables.hasVariable( variableName );
		}	
		
		public function getMethodName( method:Function ):String
		{
			var i:int = 0;
			var l:int = methods.length;
			
			var member:IMember;
			
			for( ;i < l;i++ )
			{
				member = methods[ i ] as IMember;
				
				if( method == target[ member.name ] )
				{
					return member.name;
				}
			}
			
			return null;
		}
		
		public function getVariableValues():Array
		{
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = variables.length;
			
			var variable:PublicMemberVariable;
		
			var value:Object;
		
			for( ;i < l;i++ )
			{
				variable = variables[ i ];
				
				//if there is a URI
				//the member may have been declared internal
				//of using a namespace
				if( !variable.uri )
				{
					value = target[ variable.name ];
					output.push( value );
				}
			}
			
			return output;
		}
		
		/*
		*	Begin XML Deserialization implementation.
		*/				

		/**
		*	@private
		*/
		public function set constant( val:Constant ):void
		{
			_constants.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get constant():Constant
		{
			return null;
		}
		
		/**
		*	@private
		*/		
		public function set factory( val:Factory ):void
		{
			_factory = val;
		}		
		
		/**
		*	@private
		*/
		public function set extendsClass( val:SuperClass ):void
		{
			_inheritance.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get extendsClass():SuperClass
		{
			return null;
		}		
		
		/**
		*	@private
		*/		
		public function set implementsInterface( val:Interface ):void
		{
			_interfaces.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get implementsInterface():Interface
		{
			return null;
		}
		
		/**
		*	@private
		*/		
		public function set constructorMethod( val:Constructor ):void
		{
			_constructorMethod = val;
		}
		
		/**
		*	@private
		*/		
		public function get constructorMethod():Constructor
		{
			return null;
		}
		
		/**
		*	@private
		*/		
		public function set method( val:Method ):void
		{
			_methods.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get method():Method
		{
			return null;
		}				
		
		/**
		*	@private
		*/		
		public function set accessor( val:Accessor ):void
		{
			_accessors.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get accessor():Accessor
		{
			return null;
		}
		
		/**
		*	@private
		*/		
		public function set variable( val:PublicMemberVariable ):void
		{
			_variables.push( val );
		}
		
		/**
		*	@private
		*/		
		public function get variable():PublicMemberVariable
		{
			return null;
		}
		
		public function set name( val:String ):void
		{
			this.type = val;
			
			//constructor always matches us
			constructorFunction.type = val;
		}
		
		public function get name():String
		{
			return getClassName();
		}
		
		public function set base( val:String ):void
		{
			_superClass = getClassDefinition( val );
			_superClassName = parseClassName( val );
		}
		
		public function set isStatic( val:String ):void
		{
			_isStatic = toBoolean( val );
		}
		
		public function set isFinal( val:String ):void
		{
			_isFinal = toBoolean( val );
		}
		
		public function set isDynamic( val:String ):void
		{
			_isDynamic = toBoolean( val );
		}
		
		
		/*
		*	End XML Deserialization implementation.
		*/
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function getCommonStringOutputProperties():Object
		{
			var output:Object = super.getCommonStringOutputProperties();
			
			output.className = getClassName();
			output.qualifiedClassPath = getQualifiedClassPath();
			output.type = getClass();
			output.superClass = getSuperClass();
			
			return output;
		}

		override public function getCommonStringOutputComposites():Array
		{
			var output:Array = super.getCommonStringOutputComposites();
			output.push( constants );
			output.push( factory );
			output.push( inheritance );
			output.push( interfaces );
			output.push( constructorFunction );
			output.push( methods );
			output.push( accessors );
			output.push( variables );
			return output;
		}
		/* END OBJECT_INSPECTOR REMOVAL */													
		
	}
	
}
