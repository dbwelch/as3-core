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
		* 	@private
		*/
		internal function setTarget( target:String ):void
		{
			_target = target;
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
		
		/**
		* 	Ensures that the representation of
		* 	a processing instruction is correct.
		*/
		override public function get xml():XML
		{
			if( _xml == null || _xml.name().localName != data )
			{
				_xml = new XML( "<?" + data + " ?>" );
			}
			return _xml;
		}
	}
}