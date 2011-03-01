package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.Node;	
	import org.w3c.dom.css.MediaList;
	import org.w3c.dom.css.StyleSheet;
	
	import com.ffsys.w3c.dom.DocumentImpl;	
	
	/**
	* 	Abstract super class for all style sheet implementations.
	*/
	public class StyleSheetImpl extends DocumentImpl
		implements StyleSheet
	{
		private var _type:String;
		private var _disabled:Boolean;
		private var _ownerNode:Node;
		private var _parentStyleSheet:StyleSheet;
		private var _href:String;
		private var _title:String;
		private var _media:MediaList;
		
		/**
		* 	Creates a <code>StyleSheetImpl</code> instance.
		* 
		* 	@param parent A parent style sheet implementation.
		* 	@param owner The node that owns this style sheet.
		*/
		public function StyleSheetImpl(
			parent:StyleSheet = null,
			owner:Node = null )
		{
			super();
			if( parent != null )
			{
				_parentStyleSheet = parent;
			}
			if( owner != null )
			{
				_ownerNode = owner;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get type():String
		{
			return _type;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get disabled():Boolean
		{
			return _disabled;
		}
		
		public function set disabled( disabled:Boolean ):void
		{
			_disabled = disabled;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get ownerNode():Node
		{
			return _ownerNode;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parentStyleSheet():StyleSheet
		{
			return _parentStyleSheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get href():String
		{
			return _href;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get title():String
		{
			return _title;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get media():MediaList
		{
			return _media;
		}
	}
}