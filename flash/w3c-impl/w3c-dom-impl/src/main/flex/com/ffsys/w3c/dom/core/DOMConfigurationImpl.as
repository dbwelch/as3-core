package com.ffsys.w3c.dom.core
{
	import org.w3c.dom.*;	
	
	/**
	* 	TODO
	*/
	public class DOMConfigurationImpl extends Object
		implements DOMConfiguration
	{
		/**
		* 	Creates a <code>DOMConfigurationImpl</code> instance.
		*/
		public function DOMConfigurationImpl()
		{
			super();
		}
	
		/**
		* 	@inheritDoc
		*/
		public function get parameterNames():DOMStringList
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setParameter( name:String, value:* ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getParameter( name:String ):*
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function canSetParameter( name:String, value:* ):Boolean
		{
			//TODO
			return false;
		}
	}

}

