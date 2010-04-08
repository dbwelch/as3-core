package com.ffsys.utils.reflection {
	
	/**
	*	Represents an individual data type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class DataType extends AbstractReflection
		implements IDataType {
		
		private var _qualifiedClassPath:String;
		private var _className:String;
		private var _packageName:String;
		private var _classReference:Class;
		
		public function DataType()
		{
			super();
		}
		
		/**
		*	Gets the fully qualified path to this data type.
		*
		*	Note that if the data type is void a String of
		*	'void' is returned and similarly the behaviour is
		*	the same for the wildcard '*' type.
		*
		*	@return a String of the fully qualified path to this data type
		*/
		override public function getQualifiedClassPath():String
		{
			return _qualifiedClassPath;
		}
		
		/**
		*	Gets the package name as a String of this data type.
		*
		*	If this data type is top-level (does not exist in a package)
		*	this method will return a blank String.
		*
		*	@return a String of the package name for this type
		*/
		override public function getPackageName():String
		{
			return _packageName;
		}
		
		/**
		*	Gets a String of the Class name of this data type.
		*
		*	@return the Class name as a String
		*/
		override public function getClassName():String
		{
			return _className;
		}
		
		/**
		*	Gets the Class of this data type.
		*
		*	@return the Class of this data type
		*/
		override public function getClass():Class
		{
			return _classReference;
		}
		
		/**
		*	Determines whether this data type is void.
		*
		*	Only applies to the return value of methods but exists
		*	for all data types.
		*
		*	@return a Boolean indicating whether this data type is void
		*/
		override public function isVoid():Boolean
		{
			return ( _qualifiedClassPath == Reflection.VOID );
		}
		
		/**
		*	Determines whether this data type is a wildcard (*).
		*
		*	@return a Boolean indicating whether this data type is a wildcard
		*/		
		override public function isWildcardType():Boolean
		{
			return ( _qualifiedClassPath == Reflection.WILDCARD );
		}
		
		/**
		*	@private
		*
		*	Performs the intial conversion as the XML returned
		*	from the describeType() method is deserialized.
		*
		*	Sets up all the available information for this data type.
		*/
		internal function parse( val:String ):void
		{
			if(
				val != Reflection.VOID &&
				val != Reflection.WILDCARD )
			{			
				_classReference = getClassDefinition( val );
				_className = parseClassName( val );
				_packageName = parsePackageName( val );
			}
			
			_qualifiedClassPath = val;
		}		
		
	}
	
}
