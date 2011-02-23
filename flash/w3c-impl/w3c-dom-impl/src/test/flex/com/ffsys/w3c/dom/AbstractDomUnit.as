package com.ffsys.w3c.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.*;
	
	import org.w3c.dom.*;
	import org.w3c.dom.DOMException;
	import org.w3c.dom.bootstrap.DOMImplementationRegistry;
	
	/**
	*	Unit tests for the DOM implementation.
	*/ 
	public class AbstractDomUnit extends Object
	{
		
		private var _document:Document;
		
		/**
		*	Creates an <code>AbstractDomUnit</code> instance.
		*/ 
		public function AbstractDomUnit()
		{
			super();
		}
		
		/**
		* 	Creates a document
		*/
		protected function getDocument():Document
		{
			if( _document != null )
			{
				return _document;
			}
			
			//create the bean document for bootstrap
			var beans:IBeanDocument = new DOMBootstrap();
			
			//get the DOM registry
			var registry:DOMImplementationRegistry = DOMImplementationRegistry(
				beans.getBean( DOMBootstrap.DOM_REGISTRY ) );
			Assert.assertNotNull( registry );
			
			//retrieve an implementation for "XML 3.0 Core"
			var impl:DOMImplementation = registry.getDOMImplementation(
				DOMFeature.XML_MODULE + " 3.0 " + DOMFeature.CORE_MODULE );
			Assert.assertNotNull( impl );
			
			//create a null doctype
			var doctype:DocumentType = impl.createDocumentType( null, null, null );
			Assert.assertNotNull( doctype );
			
			//create a plain xml document implementation
			var doc:Document = impl.createDocument( null, "html", doctype );
			Assert.assertNotNull( doc );
			Assert.assertTrue( doc.documentElement is Element );

			Assert.assertEquals( "html", doc.documentElement.tagName );
			Assert.assertNull( doc.documentElement.localName );
			Assert.assertNull( doc.documentElement.namespaceURI );
			Assert.assertNull( doc.documentElement.prefix );			
			
			_document = doc;	
			
			return _document;		
		}
	}
}