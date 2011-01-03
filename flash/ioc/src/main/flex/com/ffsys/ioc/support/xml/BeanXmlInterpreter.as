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
	* 	matching the xml node name 
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
			var name:String = node.name().localName;
			var descriptor:IBeanDescriptor = document.getBeanDescriptor( name, true );
			
			//trace("BeanXmlInterpreter::processClass()", name, bean );
			
			//TODO: different error message
			if( descriptor == null )
			{
				throw new BeanError(
					BeanError.XML_BEAN_NOT_FOUND, name );
			}
			
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