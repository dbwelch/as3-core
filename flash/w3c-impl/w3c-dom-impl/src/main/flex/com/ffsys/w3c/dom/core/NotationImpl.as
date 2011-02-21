package com.ffsys.w3c.dom.core
{
	import org.w3c.dom.*;
	
	/**
	*	Represents a notation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class NotationImpl extends NodeImpl
		implements Notation
	{
		private var _publicId:String;
		private var _systemId:String;
		
		/**
		* 	Creates a <code>NotationImpl</code> instance.
		*/
		public function NotationImpl()
		{
			super();
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
		public function get systemId():String
		{
			return _systemId;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.NOTATION_NODE;
		}
	}
}