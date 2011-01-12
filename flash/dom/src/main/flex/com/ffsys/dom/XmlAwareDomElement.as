package com.ffsys.dom
{
	import flash.display.Sprite;
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
		implements IDomElement
	{
		private static const ID:String = "id";
		
		private var _id:String;
		private var _beanName:String;
		private var _href:String;
		private var _xml:XML;
		private var _document:IBeanDocument;
		private var _parser:Object;
		private var _class:Class;
		private var _title:String;
		private var _classNames:String;
		
		/**
		* 	@private
		*/
		protected var _descriptor:IBeanDescriptor;
		
		private var _source:Object;
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
		* 	@inheritDoc
		*/
		public function get title():String
		{
			return _title;
		}
		
		public function set title( value:String ):void
		{
			_title = value;
		}
		
		public function get classNames():String
		{
			return _classNames;
		}
		
		public function set classNames( value:String ):void
		{
			_classNames = value;
		}
		
		/**
		* 	The source object containing enumerable style properties.
		*/
		public function get source():Object
		{
			if( _source == null )
			{
				_source = new Object();
			}
			return _source;
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
		protected function setSource( source:Object ):void
		{
			//ensure the element map vector is created
			var mappings:Vector.<ElementMap> = this.mappings;
			
			for( var z:String in source )
			{
				this[ z ] = source[ z ];
			}
			_source = source;
		}
		
		/*
		//TODO: remove when proxy is done
		public function hasOwnProperty( name:String ):Boolean
		{
			return true;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		//TODO: receive from a IBeanNameAware implementation
		public function get beanName():String
		{
			return _beanName;
		}
		
		public function set beanName( value:String ):void
		{
			_beanName = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get id():String
		{
			if( _id == null
			 	&& _source != null
				&& _source.hasOwnProperty( ID )
				&& _source.id is String )
			{
				return String( _source.id );
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
		public function get href():String
		{
			return _href;
		}
		
		public function set href( value:String ):void
		{
			_href = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xml():XML
		{
			return _xml;
		}
		
		public function set xml( value:XML ):void
		{
			_xml = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parser():Object
		{
			return _parser;
		}
		
		public function set parser( value:Object ):void
		{
			_parser = value;
		}		
		
		/**
		* 	The bean document that instantiated this component.
		*/
		
		//TODO: refactor to beans
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
			
			if( _descriptor != null )
			{
				return _descriptor.instanceClass;
			}
			
			if( target == null )
			{
				target = this;
			}
			
			if( _class == null )
			{
				_class = getDefinitionByName(
					getClassPath( target ) ) as Class;
			}
			return _class;			
			
			//return super.getClass( target );
		}
		
		
		/**
		*	@inheritDoc 
		*/
		public function getClassPath( target:Object = null ):String
		{
			if( target == null )
			{
				target = this;
			}
			return getQualifiedClassName( target );
		}
		
		/**
		*	@inheritDoc 
		*/
		public function getClassName( target:Object = null ):String
		{
			var classPath:String = getClassPath( target );
			var className:String = classPath;
			var index:int = classPath.indexOf( "::" );
			if( index > -1 )
			{
				className = classPath.substr( index + 2 );
			}
			return className;
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
			return ( this.source.hasOwnProperty( name ) );
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

			/*
			trace("CssElement::getProperty()", this, name, this.source[ name ] );

			for( var z:String in source )
			{
				trace("[ CSS ] CssElement::getProperty() got stored property name: ", z, source[ z ] );
			}
			*/
			
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

			var hasProp:Boolean = ( this.source[ name ] != null );

			//add all mappings to the array of mappings
			if( !hasProp )
			{
				value = doWithNewProperty( name, value );
				mappings.push(
					new ElementMap( name, value, mappings.length ) );
			}else{
				//update the stored value
				var map:ElementMap = null;
				for each( map in mappings )
				{
					if( map.name == name )
					{
						map.value = value;
					}
				}
			}

			this.source[ name ] = value;

			//trace("[CSS] CssElement::setProperty()", name, this.source[ name ] );
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
			return this.source[ name ];
		}

		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...parameters ):*
		{
			
			//trace("XmlAwareDomElement::callProperty()", this, methodName, parameters, _source );
			
			if( _source != null
				&& _source[ methodName ] is Function )
			{
				return _source[ methodName ].apply( _source, parameters );
			}
			
			return methodMissing( methodMissing, parameters );
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			//trace("CssElement::nextNameIndex()", index );
			if( index < mappings.length )
			{
				return index + 1;
			}

			return 0;
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			if( index <= mappings.length )
			{
				var map:ElementMap = ElementMap( mappings[ index - 1 ] );
				return map.name;
			}
			return null;
		}

		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
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
			return delete this.source[ name ];
		}

		/**
		* 	Gets a string representation of this instance.
		* 
		* 	@return A string representing this instance.
		*/
		public function toString():String
		{
			var nm:String = "[object ";
			nm += getQualifiedClassName( this );
			
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