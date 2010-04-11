package com.ffsys.utils.string {
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.utils.describeType;
	import flash.net.registerClassAlias;
	
	/**
	*	Utility methods for inspecting and manipulating
	*	<code>Class</code> instances.
	*
	*	Note that this Class uses a lightweight form of Reflection for
	*	a lot of it's functionality, this consists of straight querying
	*	of the XML returned from a call to desribeType().
	*
	*	If you need a feature rich Reflection API see the
	*	com.ffsys.utils.reflection package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.05.2007
	*/
	public class ClassUtils extends Object {
		
		/**
		*	@private
		*/
		public function ClassUtils()
		{
			super();
		}
		
		/**
		*	Registers a class that will be encoded as part of an AMF packet
		*	this enables the class to be deserialized correctly when
		*	invoking ByteArray.readObject().
		*
		*	The key used as the alias is always the fully qualified class name
		*	as returned from getQualifiedClassName().
		*
		*	@param classReference the Class to register
		*/
		static public function registerClass( classReference:Class ):void
		{
			var n:String = getQualifiedClassName( classReference );
			registerClassAlias( n, classReference );
		}
		
		/**
		*	Determines whether an instance is a custom class.
		*
		*	A custom class is anything other than a primitive
		*	or Array/Object.
		*
		*	@param obj the instance to test
		*
		*	@return a Boolean indicating whether the class is custom
		*/
		static public function isCustomClass( obj:* ):Boolean
		{
			return ( !isPrimitive( obj ) && obj is Object && obj.constructor != Object && obj.constructor != Array );
		}
		
		static public function isComplex( obj:* ):Boolean
		{
			return ( !isPrimitive( obj ) && !isCustomClass( obj ) );
		}
		
		static public function isSimplePrimitive( obj:* ):Boolean
		{
			return ( obj is String || obj is Number || obj is Boolean );
		}
		
		static public function isComplexPrimitive( obj:* ):Boolean
		{
			return ( obj is Date || obj is XML || isPlainObject( obj ) || isPlainArray( obj ) );
		}
		
		static public function isPrimitive( obj:* ):Boolean
		{
			return ( isSimplePrimitive( obj ) || isComplexPrimitive( obj ) );
		}
		
		static public function isNull( obj:* ):Boolean
		{
			return ( !isPrimitive( obj ) && !obj );
		}
		
		static public function isPlainObject( obj:Object ):Boolean
		{
			return ( ( obj is Object ) && ( obj.constructor == Object ) );
		}
		
		static public function isPlainArray( obj:Object ):Boolean
		{
			return ( ( obj is Array ) && ( obj.constructor == Array ) );
		}
		
		/**
		*	Gets an XML instance representing all the public variables
		*	of an instance and all the <code>readwrite</code> accessor
		*	properties of an instance.
		*
		*	@param obj the instance whose public variables to list
		*
		*	@return an XML instance whose child nodes correspond to those
		*	from the <code>variable</code> and <code>accessor</code> nodes
		*	present in the XML returned from a call to describeType()
		*/
		static public function getPublicVariables( obj:* ):XML
		{
			var dx:XML = TypeRegistry.describe( obj );
			
			var x:XML = new XML( "<public />" );
			
			var publicVariables:XMLList = dx.variable;
			var accessorVariables:XMLList = dx.accessor.(@access == "readwrite");
			
			x.appendChild( publicVariables );
			x.appendChild( accessorVariables );
			
			return x;
		}
		
		static public function getMethodNames( instance:Object ):Array
		{
			var output:Array = new Array();
			
			var dx:XML = TypeRegistry.describe( instance );
			var methods:XMLList = dx.method;
			
			var x:XML;
			for each( x in methods )
			{
				output.push( x.@name );
			}
			
			return output;
		}
		
		/**
		*	Return the class type of a property declared on an instance.
		*
		*	@param obj the instance containing the property
		*	@param prop the String name of the property
		*	
		*	@return the Class type used for the property
		*/
		static public function getPropertyClass( obj:Object, prop:String ):Class
		{
			var x:XMLList = getPublicVariables( obj ).children();
			var node:XMLList = x.(@name == prop);
			
			var className:String = node.@type;
			var c:Class = getDefinitionByName( className ) as Class;
			return c;
		}
		
		/**
		*	
		*/
		static public function getClassDefinition( qualifiedClassPath:String ):Class
		{
			return getDefinitionByName( qualifiedClassPath ) as Class;
		}
		
		
		/**
		*	Gets a String representation of just the Class name for
		*	an instance. No namespace is included.
		*
		*	@param obj the Object instance
		*
		*	@return the String class name
		*/
		static public function getClassName( obj:Object ):String
		{
			
			var c:Class;
			
			if( obj is Class )
			{
				c = obj as Class;
			}else{
				c = obj.constructor as Class;
			}
			
			if( obj is XML )
			{
				c = XML;
			}
			
			if( obj is XMLList )
			{
				c = XMLList;
			}
			
			/*
			if( c == flash.utils.Dictionary )
			{
				trace( TypeRegistry.describe( obj ) );
			}
			*/
			
			//trace( "Is XML : " + ( obj is XML ) );
			//trace( "Is XMLList : " + ( obj is XMLList ) );
			//trace( "getClassName : " + c );
			
			var nm:String = StringUtils.parseClassName( getQualifiedClassName( c ) );
			
			//trace( "getClassName : " + nm );
			
			return nm;
		}
		
		/**
		*	Gets a String representation of a class name compatible with
		*	usage as an XML node name. Defaults to the class name with the
		*	first character converted to lower case.
		*
		*	@param obj the Object to get the String name from
		*
		*	@return the modified String name of the class used to instantiate the instance
		*/
		static public function getXmlNodeClassName( obj:Object ):String
		{
			return StringUtils.firstCharToLowerCase( getClassName( obj ) );
		}
		
		/**
		*	Returns a new instance of an Object based upon it's String
		*	fully qualified class name (including namespace).
		*
		*	@param a String of the fully qualified path to the Class
		*
		*	@return a new instance of that Class declared as the base Object type
		*/
		static public function getInstance( qualifiedClassName:String ):Object
		{
			var c:Class;
			var instance:Object;
			
			try {
				c = getDefinitionByName( qualifiedClassName ) as Class;
				instance = new c() as c;
			}catch( e:Error )
			{
				throw new Error(
					"ClassUtils.getInstance() error for: " + qualifiedClassName + "\n\n" + e.toString() );
			}
			
			return instance;
		}
		
		/**
		*	Accepts an Array of Class objects and determines whether the given value
		*	<code>is</code> of any of the given Class objects.	
		*/
		static public function isType( dataTypes:Array, value:Object ):Boolean
		{
			if( dataTypes )
			{
				var i:int = 0;
				var l:int = dataTypes.length;
				
				var classReference:Class;
				
 				for( ;i < l;i++ )
				{
					classReference = Class( dataTypes[ i ] );
					
					if( value is classReference )
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		/**
		*	Get the Class reference for an instance.
		*
		*	@param obj the Object instance
		*
		*	@return the Class that instantiated the instance
		*/
		static public function getClass( obj:Object ):Class
		{
			var name:String = getQualifiedClassName( obj );
			
			var c:Class;
			
			try {
				c = getDefinitionByName( name ) as Class;
			}catch( e:Error )
			{
				throw new new Error( 
					"Possible attempt to access a private class with getDefinitionByName()" );
			}
			return c;
		}
		
		/**
		*	Compares the types and values of a source instance
		*	and destination instance and returns a Boolean indicating
		*	whether they have the same values.
		*
		*	Note this means that <code>( source == dest )</code> can
		*	<code>false</code>, as they can be different instances.
		*/
		static public function compare( source:*, dest:* ):Boolean
		{
			var z:String = null;
			
			//trace( "Compare source : " + source );
			//trace( "Compare dest : " + dest );
			
			if( source && !dest )
			{
				return false;
			}
			
  			if( ( ( source is Number ) && ( dest is Number ) ) && ( isNaN( source ) && isNaN( dest ) ) )
			{
				return true;
			}
			
  			if( ( ( source is Date ) && ( dest is Date ) ) )
			{
				return ( source.toString() == dest.toString() );
			}
			
			if( ( ( source is XMLList || source is XML ) && ( dest is XMLList || dest is XML ) ) )
			{
				return ( source.toXMLString() == dest.toXMLString() );
			}
			
			
			//deal with null values
			if( isNull( source ) && isNull( dest ) )
			{
				return true;
			}
			
			//ensure they were instantiated from the same class
			if( ( source && !dest ) || ( !source && dest ) || getClass( source ) != getClass( dest ) )
			{
				return false;
			}
			
			//shortcut out if they are exactly the same instance
			if( source == dest )
			{
				return true;
			}
			
			//deal with primitive values using strict equality
			if( isSimplePrimitive( source ) )
			{
				return source === dest;
			}else if( source is Array )
			{
				return compareArray( source, dest );
			}else if( isPlainObject( source ) )
			{
				return compareObject( source, dest );
			}else if( ( source is XML ) || ( source is Date ) )
			{
				return ( source.toString() == dest.toString() )
			}else if( isCustomClass( source ) )
			{
				var x:XML = getPublicVariables( source );
				var list:XMLList = x.children();
				var node:XML;

				for each( node in list )
				{
					z = node.@name;
					
					if( !compare( source[ z ], dest[ z ] ) )
					{
						return false;
					}
				}				
			}
			
			return true;
		}
		
		static private function compareObject( source:*, dest:* ):Boolean
		{
			var z:String;
		
			for( z in source )
			{
				if( !compare( source[ z ], dest[ z ] ) )
				{
					return false;
				}
			}
			
			for( z in dest )
			{
				if( !compare( dest[ z ], source[ z ] ) )
				{
					return false; 
				}
			}
			
			return true;
		}		
		
		static private function compareArray( source:*, dest:* ):Boolean
		{
			var i:int = 0;
			var l:int = source.length;
			
			if( l != dest.length )
			{
				return false;
			}
			
			for( ;i < l;i++ )
			{
				if( !compare( source[ i ], dest[ i ] ) )
				{
					return false;
				}						
			}
			
			return true;
		}
		
		/**
		*	Performs a shallow copy of an object's public properties.
		*/
		static public function copy( o:Object ):*
		{
			if( isSimplePrimitive( o ) )
			{
				return o;
			}
			
			var c:Class = getClass( o );
			
			var out:Object = new c() as c;
			var z:String = null;
			
			for( z in o )
			{
				out[ z ] = o[ z ];
			}
			
			return out;
		}
		
		//-->
		
		/*
		static public function clone(source:Object):* {
		var copier:ByteArray = new ByteArray();
		copier.writeObject(source);
		copier.position = 0;
		return(copier.readObject());
		}		
		*/
		
		static public function clone( source:Object ):*
		{
		    var myBA:ByteArray = new ByteArray();
		    myBA.writeObject(source);
		    myBA.position = 0;
		    return(myBA.readObject());
		};
		
		/*
		static public function clone( obj:* ):*
		{
			
			trace( "CLONE  : " + obj );
			
			registerClass( getClass( obj ) );
			
			var tmp:ByteArray = new ByteArray();
			
			tmp.writeObject( obj );
			
			trace( "Byte array length : " + tmp.length );
			
			tmp.position = 0;
			
			trace( "Byte array position : " + tmp.position );
			
			var cloned:* = tmp.readObject();
			
			trace( "CLONED OBJECT : " + cloned );
			
			return cloned;
		};
		*/		
		
	}
	
}
