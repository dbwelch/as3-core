package com.ffsys.ioc.support.xml
{
	import com.ffsys.io.xml.DeserializeInterpreter;

	import com.ffsys.ioc.BeanError;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;	
	import com.ffsys.ioc.IBeanFinalized;
	
	/**
	*	An interpreter implementation that instantiates a bean
	* 	for each xml node based on the node name.
	* 
	* 	It will search the associated bean document for a bean
	* 	matching the xml node name.
	* 
	* 	This implementation also supports locating a bean from
	* 	a specific bean document using a namespace prefix.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.12.2010
	*/
	public class BeanXmlInterpreter extends DeserializeInterpreter
	{
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>BeanXmlInterpreter</code> instance.
		*/
		public function BeanXmlInterpreter( document:IBeanDocument = null )
		{
			super();
			this.document = document;
			this.useStringReplacement = false;
		}
		
		/**
		* 	The bean document containing bean definitions used
		* 	when instantiating an object for xml nodes.
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
		*	Enable custom handling for class instantiation.
		* 
		* 	@param node The xml node being parsed.
		* 	@param parent The object instantiated for the parent node.
		* 	@param classReference The class type for the node being instantiated.
		* 
		* 	@return A booleam determining whether this interpreter is responsible
		* 	for instantiating an instance for the node.
		*/
		override public function shouldProcessClass(
			node:XML,
			parent:Object,
			classReference:Class ):Boolean
		{
			//trace("BeanXmlInterpreter::shouldProcessClass()", this.document );
			
			//we must have a valid document to process the class
			return ( this.document != null );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldProcessAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			return true;
		}
		
		/**
		*	@inheritDoc
		*/	
		override public function processAttribute( parent:Object, name:String, value:Object ):Boolean
		{
			return false;
		}
		
		public var quiet:Boolean = true;
		
		/**
		*	Processes an xml node that should correspond to a complex object.
		* 
		* 	This implementation attempts to retrieve an instance from a bean
		* 	declared in the bean document associated with this interpreter.
		* 
		* 	@param node The xml node being parsed.
		* 	@param parent The object instantiated for the parent node.
		* 	@param classReference The class type for the node being instantiated.
		* 	
		* 	@return An object for the xml node.
		*/
		override public function processClass(
			node:XML,
			parent:Object,
			classReference:Class ):Object
		{
			if( this.document == null )
			{
				throw new Error( "Cannot process an xml bean with no bean document." );
			}
			
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
				
			if( descriptor == null
			 	&& quiet )
			{
				return new Object();
			}
			
			trace("BeanXmlInterpreter::processClass()", descriptor.id );
			
			//TODO: different error message
			if( descriptor == null )
			{
				throw new BeanError(
					BeanError.XML_BEAN_NOT_FOUND, name );
			}
			
			//don't finalize the bean now as we have additional
			//properties to set from the xml declaration
			var bean:Object = descriptor.getBean(
				true, false );	
			if( bean == null )
			{
				throw new BeanError(
					BeanError.XML_BEAN_NOT_FOUND, name );
			}
			return bean;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function postProcessClass( instance:Object, parent:Object ):void
		{
			//trace("BeanXmlInterpreter::postProcessClass()", instance, ( instance is IBeanFinalized ) );
			finalizeXmlBean( instance );
		}
		
		protected function finalizeXmlBean( instance:Object ):void
		{
			if( instance is IBeanFinalized )
			{
				IBeanFinalized( instance ).finalized();
			}
		}
		
		/**
		*	Overrides the default behaviour to defer further parsing
		* 	of the object back to the parser.
		* 
		* 	@param node The xml node being parsed.
		* 	@param parent The object instantiated for the parent node.
		* 	@param classReference The class type for the node being instantiated.
		* 	@param classInstance The instance that was instantiated for this node.
		* 
		* 	@return A boolean indicating whether the parser should continue parsing 
		* 	the children of the node. This implementation always returns <code>true</code>
		* 	to defer further parsing back to the parser.
		*/
		override public function shouldParseClassInstanceChildren(
			node:XML,
			parent:Object,
			classReference:Class,
			classInstance:Object ):Boolean
		{
			return true;
		}
	}
}