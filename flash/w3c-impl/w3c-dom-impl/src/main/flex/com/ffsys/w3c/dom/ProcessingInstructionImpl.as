package com.ffsys.w3c.dom
{

	import org.w3c.dom.*;	

	/**
	*	Represents a processing instruction.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class ProcessingInstructionImpl extends NodeImpl
		implements ProcessingInstruction
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "ProcessingInstruction";
		
		private var _target:String;
		private var _data:String;
		
		/**
		* 	Creates a <code>ProcessingInstructionImpl</code> instance.
		*/
		public function ProcessingInstructionImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return this.target;
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
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
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.PROCESSING_INSTRUCTION_NODE;
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