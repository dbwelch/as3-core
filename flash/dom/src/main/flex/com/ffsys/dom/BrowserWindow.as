package com.ffsys.dom
{	
	/**
	*	Represents the top-level <code>window</code> object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class BrowserWindow extends Node
	{
		private var _documents:Vector.<Document>;
		
		/**
		* 	Creates a <code>BrowserWindow</code> instance.
		*/
		public function BrowserWindow()
		{
			super();
		}
		
		
		public function get documents():Vector.<Document>
		{
			if( _documents == null )
			{
				_documents = new Vector.<Document>();
			}
			return _documents;
		}
	}
}