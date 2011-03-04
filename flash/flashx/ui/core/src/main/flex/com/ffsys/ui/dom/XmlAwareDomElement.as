package com.ffsys.ui.dom
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;	
	
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
	
	//temporarily extend the display list hierarchy so that we can use 
	//a runtime parser - requires refactoring to a proxy implementation !!!!
	public class XmlAwareDomElement extends Sprite
		implements IDomElement
	{
		private var _id:String;
		private var _beanName:String;
		private var _href:String;
		private var _xml:XML;
		private var _document:IBeanDocument;
		private var _parser:Object;
		private var _class:Class;
		
		/**
		* 	@private
		*/
		protected var _descriptor:IBeanDescriptor;
	
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
		
		//TODO: remove when proxy is done
		public function hasOwnProperty( name:String ):Boolean
		{
			return true;
		}
		
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
	}
}