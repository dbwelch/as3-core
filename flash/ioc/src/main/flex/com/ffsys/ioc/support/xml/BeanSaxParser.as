package com.ffsys.ioc.support.xml
{
	import com.ffsys.ioc.*;
	import com.ffsys.net.sax.*;
	
	public class BeanSaxParser extends SaxObjectParser
	{
		/**
		* 	@private
		*/
		protected var _document:IBeanDocument;
		
		private var _descriptor:IBeanDescriptor = null;
		private var _wildcard:Boolean = true;
		
		/**
		* 	Creates a <code>BeanSaxParser</code> instance.
		*/
		public function BeanSaxParser()
		{
			super();
		}
		
		/**
		* 	The bean document used to instantiate objects for
		* 	<code>XML</code> elements.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}		
		
		/**
		* 	Determines whether anonymous objects
		* 	are created when a bean definition could
		* 	not be located.
		*/
		public function get wildcard():Boolean
		{
			return _wildcard;
		}
		
		public function set wildcard( value:Boolean ):void
		{
			_wildcard = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			if( document == null )
			{
				throw new Error( "Cannot parse a bean document using a SAX parser with no assigned bean document." );
			}
			super.beginDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginElement( token:SaxToken ):void
		{
			//clean up the descriptor
			_descriptor = null;
			//attempt to retrieve a bean descriptor for the node
			_descriptor = getXmlBeanDescriptor( token.xml );
			super.beginElement( token );
		}
		
		/**
		* 	Determines whether an instance is created
		* 	for an element.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Whether an instance should be created for the element.
		*/
		override protected function shouldCreateInstance( token:SaxToken ):Boolean
		{
			return _descriptor != null || wildcard;
		}
		
		/**
		* 	Instatiates an object for an element.
		* 
		* 	When a valid instance is created then the current
		* 	reference is updated to point to the instance.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Either a valid object or null.
		*/
		override protected function getElementInstance( token:SaxToken ):Object
		{
			return getBeanFromDescriptor( _descriptor, token.xml );
		}
		
		protected function getXmlBeanDescriptor( node:XML ):IBeanDescriptor
		{
			
			//whether we search bean document xrefs
			//when no namespace is specified bean document xrefs
			//are resolved otherwise when a namespace is specified
			//it indicates a specific bean document therefore no xref
			//resolution is performed
			var searchXrefs:Boolean = true;
			
			var name:String = node.name().localName;
			var target:IBeanDocument = this.document;
			
			var ns:Namespace = node.namespace();
			if( ns
				&& ns.uri.length > 0
				&& ns.prefix.length > 0 )
			{	
				var documents:Vector.<IBeanDocument> = target.xrefs.slice();
				documents.push( target );
				var doc:IBeanDocument = null;
				for( var i:int = 0;i < documents.length;i++ )
				{
					doc = documents[ i ];
					if( doc.id == ns.prefix )
					{
						target = doc;
						searchXrefs = false;
						break;
					}
				}
				
				if( target == this.document )
				{
					throw new Error( "No bean document found matching xml namespace prefix '"
				 		+ ns.prefix + "'." );
				}
			}
			
			var descriptor:IBeanDescriptor = target.getBeanDescriptor(
				name, searchXrefs );
				
			return descriptor;			
		}
		
		protected function getBeanFromDescriptor(
			descriptor:IBeanDescriptor, node:XML ):Object
		{
			if( descriptor == null
			 	&& wildcard )
			{
				return new Object();
			}
			
			var name:String = node.name().localName;
						
			if( descriptor == null )
			{
				throw new BeanError(
					BeanError.XML_BEAN_NOT_FOUND, name );
			}
			
			//don't finalize the bean now as we have additional
			//properties to set from the xml declaration
			var bean:Object = descriptor.getBean(
				true, false );
			
			return bean;			
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function cleanup():void
		{
			super.cleanup();
			_descriptor = null;
		}					
	}
}