package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	*	TODO
	*/
	public class EntityImpl extends NodeImpl
		implements Entity
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "Entity";
		
		private var _publicId:String;
		private var _systemId:String;
		private var _notationName:String;
		private var _inputEncoding:String;
		private var _xmlEncoding:String;
		private var _xmlVersion:String;
		
		/**
		* 	Creates an <code>EntityImpl</code> instance.
		*/
		public function EntityImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return this.notationName;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.ENTITY_NODE;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get publicId():String
		{
			return _publicId;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set systemId( value:String ):void
		{
			_systemId = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get notationName():String
		{
			return _notationName;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get inputEncoding():String
		{
			return _inputEncoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlEncoding():String
		{
			return _xmlEncoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlVersion():String
		{
			return _xmlVersion;
		}
	}
}