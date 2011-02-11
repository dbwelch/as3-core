package com.ffsys.dom.core
{
	import org.w3c.dom.*;	
	
	/**
	* 	TODO
	*/
	public class DOMErrorImpl extends Object
		implements DOMError
	{
		private var _severity:Number = -1;
		private var _message:String;
		private var _type:String;
		private var _relatedException:Object;
		private var _relatedData:Object;
		private var _location:DOMLocator;
		
		/**
		* 	Creates a <code>DOMErrorImpl</code> instance.
		*/
		public function DOMErrorImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get severity():Number
		{
			return _severity;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get message():String
		{
			return _message;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get type():String
		{
			return _type;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get relatedException():Object
		{
			return _relatedException;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get relatedData():Object
		{
			return _relatedData;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get location():DOMLocator
		{
			return _location;
		}
	}
}