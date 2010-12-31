package com.ffsys.ui.runtime {
	
	import com.ffsys.io.xml.DeserializationMode;
	
	import com.ffsys.ioc.IBeanDocument;	
	import com.ffsys.ioc.support.xml.BeanXmlParser;
	
	import com.ffsys.utils.substitution.Binding;	
	
	/**
	*	Responsible for parsing the runtime view definition document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeParser extends BeanXmlParser
		implements IRuntimeParser {
		
		private var _runtime:IDocument;
		
		/**
		*	Creates a <code>RuntimeParser</code> instance.
		* 
		* 	@param document The components bean document.
		*/
		public function RuntimeParser( document:IBeanDocument = null )
		{
			super( document );
		}
		
		/**
		*	The runtime document to parse the view data into.
		*/
		public function get runtime():IDocument
		{
			if( _runtime == null )
			{
				_runtime = new Document();
			}
			
			return _runtime;
		}
		
		public function set runtime( value:IDocument ):void
		{
			_runtime = value;
		}
		
		/**
		* 	Ensures the right type of document is available by default.
		*/
		override public function get document():IBeanDocument
		{
			if( _document == null )
			{
				_document = new ComponentBeanDocument();
			}
			return _document;
		}
		
		public function addDocumentBindings( document:IDocument, ...bindings ):void
		{
			trace("RuntimeParser::addDocumentBindings()", bindings );
			
			if( document == null )
			{
				document = this.runtime;
			}
			
			if( bindings.length > 0 )
			{
				var binding:Object = null;
				for( var i:int = 0;i < bindings.length;i++ )
				{
					binding = bindings[ i ];
					for( var z:String in binding )
					{
						document.binding[ z ] = binding[ z ];
					}
				}
				
				this.interpreter.bindings.addBinding(
					new Binding( Runtime.BINDING, document.binding ) );
			}			
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			this.interpreter = new RuntimeInterpreter( this.document );
		}
		
		/**
		* 	Performs deserialization of an xml view document.
		* 
		* 	@param x The xml document.
		* 	@param target A target implementation to deserialize into.
		* 
		* 	@return The root object of the deserialized object graph.
		*/
		override public function deserialize( x:XML, target:Object = null ):Object
		{
			if( target == null )
			{
				target = this.runtime;
			}
			
			return super.deserialize( x, target );
		}
	}
}