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
		
		static private var __implementations:Vector.<DOMImplementation> =
			new Vector.<DOMImplementation>();
			
		/**
		* 	@private
		* 
		* 	Used internally in the unit tests to purge cached implementations.
		*/
		static internal function clearCachedImplementations():void
		{
			_factories = new Dictionary( true );
			__implementations =
				new Vector.<DOMImplementation>();			
		}
			
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
			this.xrefs.push( factories );
		}
		
		/**
		* 	@private
		*/
		protected function createImplementationFactory(
			factories:IBeanDocument,
			name:String,
			type:Class,
			singleton:DOMImplementation ):IBeanDescriptor
		{
			if( _factories[ name ] is IBeanDescriptor )
			{
				return IBeanDescriptor( _factories[ name ] );
			}
			
			var descriptor:IBeanDescriptor =
				new InjectedBeanDescriptor(
					name, singleton, true );
			descriptor.instanceClass = type;
			factories.addBeanDescriptor( descriptor );
			
			if( singleton is IBeanDocumentAware )
			{
				//ensure the factory instantiates in the scope
				//of this document
				IBeanDocumentAware( singleton ).document = this;
			}
			
			//store the singleton factory
			__implementations.push( singleton );
			
			_factories[ name ] = descriptor;
			return descriptor;
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
			
			//trace("[GET DOM IMPL] DOMBootstrap::getDOMImplementation()", features );
			
			var list:DOMImplementationList = getDOMImplementationList( features );
			
			if( list != null && list.length > 0 )
			{
				//trace("[GOT DOM IMPLEMENTATION] DOMBootstrap::getDOMImplementation()", list.length, list[ 0 ], list[ list.length - 1 ] );
				
				//return the first encountered - should be the most lightweight
				//implementation if the factory singletons were added
				//in the correct order
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
			
			var impls:Vector.<DOMImplementation> = __implementations;
			
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
					//trace("[ADD IMPL] DOMBootstrap::getDOMImplementationList()", impl );
					list.implementations.push( impl );
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