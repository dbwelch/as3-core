package com.ffsys.utils.reflection {
	
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.utils.boolean.BooleanUtils;
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.string.StringUtils;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Base class for all instances deserialized from the
	*	XML representation of an instance returned
	*	from describeType().
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class AbstractReflection extends Object
		implements  IReflection,
					IObjectInspector {
						
		private var _parent:IReflection;
		private var _dataType:DataType;
		
		/**
		*	@private
		*/
		public function AbstractReflection()
		{
			super();
		}
		
		/**
		*	IDataType implementation.
		*/
		public function getQualifiedClassPath():String
		{
			if( !_dataType )
			{
				return null;
			}
			
			return _dataType.getQualifiedClassPath();
		}
		
		public function getClass():Class
		{
			if( !_dataType )
			{
				return null;
			}
						
			return _dataType.getClass();
		}
		
		public function getClassName():String
		{
			if( !_dataType )
			{
				return null;
			}
						
			return _dataType.getClassName();
		}
		
		public function getPackageName():String
		{
			if( !_dataType )
			{
				return null;
			}
						
			return _dataType.getPackageName();
		}
		
		public function isVoid():Boolean
		{
			if( !_dataType )
			{
				return false;
			}
			
			return _dataType.isVoid();
		}
		
		public function isWildcardType():Boolean
		{
			if( !_dataType )
			{
				return false;
			}
						
			return _dataType.isWildcardType();
		}
		
		/*
		*	IReflectionParent implementation.
		*/		
		public function set parent( val:IReflection ):void
		{
			_parent = val;
		}
		
		public function get parent():IReflection
		{
			return _parent;
		}
		
		/**
		*	Alias for getQualifiedClassPath().
		*/
		public function get type():String
		{
			return getQualifiedClassPath();
		}
		
		/*
		*	Utility methods.
		*/
		
		/**
		*	@private
		*
		*	Given a String fully qualified path to a Class in the form:
		*
		*	com.ffsys.utils::ClassUtils
		*
		*	This method will return the Class that the String path refrences.
		*
		*	@param the fully qualified class path
		*
		*	@return the Class instance
		*/		
		protected function getClassDefinition( path:String ):Class
		{
			return getDefinitionByName( path ) as Class;
		}
		
		protected function getSanitizedToString( val:String ):String
		{
			return StringUtils.getClassString( val );
		}
				
		public function parseClassName( val:String ):String
		{
			return StringUtils.parseClassName( val );
		}
		
		public function parsePackageName( val:String ):String
		{
			return StringUtils.parsePackageName( val );
		}
		
		protected function toBoolean( val:String ):Boolean
		{
			return BooleanUtils.stringToBoolean( val );
		}
		
		/**
		*	@private
		*/
		public function set type( val:String ):void
		{
			if( !_dataType )
			{
				_dataType = new DataType();
				_dataType.parse( val );
			}
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			
			output.className = getClassName();
			output.qualifiedClassPath = getQualifiedClassPath();
			output.type = getClass();		
			
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			return output;
		}

		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			//add a detail Object if necessary
			//output.detail = new Object();
			
			//pass in the default methods, properties and composites
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		public function toString():String
		{
			return getObjectString( true );
		}
		/* END OBJECT_INSPECTOR REMOVAL */		
					
	}
	
}
