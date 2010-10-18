package com.ffsys.io.xml {
	
	/**
	*	Describes the methods and properties for instances
	*	that parse XML documents into Actionscript
	*	<code>Object</code> structures.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	public interface IParser {
		
	/*
	*	This method should instantiate the underlying
	*	Deserializer, IDeserializeInterpreter and ClassNodeNameMap
	*	instances and set default values. It is recommended that this
	*	method is invoked in the constructor of the implementing Class.
	*/
		//function initialize():void;
		
		/**
		*	The <code>Deserializer</code> instance associated
		*	with this parser.
		*/
		function get deserializer():Deserializer;
		
	/*
	*	Gets the ClassNodeNameMap associated with this instance,
	*	this allows for you to associate arbritrary node name to Class
	*	mappings with the pass used by the deserializer.
	*
	*	@return the ClassNodeNameMap associated with this instance
	*/		
		
		/**
		*	The <code>ClassNodeNameMap</code> instance associated
		*	with this parser.
		*/
		function set classNodeNameMap( val:ClassNodeNameMap ):void;		
		function get classNodeNameMap():ClassNodeNameMap;
		
		/**
		*	The <code>IDeserializeInterpreter</code> instance associated
		*	with this parser.
		*/
		function set interpreter( val:IDeserializeInterpreter ):void
		function get interpreter():IDeserializeInterpreter;
		
		/**
		*	The <code>ClassParserMap</code> instance associated
		*	with this parser.
		*/		
		function set classParserMap( val:ClassParserMap ):void;
		function get classParserMap():ClassParserMap;
		
		/**
		*	The <code>Class</code> to instantiate for the root
		*	element in the XML document.
		*/		
		function set root( val:Class ):void;
		function get root():Class;
		
		/**
		*	The default <code>Class</code> to instantiate
		*	for elements in the XML document.
		*/		
		function set node( val:Class ):void;
		function get node():Class;	
		
		/**
		*	Proxies the deserialization logic to the encapsulated deserializer
		*	and returns the deserialized object.
		*	
		*	@param x The XML document.
		*	@param target A target object to deserialize into.
		*	
		*	@return The deserialized object.
		*/
		function deserialize( x:XML, target:Object = null ):Object;
	}
}