package com.ffsys.dom
{

	/**
	*	Represents a processing instruction.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class ProcessingInstruction extends Node
	{
		private var _target:String;
		private var _data:String;
		
		/**
		* 	Creates a <code>ProcessingInstruction</code> instance.
		*/
		public function ProcessingInstruction( xml:XML = null )
		{
			_nodeType = Node.PROCESSING_INSTRUCTION_NODE;
			super( xml );
		}
		
		/**
		* 	A target for the processing instruction.
		*/
		public function get target():String
		{
			return _target;
		}
		
		/**
		* 	The data for the processing instruction.
		*/
		public function get data():String
		{
			return _data;
		}
		
		public function set data( value:String ):void
		{
			_data = value;
		}
		
		/*
		
		Object ProcessingInstruction
		ProcessingInstruction has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The ProcessingInstruction object has the following properties:
		
		target
		This read-only property is of type String.
		
		data
		This property is of type String and can raise a DOMException object on setting.		
		
		*/
	}
}