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
	* 	with a class definition and is used as the core
	* 	for the reflection logic that extends on the language
	* 	features for describing a class definition as XML.
	* 
	* 	Note that this implementation exploits the <code>dynamic</code>
	* 	nature of <code>class</code> definitions as the logical place
	* 	to cache any reflected information. The only internal reference
	* 	that a T instance maintains is a reference to the <code>class</code>
	* 	exposed by the <code>definition</code> property, all other properties
	* 	accessible via a T are convenience methods for working on
	* 	the class definition or any data cached in the class.
	* 
	* 	Once the getInstance() method has retrieved a T type
	* 	definition for a <code>class</code> any subsequent calls to
	* 	getInstance() with an object of the same <code>class</code>
	* 	will return an existing cached T definition.
	* 
	* 	When a T has been retrieved for a <code>class</code> definition
	* 	various properties can be accessed directly on the class itself.
	* 
	* 	For example, to introspect T itself:
	* 
	* 	<pre>var tt:T = T.getInstance( T );
	*	Assert.assertNotNull( tt );
	*	for( var z:String in T )
	*	{
	*	  trace( z, T[ z ] );
	*	}</pre>
	* 
	* 	This creates a T for the T type itself and then iterates over the
	* 	<code>class</code> producing output such as:
	* 
	* 	<pre>pkg java.lang
	*	name T
	*	mirror [object T]
	*	path java.lang::T</pre>
	* 
	* 	Once a T is generated for a class definition it is accessible via
	* 	the <code>mirror</code> property of the class. A less convoluted example:
	* 
	* 	<pre>var s:T = T.getInstance( Sprite );
	*	for( var z:String in Sprite )
	*	{
	*	  trace( z, Sprite[ z ] );
	*	}</pre>
	* 
	* 	Produces:
	* 
	* 	<pre>name Sprite
	*	mirror [object T]
	*	pkg flash.display
	*	path flash.display::Sprite</pre>
	* 
	* 	@todo Ensure that static variables are also included in the XML,
	* 	this will require reflecting the class (as opposed to the instance)
	* 	and caching the static members.
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
		* 
		* 	You should <strong>never instantiate this class
		* 	directly</strong>, see the getInstance() contract
		* 	for full information.
		* 
		* 	@param type The source instance or class
		* 	that this T represents, when the specified
		* 	type is an instance this T will represent the
		* 	class of the instance.
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
					
					//create a mirror reference on the class definition
					Object( _class ).mirror = this;
				}
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
			if( clazz.xml == null )
			{
				//cache the type reflection info
				//TODO: allow this to be done lazily - when reflection 
				//data is first retrieved!
				Object( _class ).xml = describeType( _class );				
			}
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
		* 	Retrieves class definition information
		* 	for a type.
		* 
		* 	You always use this static factory method
		* 	to retrieve a T definition.
		* 
		* 	@param type instance to retrieve class
		* 	definition from.
		*/
		public static function getInstance( type:* ):T
		{
			//TODO: handle null/undefined etc.
			var t:T = null;
			var constr:Object = null;
			if( type is Object )
			{
				constr = type.constructor;
				t = __types[ constr ] as T;
			}
			
			if( t != null )
			{	
				return t;
			}
			
			t = new T( type );
			__types[ t.definition ] = t;
			return t;
		}
		
		/**
		* 	Retrieves a <code>Vector</code> that is defined
		* 	as being of the specified type.
		* 
		* 	When a non-zero <code>capacity</code> parameter is specified
		* 	a fixed length vector will be created.
		* 
		* 	<strong>Note:</strong> We would prefer to
		* 	declare this return type as <code>Vector.&lt;Object&gt;</code>;
		* 	but currently the compiler has a bug when referencing a class that
		* 	declares a static method that returns a typed <code>Vector</code>.
		* 	This bug is only apparent when depending upon a swc which
		* 	includes a class with a static method that returns a vector,
		* 	the error would be:
		* 	
		* 	<pre>Unexpected multiname type: 16
		*	Unexpected multiname type: 16
		* 	...
		* 	Error: Type was not found or was not a compile-time constant: .</pre>
		* 
		* 	When compiling against the offending swc file.
		* 
		* 	<p>To create a <code>Vector</code> of <code>Array</code> instances:</p>
		* 
		* 	<pre>var arrays:Vector.&lt;Array&gt; = T.vector( Array ) as Vector.&lt;Array&gt;;</pre>
		* 
		* 	@throws ArgumentError If a capacity is specified
		* 	indicating a fixed length vector and the number of
		* 	contents specified exceeds the length of the fixed
		* 	vector.
		* 
		* 	@throws TypeError If any of the contents are not
		* 	of the specified <code>type</code>.
		* 
		* 	@param type The parameterized type of the vector.
		* 	@param capacity A fixed size for the vector.
		* 	@param contents Contents to propagate into
		* 	the new vector, they must all be of the same
		* 	class specified as the type parameter.
		* 
		* 	@return A vector of the specified type.
		*/
		public static function vector(
			type:Class,
			capacity:uint = 0,
			... contents ):Object
		{
			var v:Object = null;
			if( type != null )
			{
				var fqn:String = null;
				var t:T = Object( type ).type as T;
				if( !t )
				{
					t = getInstance( type );
				}
				fqn = VECTOR_PREFIX + t.path + VECTOR_SUFFIX;
				try
				{
					var clazz:Class = getDefinitionByName( fqn ) as Class;
					
					//expando vector
					if( capacity == 0 )
					{
						v = new clazz();
					}else{
						//fixed capacity vector
						v = new clazz( capacity, true ) as Vector;
					}
				}catch( e:Error )
				{
					throw e;
				}
			}
			
			if( contents != null )
			{
				if( capacity > 0 && contents.length > capacity )
				{
					throw new ArgumentError(
						"The vector contents exceeds it's capacity." );
				}
				for( var i:int = 0;i < contents.length;i++ )
				{
					try
					{
						v[ i ] = contents[ i ];
					}catch( e:Error )
					{
						//if the user supplied an invalid type
						//in the contents array the coercion may fail
						throw e;
					}
				}
			}
			return v;
		}
	}
}