package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.MediaList;
	import org.w3c.dom.css.MediaType;

	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
		
	/**
	* 	Represents a list of mediums.
	*/
	dynamic public class MediaListImpl extends AbstractNodeProxyImpl
		implements MediaList
	{
		private var _mediaText:String;
		private var _mediums:Vector.<String> = new Vector.<String>();
		
		/**
		* 	Creates a <code>MediaListImpl</code> instance.
		* 
		* 	@param text The candidate list of mediums; a null value
		* 	or the empty string is equivalent to the single "all" medium.
		*/
		public function MediaListImpl( text:String = null )
		{
			super();
			this.mediaText = text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get mediaText():String
		{
			if( _mediums == null || _mediums.length == 0 )
			{
				return null;
			}
			return _mediums.join(",");
		}
		
		public function set mediaText( mediaText:String ):void
		{
			_mediums = new Vector.<String>();
			if( mediaText == null || mediaText == "" )
			{
				_mediums.push( MediaType.ALL_MEDIA_TYPE );
			}else
			{			
				var parts:Array = mediaText.split(",");
				var part:String = null;
				for( var i:int = 0;i < parts.length;i++ )
				{
					part = parts[ i ];
					part = part.replace( /^\s+/, "" ).replace( /\s+$/, "" );
					appendMedium( part );
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):String
		{
			if( index < 0 || index >= _mediums.length )
			{
				return null;
			}
			return _mediums[ index ] as String;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function appendMedium( newMedium:String ):void
		{
			if( !MediaType.isValid( newMedium ) )
			{
				//TOOD: handle unrecognized medium
			}
			
			if( !hasMedium( newMedium ) )
			{
				_mediums.push( newMedium );
			}
		}
		
		/**
		* 	Retrieve the index of a medium.
		* 
		* 	@param medium The medium.
		* 
		* 	@return The index of the medium or -1 if it
		* 	is not in this list.
		*/
		public function indexOf( medium:String ):int
		{
			return _mediums.indexOf( medium );
		}
		
		/**
		* 	Determines if this list has the specified
		* 	medium.
		* 
		* 	@param medium The medium to test for existence.
		*/
		public function hasMedium( medium:String ):Boolean
		{
			return indexOf( medium ) > -1;
		}
		
		/**
		* 	Deletes a medium from this list.
		* 
		* 	If the medium does not exist in this list,
		* 	not action ius taken.
		* 
		* 	@param oldMedium The medium to delete.
		*/
		public function deleteMedium( oldMedium:String ):void
		{
			var index:int = _mediums.indexOf( oldMedium );
			if( index > -1 )
			{
				_mediums.splice( index, 1 );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			return this.mediaText;
		}
	}
}