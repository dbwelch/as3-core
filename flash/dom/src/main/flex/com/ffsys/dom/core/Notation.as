package com.ffsys.dom.core
{
	
	/**
	*	Represents a notation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class Notation extends Node
	{
		private var _publicId:String;
		private var _systemId:String;
		
		/**
		* 	Creates a <code>Notation</code> instance.
		*/
		public function Notation( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The public identifier for the notation.
		*/
		public function get publicId():String
		{
			//This read-only property is of type String.
			return _publicId;
		}
		
		/**
		* 	The system identifier for the notation.
		*/
		public function get systemId():String
		{
			//This read-only property is of type String.
			return _systemId;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.NOTATION_NODE;
		}
	}
}