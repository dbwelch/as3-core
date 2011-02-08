package com.ffsys.dom
{
	import flash.display.Sprite;
	import flash.events.*;	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.*;
	import flash.utils.flash_proxy;	
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Represents a <code>DOM</code> element that is aware
	* 	of an xml definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class XmlAwareDomElement extends Proxy
		implements	IDomElement,
					IBeanNameAware
	{
		private static const ID:String = "id";
		
		/**
		* 	@private
		*/
		protected var _xml:XML;	
		
		private var _id:String;
		private var _beanName:String;
		private var _document:IBeanDocument;
		private var _parser:Object;
		private var _class:Class;
		
		//TODO: move to correct sub-classes
		private var _href:String;		
		private var _title:String;
		
		/**
		* 	@private
		*/
		protected var _descriptor:IBeanDescriptor;
		
		/**
		* 	@private
		* 
		* 	The primary proxy target.
		*/
		private var __proxy:Object;
		
		//an array of the values
		private var _mappings:Vector.<ElementMap>;
	
		/**
		* 	Creates an <code>XmlAwareDomElement</code> instance.
		* 
		* 	@param xml The <code>XML</code> that describe this element.
		*/
		public function XmlAwareDomElement( xml:XML = null )
		{
			super();
			if( xml != null )
			{
				this.xml = xml;
			}
		}
		
		/**
		* 	An event dispatcher used for event dispatching.
		*/
		public function get eventProxy():IEventDispatcher
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		public function get title():String
		{
			return _title;
		}
		
		public function set title( value:String ):void
		{
			_title = value;
		}
		*/
		
		/**
		* 	The primary source object containing enumerable properties
		* 	that are being proxied.
		*/
		public function get proxy():Object
		{
			if( __proxy == null )
			{
				__proxy = new Object();
			}
			return __proxy;
		}
		
		public function get mappings():Vector.<ElementMap>
		{
			if( _mappings == null )
			{
				_mappings = new Vector.<ElementMap>();
			}
			return _mappings;
		}		
		
		
		public function get length():uint
		{
			return _mappings != null ? _mappings.length : 0;
		}
		
		/**
		* 	@private
		*/
		protected function setProxySource( source:Object ):void
		{
			//ensure the element map vector is created
			var mappings:Vector.<ElementMap> = this.mappings;
			
			for( var z:String in source )
			{
				this[ z ] = source[ z ];
			}
			__proxy = source;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanName():String
		{
			return _beanName;
		}
		
		public function set beanName( value:String ):void
		{
			_beanName = value;
			if( value != null )
			{
				xml.setName( new QName( null, value ) );
				//trace("[SETTING XML ELEMENT NAME] XmlAwareDomElement::set beanName()", xml.toXMLString() );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get id():String
		{
			if( _id == null
			 	&& __proxy != null
				&& __proxy.hasOwnProperty( ID )
				&& __proxy.id is String )
			{
				return String( __proxy.id );
			}
			return _id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		public function get href():String
		{
			return _href;
		}
		
		public function set href( value:String ):void
		{
			_href = value;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function get xml():XML
		{
			if( _xml == null )
			{
				_xml = new XML( "<node />" );
			}
			return _xml;
		}
		
		public function set xml( value:XML ):void
		{
			_xml = value;
			
			//TODO: run this through the SAX parser to create child elements???
		}
		
		/**
		* 	The bean document that instantiated this component.
		*/
		
		//TODO: refactor to beans - ensure we all need this reference
		//as everything needs to instantiated from the ownerDocument
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get descriptor():IBeanDescriptor
		{
			return _descriptor;
		}
		
		/**
		* 	@private
		*/
		public function afterConstructed(
			descriptor:IBeanDescriptor ):void
		{
			_descriptor = descriptor;
			//trace("XmlAwareDomElement::afterConstructed()", this, descriptor, descriptor.id );
		}
		
		/**
		* 	@private
		*/
		public function afterInjection(
			descriptor:IBeanDescriptor ):void
		{	
			//trace("XmlAwareDomElement::afterInjection()", this, descriptor );
		}		
		
		/**
		* 	@private
		*/
		public function afterProperties(
			descriptor:IBeanDescriptor ):void
		{
			//trace("XmlAwareDomElement::afterProperties()", this, descriptor );
		}
		
		/**
		* 	@private
		*/
		public function afterResources(
			descriptor:IBeanDescriptor,
			queue:ILoaderQueue = null ):void
		{
			//trace("XmlAwareDomElement::afterResources()", this, descriptor, queue );
		}
		
		/**
		* 	@private
		*/
		public function finalized():void
		{
			//trace("XmlAwareDomElement::finalized()", this );
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClass( target:Object = null ):Class
		{
			if( target is Class )
			{
				return target as Class;
			}
			
			if( target == null )
			{
				target = this;
			}
			
			if( _class == null )
			{	
				var path:String = getQualifiedClassName( target );
				if( _descriptor != null )
				{
					_class = _descriptor.instanceClass;
				}else
				{
					_class = getDefinitionByName( path ) as Class;
				}
				
				//classes are dynamic so cache our path and name
				if( _class != null )
				{
					Object( _class ).path = path;

					var classPath:String = path;
					var className:String = classPath;
					var index:int = classPath.indexOf( "::" );
					if( index > -1 )
					{
						className = classPath.substr( index + 2 );
					}
					Object( _class ).name = className;
				}				
			}
			
			return _class;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClassPath( target:Object = null ):String
		{
			var clazz:Class = getClass();
			return String( clazz.path );
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClassName( target:Object = null ):String
		{
			var clazz:Class = getClass();
			return String( clazz.name );
		}
		
		/**
		* 	Performs clean up of this instance.
		* 
		* 	The implementation of this method should clean any
		* 	event listeners and null any references to complex objects.
		* 
		* 	Derived implementations <strong>must</strong> call the super
		* 	method.
		*/
		public function destroy():void
		{
			_id = null;
			_beanName = null;
			_href = null;
			_xml = null;
			_document = null;
			_descriptor = null;
			_parser = null;
			_class = null;
		}
		
		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			return ( this.proxy.hasOwnProperty( name ) );
	    }

		/**
		*	@private	
		*/
	    override flash_proxy function getProperty( name:* ):*
		{
			if( name == null || name == "null" )
			{
				return null;
			}
			
			if( Object( eventProxy ) != null
				&& Object( eventProxy ).hasOwnProperty( name )
				&& Object( eventProxy )[ name ] is Function )
			{
				return Object( eventProxy )[ name ];
			}

			return propertyMissing( name );
	    }

		/**
		*	@private	
		*/
	    override flash_proxy function setProperty( name:*, value:* ):void
		{
			if( name == null || name == "null" )
			{
				return;
			}
			
			//trace("[SET PROP] XmlAwareDomElement::setProperty() this/name/value: ", this, name, value );
			
			var hasProp:Boolean = ( this.proxy[ name ] != null );
			
			//mutate the property to a list for most nodes
			if( value is Node
				&& !( value is Head ) && !( value is Body ) )
			{
				var node:Node = Node( value );
				if( !hasProp )
				{
					value = new NodeList();
					value.children.push( node );
				}else{
					value = NodeList( this.proxy[ name ] );
					value.children.push( node );
					
					//trace("[ADDING TO EXISTING TAG LIST] XmlAwareDomElement::setProperty() this/node: ", this, node );
				}
			}

			//add all mappings to the array of mappings
			if( !hasProp )
			{
				value = doWithNewProperty( name, value );
				mappings.push(
					new ElementMap( name, value, mappings.length ) );
			}else{
				//update the stored map value
				var map:ElementMap = null;
				for each( map in mappings )
				{
					if( map.name == name )
					{
						map.value = value;
					}
				}
			}

			this.proxy[ name ] = value;

			//trace("[XmlAwareDomElement SET PROPERTY]", this, hasProp, name, value );
	    }
		
		/**
		* 	Allows derived implementations to process
		* 	properties as they are created for the first time.
		* 
		* 	@param name The property name.
		* 	@param value The property value.
		* 
		* 	@return Either the value intact or an alternative value.
		*/
		protected function doWithNewProperty( name:*, value:* ):*
		{
			return value;
		}
		
		/**
		* 	Invoked when a method invocation could not be proxied.
		* 
		* 	@param methodName The method name.
		* 	@param parameters The parameters passed to the method invocation.
		* 
		* 	@return A result of doing something with the missing method
		* 	invocation.
		*/
		protected function methodMissing( methodName:*, parameters:Array ):*
		{
			trace("XmlAwareDomElement::methodMissing()", methodName, parameters );
		}
		
		protected function propertyMissing( name:* ):*
		{
			return this.proxy[ name ];
		}

		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...parameters ):*
		{
			
			//trace("XmlAwareDomElement::callProperty()", this, methodName, parameters, __proxy );
			
			//handle event proxying
			if( Object( eventProxy ) != null
				&& Object( eventProxy ).hasOwnProperty( methodName )
				&& Object( eventProxy )[ methodName ] is Function )
			{
				return Object( eventProxy )[ methodName ].apply( Object( eventProxy ), parameters );
			}
			
			//invoke on the source object if possible
			if( __proxy != null
				&& __proxy.hasOwnProperty( methodName )
				&& __proxy[ methodName ] is Function )
			{
				return __proxy[ methodName ].apply( __proxy, parameters );
			}
			
			//otherwise allow derived implementations to handle the method call
			return methodMissing( methodName, parameters );
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			return getNextNameIndex( index );
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			return getNextName( index );
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
		{
			return getNextValue( index );
		}
		
		/**
		* 	Allows derived implementations to modify the
		* 	iteration of this object.
		*/
		protected function getNextNameIndex( index:int ):int
		{
			if( index < length )
			{
				return index + 1;
			}
			return 0;			
		}
		
		/**
		* 	Allows derived implementations to modify the
		* 	iteration of this object.
		*/
		protected function getNextName( index:int ):String
		{
			if( index <= mappings.length )
			{
				var map:ElementMap = ElementMap( mappings[ index - 1 ] );
				return map.name;
			}
			return null;			
		}
		
		/**
		* 	Allows derived implementations to modify the
		* 	iteration of this object.
		*/
		protected function getNextValue( index:int ):*
		{
			return ElementMap( mappings[ index - 1 ] ).value;
		}

		/**
		* 	@private
		*/
		override flash_proxy function deleteProperty( name:* ):Boolean
		{
			var map:ElementMap = null;
			for each( map in mappings )
			{
				if( map.name == name )
				{
					mappings.splice( map.index, 1 );
					break;
				}
			}
			return delete this.proxy[ name ];
		}

		/**
		* 	Gets a string representation of this instance.
		* 
		* 	@return A string representing this instance.
		*/
		public function toString():String
		{
			var nm:String = "[object ";
			nm += getClassName();
			
			//trace("XmlAwareDomElement::toString()", this.id );
			
			if( this.id != null )
			{
				nm += "#" + this.id;
			}
			nm += "]";
			return nm;
		}
	}
}

class ElementMap {
	public var name:String;
	public var value:*;
	public var index:int;
	
	public function ElementMap( name:String, value:*, index:int )
	{
		this.name = name;
		this.value = value;
		this.index = index;				
	}
}