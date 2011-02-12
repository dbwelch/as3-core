package com.ffsys.dom.core
{
	import org.w3c.dom.*;
		
	/**
	*	Represents a comment.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class CommentImpl extends CharacterDataImpl
		implements Comment
	{
		/**
		* 	The node name for comment nodes.
		*/
		public static const NODE_NAME:String = "#comment";		
		
		/**
		* 	Creates a <code>CommentImpl</code> instance.
		*/
		public function CommentImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.COMMENT_NODE;
		}
	}
}