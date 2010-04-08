package com.ffsys.io.xml {
	
	import flash.utils.Dictionary;
	
	/**
	*	Represents a mapping between a <code>Class</code>
	*	and an <code>IParser</code> instance to use when
	*	deserializing XML elements that map to the given
	*	<code>Class</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.10.2007
	*/
	public class ClassParserMap extends Object {
		
		/**
		*	@private
		*	
		*	The dictionary instance used to store the mapping.
		*/
		private var _classDictionary:Dictionary;	
		
		/**
		*	Creates a new <code>ClassParserMap</code>.
		*/
		public function ClassParserMap()
		{
			super();
			clear();
		}
		
		/**
		*	Clears all the mappings in this
		*	<code>ClassParserMap</code>.
		*/
		public function clear():void
		{
			_classDictionary =
				new Dictionary( true );
		}
		
		/**
		*	Adds a new mapping between a <code>Class</code>
		*	and an <code>IParser</code> implementation.
		*	
		*	@param classReference The <code>Class</code> that
		*	should use the given <code>IParser</code>/.
		*	@param parser The <code>IParser</code> to associate
		*	with <code>classReference</code>.
		*/
		public function add(
			classReference:Class, parser:IParser ):void
		{
			_classDictionary[ classReference ] = parser;
		}
		
		/**
		*	Removes a mapping.
		*	
		*	@param classReference The <code>Class</code> that
		*	was used to create the mapping.
		*/
		public function remove( classReference:Class ):void
		{
			delete _classDictionary[ classReference ];
		}
		
		/**
		*	Gets the <code>IParser</code> implementation
		*	that is mapped to <code>classReference</code>.
		*	
		*	@param classReference The <code>Class</code> that
		*	was used to create the mapping.
		*	
		*	@return The mapped <code>IParser</code>
		*	implementation.
		*/
		public function getParserByClass( classReference:Class ):IParser
		{
			return _classDictionary[ classReference ];
		}
	}
}