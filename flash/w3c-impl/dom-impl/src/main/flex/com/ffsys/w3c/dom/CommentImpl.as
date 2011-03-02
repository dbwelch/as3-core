package com.ffsys.w3c.dom
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
		* 	The bean name for this node.
		*/
		public static const NAME:String = "Comment";
		
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
		* 	An <code>XML</code> representation of this node.
		*/
		override public function get xml():XML
		{
			if( _xml == null || _xml.toString() != data )
			{
				_xml = new XML( "<!--" + data + "-->" );
			}
			return _xml;
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
			return NodeType.COMMENT_NODE;
		}
	}
}