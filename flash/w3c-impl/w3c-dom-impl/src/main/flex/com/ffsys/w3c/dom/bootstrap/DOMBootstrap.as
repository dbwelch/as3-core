package com.ffsys.w3c.dom.bootstrap
{
	import flash.utils.Dictionary;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.w3c.dom.*;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	import com.ffsys.w3c.dom.events.EventImpl;
	import com.ffsys.w3c.dom.events.FocusEventImpl;
	import com.ffsys.w3c.dom.events.MutationEventImpl;
	import com.ffsys.w3c.dom.events.UIEventImpl;
	
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	import org.w3c.dom.DOMImplementation;
	import org.w3c.dom.DOMImplementationList;
	import org.w3c.dom.DOMImplementationSource;

	/**
	*	A bean document used to implementations
	* 	that are used during the bootstrap process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	* 
	* 	@todo Ensure that shared bean descriptors are the same instance.
	*/
	public class DOMBootstrap extends BeanDocument
		implements DOMImplementationSource
	{
		/**
		* 	The name for a <code>DOM</code> bootstrap bean document.
		*/
		public static const NAME:String = "dom-bootstrap";
		
		/**
 		* 	The name for a bean document used to store
 		* 	various DOM implementations.
 		* 
 		* 	This bean document is always added to the xrefs
 		* 	of this document and is used to store any more
 		* 	lightweight DOM implementations
		*/
		public static const IMPLEMENTATION_FACTORIES:String = "dom-implementations";
		
		/**
		* 	@private
		* 
		* 	A dictionary of cached DOM implementation factories
		* 	the key is the concrete class of the implementation
		* 	while the value is the DOMImplementation singleton instance.
		*/
		static private var _factories:Dictionary = new Dictionary( true );
			
		/**
		* 	Creates a <code>DOMBootstrap</code> instance.
		* 
		* 	@param identifier A specific id to use for this document.
		*/
		public function DOMBootstrap( identifier:String = null )
		{
			super( identifier );
			doWithBeans( this );
			createImplementationFactoryDocument();
		}
		
		/**
		* 	@private
		*/
		private function createImplementationFactoryDocument():void
		{
			var factories:IBeanDocument = new BeanDocument(
				IMPLEMENTATION_FACTORIES );
			doWithImplementationFactories( factories );
			preinstantiateImplementationFactoryBeans( factories );
			this.xrefs.push( factories );
		}
		
		/**
		* 	@private
		* 
		* 	Allows derived implementations to add more lightweight
		* 	factories as accessible via a bean document xref.
		* 
		* 	@param factories The DOM implementation factories document.
		*/
		protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			//
		}
		
		/**
		* 	@private
		* 
		* 	After the implementation factory beans hav been
		* 	prepared this method is invoked to preinstantiate
		* 	all singleton beans in the implementation factory
		* 	document and update the reference used to instantiate
		* 	any beans from (ie, the creation document) to this
		* 	document.
		* 
		* 	Configuring in this manner prevents a duplication
		* 	of bean descriptors across multiple documents.
		* 
		* 	@param factories The DOM implementation factories document.
		*/
		protected function preinstantiateImplementationFactoryBeans(
			factories:IBeanDocument ):void
		{
			var names:Array = factories.beanNames;
			
			trace("[PREPARE] DOMBootstrap::createImplementationFactoryDocument()", names );
			
			var nm:String = null;
			var d:IBeanDescriptor = null;
			var bean:Object = null;
			for( var i:int = 0;i < names.length;i++ )
			{
				nm = names[ i ];
				d = factories.getBeanDescriptor( nm );
				if( d.singleton )
				{
					//instantiate and cache the singleton
					bean = factories.getBean( nm );
					if( bean is IBeanDocumentAware )
					{
						//ensure the factory instantiates in the scope
						//of this document
						IBeanDocumentAware( bean ).document = this;
					}
					if( bean is DOMImplementation )
					{
						_factories[ d.instanceClass ] = DOMImplementation( bean );
					}
				}
			}
		}
		
		/**
		* 	Initializes the beans on the specified document.
		* 
		* 	@param beans The document to initialize with the
		* 	bean definitions.
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			addImplementationRegistry( beans );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation(
			features:String ):DOMImplementation
		{
			if( features == null )
			{
				return null;
			}
			
			trace("[GET DOM IMPL] DOMBootstrap::getDOMImplementation()", features );
			
			var list:DOMImplementationList = getDOMImplementationList( features );
			
			if( list != null && list.length > 0 )
			{
				trace("[GOT DOM IMPLEMENTATION] DOMBootstrap::getDOMImplementation()", list.length, list[ 0 ] );
				return list[ 0 ];
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList(
			features:String ):DOMImplementationList
		{
			var list:DOMImplementationListImpl = DOMImplementationListImpl(
				getBean(
					DOMImplementationListImpl.NAME ) );
			
			var impls:Vector.<DOMImplementation> = getFactoryImplementations();
			
			//TODO: add this instance if it implements DOMImplementation
			
			var i:int = 0;
			var ft:DOMFeature = null;
			var impl:DOMImplementation = null;
			var specified:Vector.<DOMFeature> = getSpecifiedFeatures( features );
			for( var j:uint = 0;j < impls.length;j++ )
			{
				impl = impls[ j ];
				for( i = 0;i < specified.length;i++ )
				{
					ft = specified[ i ];
					
					/*
					trace("[FEATURE] DOMBootstrap::getDOMImplementationList()",
						ft, impl, impl.hasFeature( ft.feature, ft.version ) );
					*/
										
					if( !impl.hasFeature( ft.feature, ft.version ) )
					{
						break;
					}
				}
				
				if( i == specified.length )
				{
					list.implementations.push( impl );
				}
			}
			
			return list;
		}
		
		/**
		* 	@private
		* 
		* 	Converts the mapping of factories to a list
		* 	of implementations.
		* 
		* 	@return A list of pre-instantiated DOM implementation
		* 	singleton factories.
		*/
		protected function getFactoryImplementations():Vector.<DOMImplementation>
		{
			var list:Vector.<DOMImplementation> =
				new Vector.<DOMImplementation>();
			var o:Object = null;
			for each( o in _factories )
			{
				if( o is DOMImplementation )
				{
					list.push( DOMImplementation( o ) );
				}
			}
			return list;
		}
		
		/**
		* 	@private
		* 
		* 	Converts a candidate string into a list
		* 	of candidate features to test for support.
		* 
		* 	@param features The raw feature string.
		* 
		* 	@return A list of candidate feature implementations.
		*/
		protected function getSpecifiedFeatures( features:String ):Vector.<DOMFeature>
		{
			var nm:String =  null;
			var parts:Array = features.split(
				DOMFeature.DELIMITER );			
			
			//represent the string as a list of features
			var specified:Vector.<DOMFeature> = new Vector.<DOMFeature>();
			var ft:DOMFeature = null;
			for( var i:uint = 0;i < parts.length;i++ )
			{
				nm = parts[ i ];
				//got alpha-numeric character
				if( DOMFeature.MODULE_EXPRESSION.test( nm ) )
				{
					ft = new DOMFeature( nm );
					specified.push( ft );
				}else if(
					ft != null
					&& DOMFeature.VERSION_EXPRESSION.test( nm ) )
				{
					ft.version = nm;
				}
			}
			return specified;
		}
		
		/**
		* 	@private
		* 
		* 	Builds a list of all features supported by this
		* 	DOM implementation context.
		* 
		* 	Derived implementations <strong>must</strong> modify
		* 	the output of this method to indicate the exact
		* 	features supported by this implementation source.
		* 
		* 	@return A list of features supported by this
		* 	implementation source.
		*/
		protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = new Vector.<DOMFeature>();
			return output;
		}
		
		/**
		* 	@private
		* 
		* 	Builds a list of all feature names supported by this
		* 	DOM implementation context.
		* 
		* 	@return A list of feature names supported by this
		* 	implementation source.
		*/
		protected function getFeatures():Vector.<String>
		{
			var features:Vector.<String> = new Vector.<String>();
			var supported:Vector.<DOMFeature> = getSupportedFeatures();
			for( var i:int = 0;i < supported.length;i++ )
			{
				//derived implementations should never add
				//a null supported feature, if they do so it is a programming
				//error and will be caught as a null pointer exception
				//on this toString() call
				features.push( supported[ i ].toString() );
			}
			return features;
		}
		
		/**
		* 	@private
		*/
		protected function addImplementationRegistry( beans:IBeanDocument ):void
		{
			//CORE DOM IMPLEMENTATION ACCESS ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor( 
			 	DOMImplementationListImpl.NAME );
			descriptor.instanceClass = DOMImplementationListImpl;
			beans.addBeanDescriptor( descriptor );
		}
	}
}