package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.MediaList;
		
	/**
	* 	Represents a list of mediums.
	*/
	public class MediaListImpl extends Object
		implements MediaList
	{
		private var _mediaText:String;
		
		/**
		* 	Creates a <code>MediaListImpl</code> instance.
		*/
		public function MediaListImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get mediaText():String
		{
			return _mediaText;
		}
		
		public function set mediaText( mediaText:String ):void
		{
			_mediaText = mediaText;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):String
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function appendMedium( newMedium:String ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function deleteMedium( oldMedium:String ):void
		{
			//	
		}
	}
}