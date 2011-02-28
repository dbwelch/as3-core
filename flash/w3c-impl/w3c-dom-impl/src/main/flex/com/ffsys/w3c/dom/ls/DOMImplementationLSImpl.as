package com.ffsys.w3c.dom.ls
{	
	import org.w3c.dom.ls.DOMImplementationLS;
	import org.w3c.dom.ls.LSInput;	
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.LSParser;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;

	import com.ffsys.w3c.dom.ls.serialize.DOMSerializerImpl;
	import com.ffsys.w3c.dom.ls.parser.DOMParserImpl;
	
	public class DOMImplementationLSImpl extends DocumentEventImpl
		implements DOMImplementationLS
	{
		/**
		* 	The name for the <code>DOM</code> LS implementation bean document.
		*/
		public static const LS_IMPLEMENTATION_DOC_NAME:String = DOMFeature.LS_MODULE;	
		
		/**
		* 	Creates a <code>DOMImplementationLSImpl</code> instance.
		*/
		public function DOMImplementationLSImpl()
		{
			super();
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