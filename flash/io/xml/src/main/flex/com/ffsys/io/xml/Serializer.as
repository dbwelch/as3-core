package com.ffsys.io.xml {
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.string.TypeRegistry;
	import com.ffsys.utils.xml.XmlUtils;
	
	/**
	*	Main class used for serializing objects to an XML representation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.05.2007
	*/
	public class Serializer extends Object
		implements ISerializeDeserializeProperty {
	
		/**
		*	The default node name.
		*/
		static public const DEFAULT_NODE_NAME:String = "node";
		
		/**
		*	Determines the String used as the class attribute name when serializing
		*	a class.
		*/		
		static public const CLASS_ATTRIBUTE_NAME:String = "class";
		
		static public const PARSER_ATTRIBUTE_NAME:String = "parser";
		
		/**
		*	The default node name for child nodes when serializing an array.
		*/
		static public const ARRAY_CHILD_NAME:String = "item";
		
		/**
		*	The String used to determine whether a value is null.
		*/
		static public const NULL_VALUE_NAME:String = "null";
		
		/**
		*	The String used to determine whether a value is NaN.
		*/
		static public const NAN_VALUE_NAME:String = "NaN";
		
		/**
		*	The default propertyField for serializing property names.
		*/
		static public const DEFAULT_PROPERTY_FIELD:String = "id";
		
		/**
		*	The default type to use for the property field.
		*/
		static public const DEFAULT_PROPERTY_FIELD_TYPE:String = PropertyFieldType.NODE_NAME;
		
		/**
		*	The attribute name to use when serializing to a non standard property field.
		*/
		static public const PROPERTY_FIELD_ATTRIBUTE_NAME:String = "propertyField";
		
		/**
		*	The attribute name to use when serializing to a non standard property field type.
		*/
		static public const PROPERTY_FIELD_TYPE_ATTRIBUTE_NAME:String = "propertyFieldType";		
		
		/**
		*	Determines the String used as the contract attribute name when
		*	serializing to XML.
		*/
		static public const CONTRACT_ATTRIBUTE_NAME:String = "contract";
		
		static public const RESERVED_ATTRIBUTES:Array = [
			CLASS_ATTRIBUTE_NAME,
			CONTRACT_ATTRIBUTE_NAME,
			PROPERTY_FIELD_ATTRIBUTE_NAME,
			PROPERTY_FIELD_TYPE_ATTRIBUTE_NAME
		];
		
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
		
		private var _options:SerializeOptions;
		
		private var _contractRegistry:ContractRegistry;
		
		public function Serializer( options:SerializeOptions = null )
		{
			super();
			
			if( !options )
			{
				_options = new SerializeOptions();
			}else{
				_options = options;
			}
			
			_contractRegistry = new ContractRegistry();
			
			_propertyField = DEFAULT_PROPERTY_FIELD;
			_propertyFieldType = DEFAULT_PROPERTY_FIELD_TYPE;	
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
				throw new Error( "Cannot set invalid property field type '" + val + "'." );
			}
		
			_propertyFieldType = val;
		}
		
		public function get propertyFieldType():String
		{
			return _propertyFieldType;
		}		
		
		public function set options( val:SerializeOptions ):void
		{
			_options = val;
		}
		
		public function get options():SerializeOptions
		{
			return _options;
		}
		
		public function set contractRegistry( val:ContractRegistry ):void
		{
			_contractRegistry = val;
		}
		
		public function get contractRegistry():ContractRegistry
		{
			return _contractRegistry;
		}
		
		//--> refactor name
		public function getXML( obj:* = null, val:* = null, nodeName:String = null, nodeOptions:SerializeOptions = null ):XML
		{
			var x:XML = new XML();
			
			if( ClassUtils.isNull( val ) )
			{
				x = XmlUtils.getSimpleXmlNode( nodeName );
				x.appendChild( XmlUtils.getSimpleXmlNode( NULL_VALUE_NAME ) );
			}else if( val is Number && isNaN( val ) )
			{
				x = XmlUtils.getSimpleXmlNode( nodeName );
				x.appendChild( XmlUtils.getSimpleXmlNode( NAN_VALUE_NAME ) );	
			}else{
			
				if( !nodeOptions )
				{
					nodeOptions = _options;
				}
				
				/*
				if( val is OscString )
				{
					val = val.value as String;
				}
				*/
				
				var name:String = getQualifiedClassName( val.constructor );
				
				var nm:String = DEFAULT_NODE_NAME;
				
				if( nodeName )
				{
					nm = nodeName;
				}
				
				if( obj is IStringIdentifier )
				{
					nm = obj.id;
				}
				
				if( nodeOptions.classNameMode )
				{
					nm = ClassUtils.getClassName( obj );
				}
				
				if( obj is INodeName )
				{
					nm = obj.getNodeName();
				}
				
				x = XmlUtils.getSimpleXmlNode( nm );
				
				if( nodeOptions.classAttribute )
				{
					if( !nodeOptions.ignorePrimitiveClassAttribute || ( nodeOptions.ignorePrimitiveClassAttribute && ( !ClassUtils.isSimplePrimitive( val ) ) ) )
					{
						//if( !( val is Packet ) && !( val is Message ) )
						//{
							x.@[ CLASS_ATTRIBUTE_NAME ] = name;
						//}
					}
				}
				
				if( !val && !( val is Boolean ) )
				{
					x.appendChild( val );
					return x;
				}
				
				var contract:ISerializeContract;
				var c:Class = ClassUtils.getClass( obj );
				contract = _contractRegistry.get( c )
				
				var serialized:XML;		
				
				if( obj is ISerializeDeserialize )
				{
					
					if( !contract )
					{
						contract = obj.getDefaultContract();
					}
					
					x.@[ CONTRACT_ATTRIBUTE_NAME ] = getQualifiedClassName( contract );
					
					serialized = obj.serialize( x, this, contract );
					
					setPropertyField( serialized, serialized.name().localName );
					
					return serialized;
				}else if( contract )
				{
					//let the contract handle the serialization
					serialized = contract.serialize( x, obj, this );
					return serialized;
				}
				
				var prop:*;
				
				if( val is String )
				{
					x = XmlUtils.getSimpleXmlNode( nm, val, nodeOptions.cdataEnabled );
				}else{
				
					if( nodeOptions.cdataEnabled )
					{
						throw new Error( "Cannot add CDATA node for non String type." );
					}
					
					if( val is Number )
					{
						x.appendChild( val );
					}else if( val is Boolean )
					{
						x.appendChild( val.toString() );
					}else if( val is XML )
					{
						//--> lookup XML class String name with reflection
						x.appendChild( val.toXMLString() );
						
					}else if( val is Array )
					{
						var cname:String = ARRAY_CHILD_NAME;
						if( val is IChildNodeName )
						{
							cname = val.getChildNodeName();
						}
					
						var i:int = 0;
						var l:int = val.length;
						for( ;i < l;i++ )
						{
							prop = val[ i ];
							x.appendChild( getXML( prop, prop, cname ) );
						}
					}else if( ClassUtils.isPlainObject( val ) )
					{
					
						var z:String = null;
						for( z in val )
						{
							prop = val[ z ];
							x.appendChild( getXML( prop, prop, z ) );
						}
					}else if( val is Object || val is Date )
					{
						serializeClass( x, val, nodeOptions );
					}
				
				}
			
			}
			
			setPropertyField( x, x.name().localName );
			
			return x;
		}
		
		public function setPropertyField( node:XML, name:String ):void
		{
			//only add custom propertyField
			//attribute/child node values if the object
			//is complex - not primitive
			if( !XmlUtils.isTextNode( node ) )
			{
				
				if( _propertyFieldType != PropertyFieldType.NODE_NAME )
				{
					if( _propertyFieldType == PropertyFieldType.ATTRIBUTE )
					{
						node.@[ _propertyField ] = name;
					}else if( _propertyFieldType == PropertyFieldType.CHILD_NODE )
					{
						node.appendChild( XmlUtils.getSimpleXmlNode( _propertyField, name ) );
					}
				}
			}
		}
		
		public function serializeClass( x:XML = null, val:* = null, nodeOptions:SerializeOptions = null ):XML
		{
			if( !nodeOptions )
			{
				nodeOptions = _options;
			}
			
			if( !x )
			{
				x = XmlUtils.getSimpleXmlNode( ClassUtils.getClassName( val ) );
			}
			
			/*
			trace( "serializeClass : " + val );
			trace( "serializeClass : " + ClassUtils.getClassName( val ) );
			trace( "serializeClass : " + x.toXMLString() );
			*/
			
			if( val is Date )
			{
				x.appendChild( val.toString() );
			}else{
			
				var list:XMLList = ClassUtils.getPublicVariables( val ).children();

				var node:XML = null;
				
				var propName:String = null;
				var propVal:*;			
				
				for each( node in list )
				{
					propName = node.@name;
					propVal = val[ propName ];
					
					if( propVal || propVal is Boolean )
					{
						var child:XML = getXML( propVal, propVal, propName );
						x.appendChild( child );
					}
				}
			
			}

			return x;
		}
		
		public function serialize( instance:Object = null, nodeOptions:SerializeOptions = null ):XML
		{
			var x:XML = new XML();
			
			if( !nodeOptions )
			{
				nodeOptions = _options;
			}
			
			if( !instance && !( instance is Boolean ) )
			{
				return XmlUtils.getSimpleXmlNode( NULL_VALUE_NAME );
			}
			
			//if( instance is Packet )
			///{
				//x = serializePacket( instance as Packet, nodeOptions );
			//}else if( instance is AbstractTypeBase )
			//{
				//x = ( instance as AbstractTypeBase ).serialize( this );
			//}else if( ClassUtils.isPrimitive( instance ) )
			
			if( ClassUtils.isPrimitive( instance ) )
			{
				x = getXML( instance, instance, ClassUtils.getClassName( instance ), nodeOptions );
				
			}else if(
				ClassUtils.isCustomClass( instance )
				|| ClassUtils.isPlainObject( instance )
				|| ClassUtils.isPlainArray( instance )
			)
			{
				x = getXML(
					instance,
					instance,
					ClassUtils.getXmlNodeClassName( instance ),
					nodeOptions
				);
			}
			
			//add any custom propertyField / propertyFieldType
			//settings as attributes of the root node if necessary
			if( _propertyField != DEFAULT_PROPERTY_FIELD )
			{
				x.@[ PROPERTY_FIELD_ATTRIBUTE_NAME ] = _propertyField;
			}			
			
			if( _propertyFieldType != DEFAULT_PROPERTY_FIELD_TYPE )
			{
				x.@[ PROPERTY_FIELD_TYPE_ATTRIBUTE_NAME ] = _propertyFieldType;
			}
			
			return x;
		}	
		
		/*
		private function serializePacket(
			packet:Packet = null,
			nodeOptions:SerializeOptions = null ):XML
		{
			var x:XML = getXML( packet, packet );
			
			if( packet.isMessage() )
			{
				var msg:Message = packet.getContents() as Message;
				x.appendChild( serializeMessage( msg, nodeOptions ) );
			}else{
				//--> handle bundle
			}
			
			return x;
		}
		
		private function serializeMessage(
			message:Message = null,
			nodeOptions:SerializeOptions = null ):XML
		{
			
			var x:XML = getXML( message, message );
			
			if( !nodeOptions.simpleMode )
			{
				x.appendChild( getXML( message.address, message.address ) );
				x.appendChild( getXML( message.getDataPacket().getOscType(), message.getDataPacket().getOscType() ) );
				x.appendChild( message.getDataPacket().serialize( this ) );
			}else{
				x = new XML( message.getDataPacket().serialize( this ).children() );
				return x;
			}
			
			return x;
		}
		*/
		
	}
	
}
