package com.ffsys.w3c.dom.bootstrap
{
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
		* 	Creates a <code>DOMBootstrap</code> instance.
		* 
		* 	@param identifier A specific id to use for this document.
		*/
		public function DOMBootstrap( identifier:String = null )
		{
			super( identifier );
			doWithBeans( this );
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
			var list:DOMImplementationList = getDOMImplementationList( features );
			if( list != null && list.length > 0 )
			{
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
				
			var specified:Vector.<DOMFeature> = getSpecifiedFeatures( features );
			getDOMImplementationFromFeatures( list, specified );
			return list;
		}
		
		/**
		* 	@private
		*/
		protected function getDOMImplementationFromFeatures(
			list:DOMImplementationListImpl,
			specified:Vector.<DOMFeature> ):DOMImplementation
		{
			//TODO: look in xrefs for alternative
			//(potentially more lightweight) implementations			
			
			var supported:Vector.<String> = getFeatures();	
			var ft:DOMFeature = null;
			
			var valid:Boolean = false;
			for( var i:int = 0;i < specified.length;i++ )
			{
				ft = specified[ i ];
				valid = supported.indexOf( ft.toString() ) > -1;
				if( !valid )
				{
					break;
				}
			}
			
			//all matched so add the implementation
			if( i == specified.length )
			{
				//list.implementations.push( );
			}
			return null;
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
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
		}
	}
}