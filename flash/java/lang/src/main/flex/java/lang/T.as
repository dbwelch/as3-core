package java.lang
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	
	/**
	* 	Represents a type definition generated at runtime.
	* 
	* 	A type definition has a one to one relationship
	* 	with a class definition.
	*/
	public class T extends Object
	{
		private var _class:Class;
	
		/**
		* 	Creates a <code>T</code> instance.
		*/
		public function T( type:* )
		{
			super();
			if( type is Class )
			{
				_class = Class( type );
			}else{
				_class = getClass( type );
			}
			
			trace("T::T()", Object( this ).constructor );
		}
		
		/**
		*	@private 
		*/
		private function getClass( target:* = null ):Class
		{
			if( target is Class )
			{
				return target as Class;
			}
			
			if( _class == null )
			{	
				var path:String = getQualifiedClassName( target );
				
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
			return new T( type );
		}
	}
}