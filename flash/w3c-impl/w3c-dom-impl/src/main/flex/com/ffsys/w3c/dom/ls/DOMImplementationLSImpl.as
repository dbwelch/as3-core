package com.ffsys.w3c.dom.ls
{	
	import org.w3c.dom.ls.DOMImplementationLS;
	import org.w3c.dom.ls.LSInput;	
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.LSParser;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;

	import com.ffsys.w3c.dom.ls.serialize.DOMSerializerImpl;
	import com.ffsys.w3c.dom.ls.parser.DOMParserImpl;
	
	/**
	* 	Extends the events features support with the LS and
	* 	LS-Async features.
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
	* 	</ol>
	*/	
	public class DOMImplementationLSImpl extends DocumentEventImpl
		implements DOMImplementationLS
	{
		/**
		* 	The name for the <code>DOM</code> LS implementation bean document.
		*/
		public static const NAME:String = DOMFeature.LS_MODULE;
		
		/**
		* 	The name for the <code>DOM</code> LS-Async implementation bean document.
		*/
		public static const ASYNC_NAME:String = DOMFeature.LS_ASYNC_MODULE;
		
		/**
		* 	Creates a <code>DOMImplementationLSImpl</code> instance.
		*/
		public function DOMImplementationLSImpl()
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
				_supported.push( DOMFeature.LS_FEATURE );
				_supported.push( DOMFeature.LS_3_FEATURE );				
				_supported.push( DOMFeature.LS_ASYNC_FEATURE );
				_supported.push( DOMFeature.LS_ASYNC_3_FEATURE );
			}
			return _supported;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function createLSInput():LSInput
		{
			return this.document.getBean(
				LSInputImpl.NAME ) as LSInput;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSOutput():LSOutput
		{
			return this.document.getBean(
				LSOutputImpl.NAME ) as LSOutput;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSSerializer():LSSerializer
		{
			return this.document.getBean(
				DOMSerializerImpl.NAME ) as LSSerializer;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSParser(
			mode:int, schemaType:String = null ):LSParser
		{
			var parser:LSParser = this.document.getBean(
				DOMParserImpl.NAME ) as LSParser;
				
			//TODO: handle mode & schemaType
				
			return parser;
		}
	}
}