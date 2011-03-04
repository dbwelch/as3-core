package com.ffsys.io.xml {

	import com.ffsys.io.xml.Deserializer;
	import com.ffsys.io.xml.ClassNodeNameMap;
	import com.ffsys.io.xml.PropertyFieldType;
	import com.ffsys.io.xml.IDeserializeInterpreter;
	import com.ffsys.io.xml.IParser;
	 
	/**
	*	Parses an XML document into an Actionscript
	*	<code>Object</code> structure.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public class Parser extends Object
		implements IParser {
			
		/**
		*	The <code>String</code> name of the property to
		*	set on the deserialized instances that refers to
		*	their parent instance.
		*/
		static public const PARENT_FIELD:String = "parent";
		
		/**
		*	@private
		*/
		protected var _root:Class;
		
		/**
		*	@private
		*/
		protected var _node:Class;
		
		/**
		*	@private
		*/
		protected var _classNodeNameMap:ClassNodeNameMap;
		
		/**
		*	@private	
		*/
		protected var _classParserMap:ClassParserMap;
		
		/**
		*	@private
		*/
		protected var _deserializer:Deserializer;
		
		/**
		*	@private
		*/		
		protected var _interpreter:IDeserializeInterpreter;
		
		/**
		*	Creates a new <code>Parser</code> instance.
		*
		*	@param root The Class to instantiate for the
		*	root element of the XML document.
		*	@param node The Class to instantiate for the
		*	individual elements of the XML document.
		*/
		public function Parser(
			root:Class = null, node:Class = null )
		{
			super();
			
			if( !root )
			{
				root = Object;
			}
			
			if( !node )
			{
				node = null;
			}
			
			_root = root;
			_node = node;
			
			initialize();
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set root( val:Class ):void
		{
			_root = val;
		}
		
		public function get root():Class
		{
			return _root;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set node( val:Class ):void
		{
			_node = val;
		}
		
		public function get node():Class
		{
			return _node;
		}
		
		/**
		*	Initializes the underlying <code>Deserializer</code>,
		*	<code>ClassParserMap</code> and <code>DeserializeInterpreter</code>.
		*	
		*	This method is automatically invoked when a
		*	new instance is created.
		*/
		protected function initialize():void
		{
			initializeNodeNameMap();
			
			_deserializer = new Deserializer();
			
			_classParserMap = new ClassParserMap();
			
			_interpreter = new DeserializeInterpreter( true, true );
			
			_deserializer.parentField = PARENT_FIELD;
			
			_deserializer.propertyFieldType = PropertyFieldType.ATTRIBUTE;
			
			_deserializer.nodeNameMap = _classNodeNameMap;
			_deserializer.classParserMap = _classParserMap;
			_deserializer.interpreter = _interpreter;
		}

		/**
		*	@inheritDoc	
		*/
		public function get deserializer():Deserializer
		{
			return _deserializer;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set interpreter( val:IDeserializeInterpreter ):void
		{
			_interpreter = val;
			
			if( _deserializer )
			{
				_deserializer.interpreter = val;
			}
			
			if( _interpreter != null )
			{
				_interpreter.parser = this;
			}
		}
		
		public function get interpreter():IDeserializeInterpreter
		{
			return _interpreter;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set classNodeNameMap( val:ClassNodeNameMap ):void
		{
			_classNodeNameMap = val;
			
			if( _deserializer )
			{
				_deserializer.nodeNameMap = val;
			}
		}				

		public function get classNodeNameMap():ClassNodeNameMap
		{
			return _classNodeNameMap;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set classParserMap( val:ClassParserMap ):void
		{
			_classParserMap = val;
		}
		
		public function get classParserMap():ClassParserMap
		{
			return _classParserMap;
		}		
		
		/**
		*	@private
		*	
		*	Initializes the <code>ClassNodeNameMap</code> to
		*	be used when deserializing an XML document.
		*/
		protected function initializeNodeNameMap():void
		{
			_classNodeNameMap =
				new ClassNodeNameMap( _node );
			
			//--> the root should become a property of ClassNodeNameMap
			//--> so that the root node of the XML does not necessarily
			//--> need to match the class name for the Class that the root
			//--> node is deserialized to
			_classNodeNameMap.add( _root );
		}
		

		public function deserialize( x:XML, target:Object = null ):Object
		{
			return _deserializer.deserialize( x, target );
		}
	}
}