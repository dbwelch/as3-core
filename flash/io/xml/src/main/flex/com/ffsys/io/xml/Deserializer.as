package com.ffsys.io.xml {
	
	import flash.utils.getDefinitionByName;
	
	//-->
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.io.xml.DeserializeError;
	
	import com.ffsys.utils.array.ArrayUtils;
	import com.ffsys.utils.boolean.BooleanUtils;
	import com.ffsys.utils.object.ClassUtils;
	import com.ffsys.utils.string.PropertyNameConverter;
	import com.ffsys.utils.string.StringUtils;
	import com.ffsys.utils.xml.XmlUtils;
	
	import com.ffsys.utils.substitution.IBindingCollection;
	import com.ffsys.utils.substitution.BindingCollection;
	
	import com.ffsys.utils.merge.IMergable;
	
	/**
	*	Handles deserializing XML instances to Class and primitive values.
	*
	*	By default the Serializer uses a 'class' attribute to determine
	*	the Class to be instantiated. If this attribute is present it
	*	determines the Class to be used.
	*
	*	If the 'class' attribute is not present the node name is used
	*	to determine the Class of the object to be instantiated.
	*
	*	Setting a ClassNodeNameMap on the Deserializer instance indicates
	*	a mapping between a Class and a String node name.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.05.2007
	*
	*	@see ClassNodeNameMap
	*/
	public class Deserializer extends Object
		implements ISerializeDeserializeProperty {
		
		static public var defaultBindings:IBindingCollection
			= new BindingCollection();
		
		/**
		*	A ClassNodeNameMap instance associated with this Deserializer instance.
		*/
		private var _nodeNameMap:ClassNodeNameMap;
		
		/**
		*	A ClassParserMap instance associated with this Deserializer instance.
		*/
		private var _classParserMap:ClassParserMap;
		
		/**
		*	An IDeserializeInterpreter instance associated with this Deserializer instance. 
		*/
		private var _interpreter:IDeserializeInterpreter;
		
		/**
		*	A String name indicating the parent property to set
		*	on the target instance.
		*/
		private var _parentField:String;
		
		/**
		*	Contains the String that determines the name of the
		*	attribute or child node to use for the property name
		*	to deserialize into.
		*/
		private var _propertyField:String;
		
		/**
		*	Determines the type used for the propertyField
		*	this can be either an attribute, a child node
		*	or the node name of the current node.
		*/
		private var _propertyFieldType:String;
		
		/**
		*	Determines whether attributes are parsed prior
		*	to the deserialization of child nodes or after.
		*/
		private var _preAttributeParse:Boolean;
		
		private var _mode:String;
		
		private var _ignoreEmptyNodes:Boolean;
		
		/**
		*	Instantiates a new Deserializer instance.
		*/
		public function Deserializer()
		{
			super();
			
			_preAttributeParse = true;
			
			_propertyField = Serializer.DEFAULT_PROPERTY_FIELD;
			_propertyFieldType = Serializer.DEFAULT_PROPERTY_FIELD_TYPE;
			
			_mode = DeserializationMode.POST_PROPERTY_SET;
			
			if( defaultBindings && ( defaultBindings.getLength() > 0 ) )
			{
				_interpreter = new DeserializeInterpreter( true, true );
			}
			
		}
		
		public function set ignoreEmptyNodes( val:Boolean ):void
		{
			_ignoreEmptyNodes = val;
		}
		
		public function get ignoreEmptyNodes():Boolean
		{
			return _ignoreEmptyNodes;
		}

		public function set preAttributeParse( val:Boolean ):void
		{
			_preAttributeParse = val
		}
		
		public function get preAttributeParse():Boolean
		{
			return _preAttributeParse;
		}
		
		public function set mode( val:String ):void
		{
			_mode = val
		}
		
		public function get mode():String
		{
			return _mode;
		}		
		
		public function set propertyField( val:String ):void
		{
			_propertyField = val
		}
		
		public function get propertyField():String
		{
			return _propertyField;
		}
		
		public function set propertyFieldType( val:String ):void
		{
			if( !PropertyFieldType.isValidType( val ) )
			{
				throw new Error(
					"Cannot set invalid property field type '" + val + "'." );
			}
		
			_propertyFieldType = val;
		}
		
		public function get propertyFieldType():String
		{
			return _propertyFieldType;
		}		
		
		/**
		*	Sets a String to be used as the property name for
		*	setting parent references.
		*/
		public function set parentField( val:String ):void
		{
			_parentField = val;
		}
		
		/**
		*	Gets the String property name used for setting parent
		*	references.
		*/
		public function get parentField():String
		{
			return _parentField;
		}
		
		/**
		*	Determines whether a parentField property has been set
		*	in which case the Deserializer will attempt to see parent
		*	references using the parentField String as the property name.
		*/
		public function hasParentField():Boolean
		{
			return ( _parentField != null );
		}
		
		/**
		*	Sets a ClassNodeNameMap instance to be assocaited with this Deserializer.
		*
		*	@param val the ClassNodeNameMap to associate
		*/
		public function set nodeNameMap( val:ClassNodeNameMap ):void
		{
			_nodeNameMap = val;
		}
		
		/**
		*	Gets the ClassNodeNameMap associated with this instance.
		*
		*	@return a ClassNodeNameMap instance or null if no instance has been set
		*/
		public function get nodeNameMap():ClassNodeNameMap
		{
			return _nodeNameMap;
		}
		
		public function set classParserMap( val:ClassParserMap ):void
		{
			_classParserMap = val;
		}
		
		public function get classParserMap():ClassParserMap
		{
			return _classParserMap;
		}		
	
		/**
		*	Determines whether a ClassNodeNameMap has been set on this instance.
		*
		*	@return a Boolean indicating whether a ClassNodeNameMap has been set
		*/
		public function hasNodeNameMap():Boolean
		{
			return ( _nodeNameMap != null );
		}
		
		/**
		*	Sets a IDeserializeInterpreter instance to be associated with this Deserializer.
		*
		*	@param val the IDeserializeInterpreter to associate
		*/
		public function set interpreter( val:IDeserializeInterpreter ):void
		{
			_interpreter = val;
			_interpreter.deserializer = this;
		}
		
		/**
		*	Gets the IDeserializeInterpreter associated with this instance.
		*
		*	@return a IDeserializeInterpreter instance or null if no instance has been set
		*/
		public function get interpreter():IDeserializeInterpreter
		{
			return _interpreter;
		}
		
		/**
		*	Determines whether an IDeserializeInterpreter has been set on this instance.
		*
		*	@return a Boolean indicating whether a IDeserializeInterpreter has been set
		*/
		public function hasInterpreter():Boolean
		{
			return ( _interpreter != null );
		}
		
		/**
		*	Sets a property on an object.
		*
		*	@param obj the Object to set the property on
		*	@param prop the String name of the property to set
		*	@param val the value to set the property to
		*/
		
		//TODO: remove the rawStringValue parameter
		//TODO: make this private
		public function setProperty(
			obj:*, prop:String, val:*,
			rawStringValue:String = null ):void
		{
			/*
			trace( "setProperty obj : " + obj );
			trace( "setProperty prop : " + prop );
			trace( "setProperty value : " + val, getQualifiedClassName( val ) );
			trace( "setProperty rawStringValue : " + rawStringValue );
			*/
			
			//trace("Deserializer::setProperty()", hasInterpreter(), _interpreter, obj, prop, val );
			
			if( hasInterpreter()
				&& !_interpreter.shouldSetProperty( obj, prop, val ) )
			{
				return;
			}
			
			//quick fix for hyphenated property names
			//should be moved to a property converter implementation
			//associated with the class node name map
			if( prop.indexOf( "-" ) > -1 )
			{
				var converter:PropertyNameConverter = new PropertyNameConverter();
				prop = converter.convert( prop );
			}
			
			if( obj is IDeserializeProperty )
			{
				obj.setDeserializedProperty( prop, val );
			} else if (val is IMergable) {
				if (obj[prop] == null) {
					obj[prop] = val;
				} else {
					obj[prop] = (val as IMergable).mergeInto(obj[prop]);
				}
			} else{
				try {
					
					//the index must be numeric for it to be treated as an array
					//entry - otherwise we treat it as an attribute value
					//and is set as a straight property
					if( ( obj is Array ) || ( prop is int ) )
					{
						if( ( obj is Array ) && !( prop is int ) && obj.hasOwnProperty( prop ) )
						{
							obj[ prop ] = val;
						}else{
							obj.push( val );
						}
					}else{
						//for primitive values we use valueOf()
						//on the raw string value
						
						//note that we don't use valueOf() for Boolean
						//values as assigning "false".valueOf() to a 
						//Boolean type results in a true Boolean value
						if( ( ( val is Number ) ||
						 	( val is String ) ) &&
						 	( rawStringValue != null ) )
						{
							//trace("Deserializer::setProperty(), using raw string value of " + rawStringValue );
							obj[ prop ] = rawStringValue.valueOf();
						}else{
							//otherwise stright property assignment
							obj[ prop ] = val;
						}
					}
					
				}catch( e:Error ) {
					
					throw new DeserializeError(
						"Could not set property '" +
						prop + "' on " +
						obj + " with value '" +
						val + "'\n\n" + e.toString() );
				}
			}
		}
		
		public function getNodeTextValue( node:XML ):String
		{
			var textValue:String = node.text()[ 0 ];
			return textValue;
		}
		
		public function getPrimitiveValue(
			node:XML = null,
			obj:Object = null,
			nodeName:String = null,
			inputValue:* = null,
			attribute:Boolean = false ):Object
		{
			var propertyValue:*;
			
			var textValue:String = getNodeTextValue( node );
			
			if( attribute && nodeName )
			{
				textValue = node.@[ nodeName ];
			}
			
			var numericValue:Number = NaN;
			
			//test for positive String length
			//because Number( "" ) == 0
			if( textValue && textValue.length )
			{
				numericValue = Number( textValue );
			}
			
			/*
			if( numericValue.toString() != textValue )
			{
				numericValue = NaN;
			}
			*/
			
			if( ( inputValue || new String( inputValue ) == Serializer.NAN_VALUE_NAME ) )
			{
				propertyValue = inputValue;
			}else if( textValue == "null" )
			{
				propertyValue = null;
			}else{
				if( BooleanUtils.stringIsBoolean( textValue ) )
				{
					propertyValue = BooleanUtils.stringToBoolean( textValue );
				}else{
					//dealing with a string value
					if( isNaN( numericValue ) )
					{
						//deal with complex primitives such as Date/XML
						var className:String = node.@[ Serializer.CLASS_ATTRIBUTE_NAME ];
						
						if( !className )
						{
							/*
							className = nodeName;
							
							try {
								var c:Class = getDefinitionByName( className ) as Class;

								if( c )
								{
									propertyValue = new c( textValue ) as c;
								}

							}catch( e:Error )
							{
								propertyValue = textValue;
							}							
							*/
							
							propertyValue = textValue;
							
						}
					
					}else{
				
						//we're dealing with an integer
						if( parseInt( textValue ) == numericValue )
						{
							numericValue = parseInt( textValue );
						}
						
						propertyValue = numericValue;
					}
			
				}
			}

			return propertyValue;			
		}
		
		/**
		*	Deserializes a primitive value.
		*
		*	@param node the XML node to extract the primitive value from
		*	@param obj an Object to set the property on
		*	@param nodeName an optional String node name to use
		*
		*	@returns the deserialized primitive value
		*/
		public function deserializePrimitive(
			node:XML = null,
			obj:Object = null,
			nodeName:String = null,
			inputValue:* = null,
			attribute:Boolean = false ):Object
		{
			var name:String = node.name().localName;
			
			if( _propertyFieldType == PropertyFieldType.CHILD_NODE )
			{
				if( name == _propertyField )
				{
					return null;
				}
			}
			
			if( !attribute )
			{
				
				if(
					node.hasComplexContent() &&
					( node.children().length() > 0 ) &&
					!( name == Serializer.NAN_VALUE_NAME ) &&
					!( name == Serializer.NULL_VALUE_NAME ) )
				{
					throw new DeserializeError(
						"Cannot parse to a primitive if the node contains complex child nodes - node.isSimpleContent() should be true." );
				}
			
			}			
			
			if( nodeName )
			{
				name = nodeName;
			}
			
			if( hasNodeNameMap() && !attribute )
			{
				if( _nodeNameMap.hasNodeName( name ) )
				{
					
					var classReference:Class = _nodeNameMap.getClassByNodeName( name );
					return deserializeClass( classReference, obj, node, nodeName );
				}
			}		
		
			var propertyValue:Object = getPrimitiveValue(
				node, obj, nodeName ? nodeName : name, inputValue, attribute );
				
			if(
				!attribute &&
				( node.children().length() == 0 ) &&
				( !( name == Serializer.NAN_VALUE_NAME ) &&
				!( name == Serializer.NULL_VALUE_NAME ) ) )
			{
			
				//trace( "Invalid Node name : " + name );
				//trace( "Invalid Node name : " + ( name == Serializer.NAN_VALUE_NAME ) );
				//trace( "Invalid Node : " + node.toXMLString() );
				
				/*
				throw new DeserializeError(
					"Cannot parse '" + name + "' to a primitive if the node contains no child nodes." );
				*/
				
				//force to a blank String when a primitive node is empty
				propertyValue = "";
			}				
			
			if( obj )
			{
				//we only set the property value
				//if we're not parsing from an attribute
				if( !attribute )
				{
					//setProperty( obj, name, propertyValue, getNodeTextValue( node ) );
					
					setProperty( obj, name, propertyValue );
				}
			}
			
			if( hasInterpreter() )
			{
				if( _interpreter.shouldPostProcessPrimitive( obj, name, propertyValue ) )
				{
					_interpreter.postProcessPrimitive( obj, name, propertyValue );
				}
			}
			
			return propertyValue;
		}
		
		/**
		*	Deserializes a Class based instance.
		*
		*	@param className the String fully qualified class name
		*	@param obj the current Object to deserialize into
		*	@param node the current XML node to deserialize
		*	@param nodeName an optional nodeName to use as the property to set on the parent Object
		*
		*	@return the deserialized instance 
		*/
		private function deserializeClass(
			classReference:Class, obj:Object, node:XML, nodeName:String ):Object
		{
			
			var name:String = node.name().localName;
			
			//trace("Deserializer::deserializeClass(), " + name );
			
			var classInstance:*;
			
			var propertyName:String = getPropertyName( node );
			
			//trace( "deserializeClass : " + name );			
			
			if(
				( classReference == String ) ||
				( classReference == Number ) ||
				( classReference == Boolean ) )
			{
				
				var propertyValue:* = getPrimitiveValue( node, obj, nodeName, null, false );
				
				/*
				trace( "deserializeClass with primitive Class propertyName : " + propertyName );
				trace( "deserializeClass with primitive Class propertyValue : " + propertyValue );
				*/
				
				setProperty( obj, propertyName, propertyValue );
				
				return null;
			}
			
			//deal with custom parsers for individual nodes
			if( hasParser( node ) )
			{
				
				//trace( "HAS PARSER : " + node.toXMLString() );
				
				var parser:IParser = getParser( node );
				
				//we cast to an Object because the parse() method
				//is not declared in the IParser interface as the
				//return type for the parse() method will vary depending
				//upon the instance
				var parsed:Object = ( parser as Object ).parse( node ) as Object;
				
				setProperty( obj, propertyName, parsed );
				
				return parsed;
			}
			
			//trace( "Deserialize class : " + classReference );
			
			/*
			if( propertyName == "arg" )
			{
				trace( "ARG NODE FOUND : " + obj );
				trace( "ARG NODE FOUND : " + propertyName );
			}
			*/
			
			//trace("Deserializer::deserializeClass()", propertyName );
			
			if( obj && obj is Array && !( obj.hasOwnProperty( propertyName ) ) )
			{
				propertyName = node.childIndex();
			}
			
			var hasExistingInstance:Boolean = (
				obj
				&& obj.hasOwnProperty( propertyName )
				&& obj[ propertyName ] != null );
				
			//trace( "Has existing instance : " + hasExistingInstance );
			
			var interpreted:Boolean = false;
			
			if( hasInterpreter() )
			{
				interpreted = _interpreter.shouldProcessClass( node, obj, classReference );
				
				//trace("Deserializer::deserializeClass() hasInterpreter()", interpreted );
				
				if( interpreted )
				{
					classInstance = _interpreter.processClass( node, obj, classReference );
					
					var proceed:Boolean = _interpreter.shouldParseClassInstanceChildren(
						node, obj, classReference, classInstance );
					
					//the interpreter is handling parsing child elements
					if( !proceed )
					{
						return classInstance;
					}
				}
			}
			
			if( !hasExistingInstance && classInstance == null )
			{
				//--> TODO: Test classReference is null and throw runtime error
				if( classReference == null )
				{
					throw new Error( "Could not find a Class for complex node: " + name );
				}				
			
				try {
					if( classReference == Date )
					{
						classInstance = new classReference( node.text()[ 0 ] ) as classReference;
					}else if( classReference == XML || classReference == XMLList )
					{
						classInstance = new classReference( node.children() ) as classReference;
						delete node.*;
					}else{
						classInstance = new classReference() as classReference;
					}
				}catch( e:Error )
				{
					throw new DeserializeError( "Could not instantiate : " +
						classReference +
						". Ensure that the constructor does not require arguments."
					);
				}
			
			}else if( hasExistingInstance && classInstance == null )
			{
				
				//trace( "Has existing instance : " + obj );
				//trace( "Has existing instance : " + propertyName );
				
				classInstance = obj[ propertyName ];
				
				//trace( "Has existing instance : " + classInstance );
			}

			if( mode == DeserializationMode.PRE_PROPERTY_SET )
			{
				if( obj )
				{
					setProperty( obj, propertyName, classInstance );
				}
			}
			
			//trace( "Deserialize class instance : " + classInstance );	
			
			if( obj )
			{
				if( hasParentField() )
				{
					if( Object( classInstance ).hasOwnProperty( _parentField ) )
					{
						try {
							classInstance[ _parentField ] = obj;
						}catch( e:Error )
						{
							//we fail silently if the parent property could not be set
						}
					}
				}
			}
			
			//trace( "Send for parse attributes : " + obj );
			
			if( _preAttributeParse )
			{
				parseAttributes( node, classInstance );
			}
			
			//we only try to set a property on the Object
			//if it exists
			if( obj )
			{
				//trace( "Deserializer set property : " + obj );
				//trace( "Deserializer set property : " + nodeName );
				
				if( !( ( classInstance is XML ) || ( classInstance is XMLList ) ) )
				{
					
					//recurse through child nodes
					parse( node, classInstance );
					
					if( !_preAttributeParse )
					{
						parseAttributes( node, classInstance );
					}												
					
					if( hasInterpreter() )
					{
						_interpreter.postProcess( node, classInstance, obj );
					}
				}
				
				if( mode == DeserializationMode.POST_PROPERTY_SET )
				{
					setProperty( obj, propertyName, classInstance );
				}

			}		
			
			if( hasInterpreter() )
			{
				_interpreter.postProcessClass( classInstance, obj );
			}

			if( classInstance is IDeserializeComplete )
			{
				classInstance.deserialized();
			}
			
			return classInstance;
		}
		
		
		private function getPropertyName( node:XML ):String
		{
			var name:String = node.name().localName;
			
			if( _propertyFieldType != PropertyFieldType.NODE_NAME )
			{
				if( _propertyFieldType == PropertyFieldType.ATTRIBUTE )
				{
					name = node.@[ _propertyField ];
					//delete node.@[ _propertyField ];
				}else if( _propertyFieldType == PropertyFieldType.CHILD_NODE )
				{
					name = node[ _propertyField ].text()[ 0 ];
					//delete node[ _propertyField ];
				}
				
				if( !name )
				{
					/*
					trace( "Warning could not determines property name for : " + node.name().localName );
					trace( "Property field : " + _propertyField );
					trace( node.toXMLString() );
					trace( node[ _propertyField ] );
					*/
					
					//fallback to the node name
					name = node.name().localName;
				}
			}
			
			if( hasNodeNameMap() )
			{
				var nodeNameMapProperty:String = _nodeNameMap.getPropertyByNodeName( node.name().localName );
				
				if( nodeNameMapProperty )
				{
					name = nodeNameMapProperty;
				}
			}
			
			//trace("Deserializer::getPropertyName()", name, name.indexOf( "-" ), name.indexOf( "-" ) > -1 );
			
			//quick fix for hyphenated property names
			//should be moved to a property converter implementation
			//associated with the class node name map
			if( name.indexOf( "-" ) > -1 )
			{
				var converter:PropertyNameConverter = new PropertyNameConverter();
				name = converter.convert( name );
			}			
			
			return name;
		}
		
		private function parseAttributes( node:XML, obj:Object ):Object
		{
			var reserved:Array = Serializer.RESERVED_ATTRIBUTES.slice();
			
			if( _propertyFieldType == PropertyFieldType.ATTRIBUTE )
			{
				if( !Object( obj ).hasOwnProperty( _propertyField ) )
				{
					reserved.push( _propertyField );
				}
			}
		
			var out:Object = {};
			
			var nodeAttributes:XMLList = node.@*;
			var attribute:XML;
			var name:String;
			
			var interpreted:Boolean;
			var shouldSetProperty:Boolean;
			
			for each( attribute in nodeAttributes )
			{
				interpreted = false;
				shouldSetProperty = false;
				
				name = attribute.name();
				
				if( ArrayUtils.contains( reserved, name ) )
				{
					continue;
				}				
				
				/*
				trace( "Parse attribute : " + node );
				trace( "Parse attribute : " + name );
				trace( "Parse attribute : " + obj );
				*/
				
				out[ name ] = deserializePrimitive( node, obj, name, null, true );
				
				if( hasInterpreter() )
				{
					interpreted = _interpreter.shouldProcessAttribute( obj, name, out[ name ] );
				}
				
				if( interpreted )
				{
					shouldSetProperty = _interpreter.processAttribute( obj, name, out[ name ] );
				}
				
				try{
					
					if( !interpreted || ( interpreted && shouldSetProperty ) )
					{
						obj[ name ] = out[ name ];
					}
				}catch( e:Error )
				{
					throw new Error(
						"Could not set attribute '" +
						name +
						"' on " + obj +
						" with value " + out[ name ] + "\n\n" + e.toString() );
				}
				
			}
			
			return out;
		}
		
		/**
		*	Determines whether a complex XML node consists solely of either
		*	a child <null /> node or a <NaN /> node.
		*
		*	@param node the parent XML node to inspect
		*	@param obj the current Object being deserialized into
		*
		*	@return true if the match of a sole <null /> or <NaN /> child node was made, false otherwise
		*/
		private function hasComplexNot( node:XML, obj:Object ):Boolean
		{
			if( node.children().length() == 1 && node.hasComplexContent() )
			{
				var valueNode:XML = XML( node.children()[ 0 ] );
				var name:String = valueNode.name().localName;
				if( name == Serializer.NAN_VALUE_NAME || name == Serializer.NULL_VALUE_NAME )
				{	
					return true;
				}
			}
			return false;
		}
		
		private function getComplexNotValue( node:XML, obj:Object ):*
		{
			if( hasComplexNot( node, obj ) )
			{
				var valueNode:XML = XML( node.children()[ 0 ] );
				var name:String = valueNode.name().localName;
				if( name == Serializer.NAN_VALUE_NAME )
				{	
					return NaN;
				}else if( name == Serializer.NULL_VALUE_NAME )
				{
					return null;
				}
			}
			
			return false;
		}
		
		private function getClassFromNodeNameMap( node:XML ):Class
		{
			var name:String = node.name().localName;
			
			var c:Class;
			
			if( hasNodeNameMap() )
			{
				c = _nodeNameMap.getClassByNodeName( name );
			}
			
			return c;
		}
		
		/**
		*	Determines the Class to be instantiated from an XML node.
		*
		*	If a 'class' attribute is present the value is used to
		*	determine the class using getDefinitionByName(), otherwise
		*	the node name is used.
		*
		*	In the scenario that both the above cases fail and a
		*	ClassNodeNameMap instance is registered with this
		*	Deserializer, an attempt to lookup the Class in the 
		*	ClassNodeNameMap is made.
		*
		*	@param node the XML to determine the Class of
		*
		*	@return the Class reference for the node
		*/
		private function getClass( node:XML ):Class
		{
			var c:Class;
			var className:String = node.attribute( Serializer.CLASS_ATTRIBUTE_NAME );
			
			if( !className )
			{
				c = getClassFromNodeNameMap( node );
				
				if( c )
				{
					return c;
				}
			}
			
			try {
				c = getDefinitionByName( className ) as Class;
				return c;
			}catch( e:Error )
			{
				//
			}
			
			return c;
		}
		
		//--> refactor to simply calling getParser() - unnecessary overhead
		protected function hasParser( node:XML ):Boolean
		{
			var instance:IParser;
			
			var parserClassPath:String = node.attribute( Serializer.PARSER_ATTRIBUTE_NAME );
			
			var classReference:Class = getClass( node );
			if( classReference && classParserMap )
			{
				instance = classParserMap.getParserByClass( classReference );
				
				if( instance )
				{
					return true;
				}
			}
			
			return ( parserClassPath && ( parserClassPath != "" ) && parserClassPath.length );
		}
		
		public function getParser( node:XML ):IParser
		{
			var instance:IParser;
			
			//if an IParser exists in the mapping use that one
			var classReference:Class = getClass( node );
			
			//trace( "getParser : " + classReference );
			//trace( "getParser : " + classParserMap );
			
			if( classReference && classParserMap )
			{
				instance = classParserMap.getParserByClass( classReference );
				
				if( instance )
				{
					return instance;
				}
			}
			
			//otherwise test for a parser attribute
			var parserClassPath:String = node.@[ Serializer.PARSER_ATTRIBUTE_NAME ];
			
			if( parserClassPath && parserClassPath.length )
			{
			
				try {
					instance = ClassUtils.getInstance( parserClassPath ) as IParser;
			
					//trace( "getParser instance : " + instance );
				
					//clean up the attribute - this is important
					//as we pass this node to the parse() method declared
					//on the IParser, if we did not clean the attribute
					//the instantiated IParser would try to instantiate
					//it's own IParser - potential stack overflow
					delete node.@[ Serializer.PARSER_ATTRIBUTE_NAME ];
				
					return instance;
				}catch( e:Error )
				{
					throw new Error( "Could not instantiate IParser for class path : " + parserClassPath );
				}
			
			}
			
			return null;
		}
		
		/**
		*	Deserializes an XML instance into an Object structure.
		*
		*	@param node the XML to deserialize
		*	@param obj an optional Object to deserialize into
		*/
		public function deserialize( node:XML, obj:Object = null, ignoreISerializeDeserialize:Boolean = false ):Object
		{
			var propFieldType:String = node.attribute( Serializer.PROPERTY_FIELD_TYPE_ATTRIBUTE_NAME );
			if( propFieldType )
			{
				//trace( "Deserialize has prop field type : " + propFieldType );
				
				this.propertyFieldType = propFieldType;
				
				var propField:String = node.attribute( Serializer.PROPERTY_FIELD_ATTRIBUTE_NAME );
				
				if( propField )
				{
					this.propertyField = propField;
				}
			}
			
			if( obj )
			{
				parseAttributes( node, obj );
			}
		
			var output:Object = parse( node, obj, ignoreISerializeDeserialize, true );
			
			if( output == null && obj )
			{
				output = obj;
			}
			
			if( hasInterpreter() )
			{
				_interpreter.complete( output );
			}
			
			if( obj && ( obj is IDeserializeComplete ) )
			{
				IDeserializeComplete( obj ).deserialized();
			}
			
			return output;
		}
		
		public function parse(
			x:XML = null,
			obj:Object = null,
			ignoreISerializeDeserialize:Boolean = false,
			rootNode:Boolean = false ):Object
		{
			if( !x )
			{
				throw new DeserializeError(
					"Cannot parse a null XML instance." );
			}
			
			var ns:String = x.@xmlns;
			
			if( ns )
			{
				default xml namespace = new Namespace( ns );
			}
			
			//deal with null/NaN values
			var complexNot:* = hasComplexNot( x, obj );
			
			if( complexNot )
			{
				return deserializePrimitive( XML( x.children()[ 0 ] ), obj, x.name().localName, getComplexNotValue( x, obj ) );
			}
		
			var name:String = x.name().localName;
			var node:XML;
			var classReference:Class;
			var contractName:String;
			
			//we're just deserializing a primitive value
			if( XmlUtils.isTextNode( x ) )
			{
				return deserializePrimitive( x, null, name );
			}
			
			//no default object specified and the class node name
			//map has an instance assigned to use as the root
			if( !obj && ( nodeNameMap.rootInstance != null ) )
			{
				obj = nodeNameMap.rootInstance;
			}
			
			if( !obj )
			{
				//create the root instance if we are not deserializing into
				//an object					
				//if( x.hasComplexContent() )
				//{
					
					try {
						classReference = getClass( x );
						obj = deserializeClass( classReference, obj, x, name );
						parseAttributes( x, obj );
					
					}catch( e:Error )
					{
						//we've encountered a serialized null potentially
						//fall through
					}
				//}
			}
			
			
			if( obj && rootNode && _interpreter )
			{
				_interpreter.documentAvailable( obj );
			}
			
			var contract:ISerializeContract = null;
			
			if( !ignoreISerializeDeserialize )
			{
				//let an object handle deserializing itself
				if( obj is ISerializeDeserialize )
				{
					contractName = x.attribute( Serializer.CONTRACT_ATTRIBUTE_NAME );
					
					if( contractName )
					{
						contract = ClassUtils.getInstance( contractName ) as ISerializeContract;
					}
					
					if( !contract )
					{
						contract = obj.getDefaultContract();
					}
					
					//trace( "Invoke deserialize on the instance : " + obj );
				
					obj.deserialize( x, obj, this, contract );
				}
			}
				
			if( !( obj is XML ) && !( obj is XMLList ) )
			{
			
				var i:int = 0;
				var l:int = x.children().length();
				
				var isEmpty:Boolean;
				
				for( ;i < l;i++ )
				{
					node = x.children()[ i ];
					name = node.name().localName;
					
					isEmpty = XmlUtils.isEmptyNode( node );
					
					if( ignoreEmptyNodes && isEmpty )
					{
						continue;
					}
					
					//nodes with no attributes or child nodes
					//should not be deserialized
					
					/*
					if( XmlUtils.isEmptyNode( node ) )
					{
						continue;
					}
					*/
					
					if( hasInterpreter() )
					{
						if( !_interpreter.shouldProcessNode( node, obj ) )
						{
							continue;
						}
						
						var interpreterProcess:Boolean = _interpreter.preProcess( node, obj, this, contract );

						//the interpreter is handling processing of this node
						if( interpreterProcess )
						{
							_interpreter.process( node, obj, this, contract );
							continue;
						}
					}
					
					//ensure array child nodes
					//use a numeric integer property name
					
					/*
					if( obj && obj is Array )
					{
						name = node.childIndex().toString();
					}
					*/
					
					//trace("Deserializer::deserialize()", "PROCESSING: ", name, isEmpty );
					
					if( XmlUtils.isTextNode( node ) )
					{
						deserializePrimitive( node, obj, name );
					//deal with complex types
					}else{
						//deal with null/NaN values
						complexNot = hasComplexNot( node, obj );
						if( complexNot )
						{
							return obj;
						}
						
						//trace("Deserializer::parse(), deserializeClass : " + name );
						
						classReference = getClass( node );
						deserializeClass( classReference, obj, node, name );
					}
				
				}
			
			}
			
			return obj;
		}	
		
	}
	
}
