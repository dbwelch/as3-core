package com.ffsys.w3c.dom.xml
{
	import org.w3c.dom.*;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.NodeImpl;
	
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	
	/**
	* 	Extends the load and save features support with the "XML" feature.
	* 
	* 	<ol>
	* 		<li><code>Core</code></li>
	* 		<li><code>ElementTraversal</code></li>
	* 		<li><code>Range</code></li>
	* 		<li><code>Traversal</code></li>
	* 		<li><code>Events</code></li>
	* 		<li><code>MutationEvents</code></li>
	* 		<li><code>MutationNameEvents</code></li>
	* 		<li><code>LS</code></li>
	* 		<li><code>LS-Async</code></li>
	* 		<li><code>XML</code></li>
	* 	</ol>
	*/
	public class XMLDOMImplementationImpl extends DOMImplementationLSImpl
	{
		/**
		* 	The bean name for the implementation of the "XML" feature.
		*/
		public static const NAME:String = DOMFeature.XML_MODULE;
		
		/**
		* 	Creates an <code>XMLDOMImplementationImpl</code> instance.
		*/
		public function XMLDOMImplementationImpl()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		override protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = super.supported;
				_supported.push( DOMFeature.XML_3_FEATURE );
			}
			return _supported;
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document
		{
			//trace("DOMImplementationImpl::getDefaultDocumentType()", qualifiedName );
			
			var document:XMLDocumentImpl = XMLDocumentImpl(
				this.document.getBean( XMLDocumentImpl.NAME ) );
			
			if( namespaceURI != null )
			{
				NodeImpl( document ).namespaceDeclarations.push(
					new Namespace( namespaceURI ) );
			}
			
			var e:Element = document.createElement( qualifiedName );
			document.appendChild( e );
			
			//TOOD: handle inspecting the doctype and 
			//retrieving more specialized implementations where appropriate
			
			setImplementation( document, doctype );
			
			return document;
		}
	}
}