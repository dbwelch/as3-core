package com.ffsys.ioc.support.xml
{
	import com.ffsys.io.xml.Parser;	
	import com.ffsys.io.xml.IDeserializeInterpreter;
	
	import com.ffsys.ioc.IBeanDocument;
	
	/**
	*	A parser implementation responsible for using a bean
	* 	definition to instantiate an object for each xml node.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.12.2010
	*/
	public class BeanXmlParser extends Parser
	{
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>BeanXmlParser</code> instance.
		* 
		* 	@param document The bean document used to instantiate
		* 	objects for each node.
		*/
		public function BeanXmlParser( document:IBeanDocument = null )
		{
			super();
			this.interpreter = new BeanXmlInterpreter();
			this.document = document;
		}
		
		/**
		* 	The bean document containing bean definitions used
		* 	when instantiating an object for xml nodes.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
			
			if( value != null && ( this.interpreter is BeanXmlInterpreter ) )
			{
				BeanXmlInterpreter( this.interpreter ).document = value;
			}
		}
		
		/**
		* 	Ensures that the bean document reference is proxied to the bean
		* 	xml interpreter.
		*/
		override public function set interpreter( value:IDeserializeInterpreter ):void
		{
			_interpreter = value;
			if( value != null && ( this.interpreter is BeanXmlInterpreter ) )
			{
				BeanXmlInterpreter( this.interpreter ).document = this.document;
			}
		}
	}
}