package java.lang
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	* 	Represents a type definition generated at runtime.
	* 
	* 	A type definition has a one to one relationship
	* 	with a class definition.
	* 
	* 	@todo Ensure that static variables are also included,
	* 	this will require reflecting the class and caching the 
	* 	static members.
	*/
	public class T extends Object
	{
		/**
		* 	The prefix used when dynamically instantiating
		* 	a vector of a specific type at runtime.
		*/
		public static const VECTOR_PREFIX:String = "__AS3__.vec::Vector.<";
		
		/**
		* 	The suffix used when dynamically instantiating
		* 	a vector of a specific type at runtime.
		*/
		public static const VECTOR_SUFFIX:String = ">";
		
		static private var __types:Dictionary = new Dictionary();
		private var _class:Class;
	
		/**
		* 	Creates a <code>T</code> instance.
		*/
		public function T( type:* )
		{
			super();
			_class = getClass( type );
		}
		
		/**
		*	@private 
		*/
		private function getClass( target:* = null ):Class
		{
			if( _class == null )
			{	
				var path:String = getQualifiedClassName( target );
				
				trace("[PATH] T::getClass()", path );
				
				_class = getDefinitionByName( path ) as Class;
				
				//classes are dynamic so cache our path and name
				if( _class != null )
				{
					Object( _class ).path = path;

					var classPath:String = path;
					var className:String = classPath;
					var index:int = classPath.indexOf( "::" );
					if( index > -1 )
					{
						//keep track of the package part
						Object( _class ).pkg = classPath.substr( 0, index );
						className = classPath.substr( index + 2 );
					}
					Object( _class ).name = className;
				}
			}
			
			//create a circular reference between
			//the class and this type definition
			if( _class != null )
			{
				if( !( _class.type is T ) )
				{
					Object( _class ).type = this;
				}
				
				//cache the type reflection info
				Object( _class ).xml = describeType( _class );
			}
			return _class;
		}
		
		/**
		* 	Returns the type information for the class
		* 	definition that this type represents.
		*/
		public function get xml():XML
		{
			var clazz:Class = getClass();
			return clazz.xml as XML;
		}
		
		/**
		* 	The class definition this type represents.
		*/
		public function get definition():Class
		{
			return _class;
		}
		
		/**
		* 	The package path for the class definition.
		* 
		* 	If no valid package is available this will be
		* 	the empty string.
		*/
		public function get pkg():String
		{
			var clazz:Class = getClass();
			return clazz.pkg is String ?  String( clazz.pkg ) : "";
		}
		
		/**
		*	The fully qualified class path to the class
		* 	definition.
		*/
		public function get path():String
		{
			var clazz:Class = getClass();
			return String( clazz.path );
		}
		
		/**
		*	The name of the class.
		*/
		public function get name():String
		{
			var clazz:Class = getClass();
			return String( clazz.name );
		}
		
		/**
		* 	Retrieves and caches the class definition
		* 	for a type.
		*/
		public static function getInstance( type:* ):T
		{
			//TODO: handle null/undefined etc.
			
			trace("[INSTANCE] T::getInstance()", type );
			
			var t:T = null;
			var constr:Object = null;
			if( type is Object )
			{
				constr = type.constructor;
				t = __types[ constr ] as T;		
			}
			
			
			if( t != null )
			{
				
				/*
				Object( t.definition ).prototype.constructor = function( ... rest ):*
				{
					trace("T::getInstance()", "NEW INSTANCE WITH DYNAMIC CONSTRUCTOR" );
				}
				*/
					
				return t;
			}
			
			t = new T( type );
			__types[ t.definition ] = t;
			return t;
		}
		
		/**
		* 	
		*/
		public static function vector( type:Class ):Vector.<*>
		{
			if( type != null )
			{
				var fqn:String = null;
				var t:T = Object( type ).type as T;
				if( !t )
				{
					t = getInstance( type );
				}
				
				fqn = VECTOR_PREFIX + t.path + VECTOR_SUFFIX;
				
				trace("[FQN] T::vector()", type, fqn );
				
				try
				{
					var clazz:Class = getDefinitionByName( fqn ) as Class;
					return new clazz();
				}catch( e:Error )
				{
					throw e;
				}
			}
			return null;
		}
	}
}