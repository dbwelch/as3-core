package com.ffsys.w3c.dom.ls
{
	import org.w3c.dom.ls.DOMImplementationLS;
	
	import org.w3c.dom.ls.LSInput;	
	import org.w3c.dom.ls.LSOutput;
	import org.w3c.dom.ls.LSSerializer;
	import org.w3c.dom.ls.LSParser;

	public class DOMImplementationLSImpl extends Object
		implements DOMImplementationLS
	{
		
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
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSOutput():LSOutput
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSSerializer():LSSerializer
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createLSParser(
			mode:int, schemaType:String = null ):LSParser
		{
			return null;
		}
	}
}