package com.ffsys.utils.reflection {
	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.utils.reflection.members.IMember;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;	
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Base class for all collections.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class AbstractReflectionCollection extends Array
		implements  IReflectionCollection,
					IObjectInspector {
						
		private var _parent:IReflection;	
		
		protected var _actionscriptNewlineBreak:String;							
		
		public function AbstractReflectionCollection()
		{
			super();
			_actionscriptNewlineBreak = StringUtils.NEWLINE;
		}
		
		protected function hasMember( memberName:String ):Boolean
		{
			var i:int = 0;
			var l:int = this.length;
			
			var member:IReflection;
			
			for( ;i < l;i++ )
			{
				member = this[ i ];
				
				if(
					( member is IMember ) &&
					( member as IMember ).name == memberName
				)
				{
					return true;
				}
			}
			
			return false;		
		}
		
		/**
		*	Gets an Array of all the member names contained in this collection.
		*
		*	If this collection does not contain any IMember instances
		*	an empty Array is returned.
		*
		*	@return an Array of String names of all the members in this collection
		*/
		public function getMemberNames():Array
		{	
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = this.length;
			
			var member:IReflection;
			
			for( ;i < l;i++ )
			{
				member = this[ i ];
				
				if( member is IMember )
				{
					output.push( ( member as IMember ).name );
				}
				
			}
			
			return output;
		}
		
		/**
		*	Gets an Actionscript style String representation of this instance.
		*
		*	@return an Actionscript style String
		*/
		public function getActionscriptString(
			ignoreTypeInformation:Boolean = false ):String
		{
			var str:String = "";
			var i:int = 0;
			var l:int = this.length;
	
			for( ;i < l;i++ )
			{
				str += this[ i ].getActionscriptString() +
					_actionscriptNewlineBreak;
			}
			
			return str;
		}		
		
		/**
		*	Gets an Array of the Class definitions for all the members in
		*	this collection.
		*
		*	@return an Array of Class objects
		*/
		public function getClassDefinitions():Array
		{
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = this.length;
			
			var member:IReflection;
			
			for( ;i < l;i++ )
			{
				member = this[ i ];
				output.push( member.getClass() );
			}
			
			return output;			
		}
		
		/*
		*	IDataType implementation.
		*
		*	Proxies everything through to the parent Reflection.
		*/

		public function getQualifiedClassPath():String
		{
			return parent.getQualifiedClassPath();
		}
		
		public function getPackageName():String
		{
			return parent.getQualifiedClassPath();
		}
		
		public function getClassName():String
		{
			return parent.getClassName();
		}		
		
		public function getClass():Class
		{
			return parent.getClass();
		}
		
		public function isVoid():Boolean
		{
			return parent.isVoid();
		}
		
		public function isWildcardType():Boolean
		{
			return parent.isWildcardType();
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
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			return output;
		}

		public function getCommonStringOutputComposites():Array
		{
			return this;
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
