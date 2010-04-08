package com.ffsys.utils.reflection.parser {
	
	import com.ffsys.io.xml.Parser;
	
	import com.ffsys.utils.reflection.Reflection;
	
	import com.ffsys.utils.reflection.Constant;
	import com.ffsys.utils.reflection.Factory;
	
	import com.ffsys.utils.reflection.SuperClass;
	import com.ffsys.utils.reflection.Interface;
	
	import com.ffsys.utils.reflection.members.Constructor;
	
	import com.ffsys.utils.reflection.members.Method;
	import com.ffsys.utils.reflection.members.Accessor;
	import com.ffsys.utils.reflection.members.PublicMemberVariable;
	
	import com.ffsys.utils.reflection.members.Parameter;
	
	import com.ffsys.utils.reflection.meta.MetaData;
	import com.ffsys.utils.reflection.meta.MetaDataItem;
	 
	/**
	*	Wrapper class for deserializing the XML representation
	*	of the return value from a call to describeType() to an object structure.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.07.2007
	*/
	public class DescribeTypeParser extends Parser {
	
		/**
		*	The String node name to map to the root class. 
		*/
		static public const ROOT_NODE_NAME:String = "type";
	
		/**
		*	The String name of the field to set on the created instances
		*	that refers to their parent instance.
		*/
		static public const PARENT_FIELD:String = "parent";		
		
		/**
		*	Creates a new AddressMapParser instance with the specified
		*	root Class and node Class.
		*
		*	@param root the Class to instantiate for the root node of the XML
		*	@param node the Class to instantiate for the individual nodes of the XML hierarchy
		*/
		public function DescribeTypeParser( root:Class = null, node:Class = null )
		{
			
			if( !node )
			{
				node = Object;
			}
			
			super( root, node );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			interpreter = new DescribeTypeInterpreter();
			
			classNodeNameMap.add( _root, ROOT_NODE_NAME );
			
			classNodeNameMap.add( Constant, "constant" );
			classNodeNameMap.add( Factory, "factory" );
			
			classNodeNameMap.add( SuperClass, "extendsClass" );
			classNodeNameMap.add( Interface, "implementsInterface" );
			classNodeNameMap.add( Constructor, "constructor", "constructorMethod" );
			classNodeNameMap.add( Method, "method" );
			classNodeNameMap.add( Accessor, "accessor" );
			classNodeNameMap.add( Parameter, "parameter" );
			classNodeNameMap.add( PublicMemberVariable, "variable" );
			classNodeNameMap.add( MetaData, "metadata" );
			classNodeNameMap.add( MetaDataItem, "arg" );			
		}
		
		/**
		*	Parses describeType() XML into an object structure.
		*
		*	@param x the XML to parse into an object hierarchy
		*
		*	@return the deserialized AddressMapRootNode instance
		*/
		public function parse( x:XML, root:Object ):Reflection
		{
			return _deserializer.deserialize( x, root ) as Reflection;
		}		
		
	}
	
}
