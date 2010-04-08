package com.ffsys.io.xml {
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.string.StringUtils;
		
	/**
	*	A <code>ClassNodeNameMap</code> is used during
	*	the deserialization of XML documents to map element
	*	names to the Actionscript <code>Class</code> instances
	*	the XML element(s) should be deserialized to.
	*
	*	Note that only the localName is used, there is no
	*	XML namespace integration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.07.2007
	*/
	public class ClassNodeNameMap extends Object {
		
		/**
		*	@private
		*	
		*	The default class to use if no mapping
		*	is found.
		*/
		private var _default:Class;
		
		/**
		*	@private
		*	
		*	The <code>Dictionary</code> instance used
		*	to store the mapping.
		*/
		private var _classDictionary:Dictionary;
	
		/**
		*	@private	
		*/
		private var _nodeNameDictionary:Dictionary;
		
		/**
		*	@private
		*/
		private var _propertyNameDictionary:Dictionary;
		
		/**
		*	Creates a <code>ClassNodeNameMap</code> instance.
		*	
		*	@param defaultClass The default <code>Class</code>
		*	to use when deserializing XML elements.
		*/
		public function ClassNodeNameMap( defaultClass:Class )
		{
			super();
			
			_classDictionary =
				new Dictionary( true );
				
			_nodeNameDictionary =
				new Dictionary( true );
				
			_propertyNameDictionary =
				new Dictionary( true );
			
			if( defaultClass )
			{
				_default = defaultClass;
				add( defaultClass );
			}
		}
		
		/**
		*	The default <code>Class</code> to use when
		*	deserializing XML elements.
		*/
		public function set defaultClass( val:Class ):void
		{
			_default = val;
		}
		
		public function get defaultClass():Class
		{
			return _default;
		}
		
		/**
		*	Adds a <code>Class</code> to the mapping.
		*
		*	By default adding a <code>Class</code> creates a
		*	<code>String</code> node name representation of
		*	the <code>Class</code> name if the
		*	<code>nodeName</code> parameter is not specified.
		*
		*	@param classReference The <code>Class</code> to add to the mapping.
		*	@param nodeName An optional <code>String</code> that represents the
		*	node name of the XML element that should be mapped to <code>classReference</code>.	
		*	@param An optional <code>String</code> corresponding to the property name that
		*	should be set on the parent instance when an element 
		*/
		public function add(
			classReference:Class = null,
			nodeName:String = null,
			propertyName:String = null,
			inferPropertyName:Boolean = false ):void
		{
			if( !classReference )
			{
				throw new Error(
					"Cannot add a null Class to a ClassNodeNameMap." );
			}
			
			if( !nodeName )
			{
				nodeName = ClassUtils.getClassName( classReference );
			}
			
			_classDictionary[ classReference ] = nodeName;
			_nodeNameDictionary[ nodeName ] = classReference;
			
			if( inferPropertyName )
			{
				propertyName = StringUtils.firstCharToLowerCase(
					ClassUtils.getClassName( classReference ) );
			}
			
			if( propertyName )
			{
				_propertyNameDictionary[ nodeName ] = propertyName;
			}
		}
		
		/**
		*	Determines whether this instance contains a
		*	mapping with a given XML element name.
		*	
		*	@param name The node name to test for existence.
		*	
		*	@param A <code>Boolean</code> indicating whether
		*	the node name exists in this mapping.
		*/
		public function hasNodeName( name:String ):Boolean
		{
			return ( _nodeNameDictionary[ name ] != null );
		}
		
		/**
		*	Determines whether this instance contains a
		*	mapping with a given <code>Class</code>.
		*	
		*	@param classReference The <code>Class</code>
		*	to test for existence.
		*	
		*	@param A <code>Boolean</code> indicating whether
		*	the <code>Class</code> exists in this mapping.
		*/		
		public function hasClass( classReference:Class ):Boolean
		{
			return ( _classDictionary[ classReference ] != null );
		}
		
		/**
		*	Gets the property name that should be set on
		*	the parent instance when an XML element is
		*	deserialized to an <code>Object</code>.
		*	
		*	@param name The XML element node name.
		*	
		*	@return The corresponding <code>String</code>
		*	property name in the mapping.
		*/
		public function getPropertyByNodeName( name:String ):String
		{
			return _propertyNameDictionary[ name ];
		}
		
		/**
		*	Gets the <code>Class</code> that corresponds to
		*	an XML node name.
		*	
		*	If no corresponding mapping can be found this method
		*	will return <code>defaultClass</code>.
		*	
		*	@param name The XML element node name.
		*	
		*	@return The corresponding <code>Class</code> in the
		*	mapping or <code>null</code>.
		*/
		public function getClassByNodeName( name:String ):Class
		{
			if( hasNodeName( name ) )
			{
				return _nodeNameDictionary[ name ];
			}
			
			return defaultClass;
		}
		
		/**
		*	Removes a <code>Class</code> from the mapping.
		*
		*	@param classReference The <code>Class</code> to remove.
		*/		
		public function remove( classReference:Class ):void
		{
			delete _classDictionary[ classReference ];
			
			var key:Object;
			
			for( key in _nodeNameDictionary )
			{
				if( _nodeNameDictionary[ key ] == classReference )
				{
					delete _nodeNameDictionary[ key ];
				}
			}
		}
	}
}