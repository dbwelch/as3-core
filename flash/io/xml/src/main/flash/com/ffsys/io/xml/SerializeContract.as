package com.ffsys.io.xml {
	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.io.xml.SerializeOptions;
	import com.ffsys.io.xml.types.CDataString;
	import com.ffsys.io.xml.types.XmlAttribute;
	import com.ffsys.utils.string.ClassUtils;
	import com.ffsys.utils.string.TypeRegistry;
	
	/**
	*	Base class for XML serialization description contracts.
	*
	*	A contract describes the properties that should be serialized
	*	in a target object by declaring the property names that should
	*	be serialized as public member variables of the class.
	*
	*	If a member variable is declared as a <code>CDataString</code>
	*	type then the corresponding variable in the instance being
	*	serialized will be serialized with an enclosing CDATA node.
	*	If the type of the corresponding member in the object being
	*	serialized is anything other than <code>String</code> a runtime
	*	error will be thrown.
	*
	*	Declaring the type of a member variable in a <code>SerializeContract</code>
	*	as <code>XmlAttribute</code> will force the target property to
	*	be serialized as an attribute rather than the default 
	*	behaviour of becoming a child node in the resulting XML.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.05.2007
	*/
	public class SerializeContract extends Object
		implements ISerializeContract {
			
		private var _type:XML;
		
		public function SerializeContract()
		{
			super();
			_type = TypeRegistry.describe( this );
		}
		
		/**
		*	Returns the type information for this contract instance as XML.
		*	
		*	@return the XML returned from a call to describeType( this )
		*/
		public function getType():XML
		{
			return _type;
		}
		
		public function serialize(
			x:XML = null,
			obj:Object = null,
			serializer:Serializer = null,
			options:SerializeOptions = null ):XML
		{
			if( !options )
			{
				options = serializer.options;
			}
			
			var z:String = null;
			var cdataEnabled:*;
			var cdata:Boolean;
			
			var names:Array = getPropertyNames();
			var property:String;
			
			var i:int = 0;
			var l:int = names.length;
			
			for( ;i < l;i++ )
			{
				property = names[ i ];
				
				if( obj.hasOwnProperty( property ) )
				{
					cdata = isCdataProperty( property );

					if( cdata )
					{
						//store the original setting
						cdataEnabled = options.cdataEnabled;

						//force cdata encoding for this node
						options.cdataEnabled = true;
					}

					if( !isAttributeProperty( property ) )
					{
						x.appendChild( serializer.getXML( x, obj[ property ], property, options ) );
					}else{
						x.@[ property ] = obj[ property ].toString();
					}

					if( cdataEnabled is Boolean )
					{
						//reset the option property
						options.cdataEnabled = cdataEnabled;
					}
										
				}else{
					throw new Error( "SerializeContract could not find corresponding property for: " + property );
				}
				
			}
			
			/*
			
			for( z in obj )
			{
				trace( "Contract serialize : " + z );
				
				cdata = isCdataProperty( z );
				
				if( cdata )
				{
					//store the original setting
					cdataEnabled = options.cdataEnabled;
					
					//force cdata encoding for this node
					options.cdataEnabled = true;
				}
				
				if( !isAttributeProperty( z ) )
				{
					x.appendChild( serializer.getXML( x, obj[ z ], z, options ) );
				}else{
					x.@[ z ] = obj[ z ].toString();
				}
				
				if( cdataEnabled is Boolean )
				{
					//reset the option property
					options.cdataEnabled = cdataEnabled;
				}
			}
			*	*/
			
			return x;
		}
		
		/**
		*	Determines whether a variable declared in this contract
		*	uses the special CDataString type definition.
		*
		*	@param prop the variable name to test
		*
		*	@return a Boolean indicating whether the variable was declared as CDataString
		*/
		private function isCdataProperty( prop:String ):Boolean
		{
			return comparePropertyType( prop, new CDataString() );
		}
		
		/**
		*	Determines whether a variable declared in this contract
		*	uses the special XmlAttribute type definition.
		*
		*	@param prop the variable name to test
		*
		*	@return a Boolean indicating whether the variable was declared as XmlAttribute
		*/		
		public function isAttributeProperty( prop:String ):Boolean
		{
			return comparePropertyType( prop, new XmlAttribute() );
		}
		
		/**
		*	@private
		*/
		private function comparePropertyType( prop:String, instance:* ):Boolean
		{
			var node:XML = new XML( _type.variable.(@name == prop) );
			
			var className:String = getQualifiedClassName( instance );
			
			if( node.@type == className ) 
			{
				return true;
			}
			
			return false;
		}
		
		/**
		*	Returns an Array of Strings of the names of all public
		*	variables declared on this instance.
		*
		*	@return the Array of public variable names
		*/
		public function getPropertyNames():Array
		{
			var out:Array = [];
			
			var list:XMLList = _type.variable;
			var node:XML = null;
			
			for each( node in list ) {
				out.push( node.@name );
			}
			
			return out;
		}
		
	}
	
}
