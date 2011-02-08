package com.ffsys.dom.core
{
	/**
	*	Represents an entity.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class Entity extends Node
	{
		private var _publicId:String;
		private var _systemId:String;
		private var _notationName:String;
		
		/**
		* 	Creates an <code>Entity</code> instance.
		*/
		public function Entity( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.ENTITY_NODE;
		}
		
		/**
		* 	The public identifier for this entity.
		*/
		public function get publicId():String
		{
			return _publicId;
		}
		
		/**
		* 	The system identifier for this entity.
		*/
		public function set systemId( value:String ):void
		{
			_systemId = value;
		}
		
		/**
		* 	The notation name for this entity.
		*/
		public function get notationName():String
		{
			return _notationName;
		}
	}
}