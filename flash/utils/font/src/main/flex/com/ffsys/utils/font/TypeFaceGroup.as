package com.ffsys.utils.font {
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Encapsulates a group of fonts associated
	*	with the language of a locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.05.2008
	*/
	public class TypeFaceGroup extends Object
		implements  ITypeFaceGroup,
		 			IDeserializeProperty {
			
		/**
		*	@private	
		*/
		private var _lang:String;
		
		/**
		*	@private	
		*/
		private var _path:String;		
		
		/**
		*	@private	
		*/
		private var _typeFaces:Array;
		
		/**
		*	Creates a <code>TypeFaceGroup</code> instance.
		*/
		public function TypeFaceGroup()
		{
			super();
			_typeFaces = new Array();
		}
		
		/**
		*	@inheritDoc
		*/
		public function set lang( val:String ):void
		{
			_lang = val;
		}
		
		public function get lang():String
		{
			return _lang;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set path( val:String ):void
		{
			_path = val;
		}
		
		public function get path():String
		{
			return _path;
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function getLength():int
		{
			return _typeFaces.length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getTypeFaceAt( index:int ):ITypeFace
		{
			if( index < 0 || index >= getLength() )
			{
				return null;
			}
			
			return _typeFaces[ index ];
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getTypeFaceById( id:String ):ITypeFace
		{
			var i:int = 0;
			var l:int = getLength();
			
			var face:ITypeFace = null;
			
			for( ;i < l; i++ )
			{
				face = getTypeFaceAt( i );
				if( face.id == id )
				{
					return face;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleById(
			id:String, typeFaceId:String = null ):ITypeFaceStyle
		{
			var face:ITypeFace = null;
			
			if( typeFaceId )
			{
				face = getTypeFaceById( typeFaceId );
			}
			
			//getting the style from a particular
			//type face
			if( face )
			{
				return face.getStyleById( id );
			}
			
			//otherwise search all type faces
			var i:int = 0;
			var l:int = getLength();
			
			var style:ITypeFaceStyle = null;
			
			for( ;i < l; i++ )
			{
				face = getTypeFaceAt( i );
				style = face.getStyleById( id );
				
				if( style )
				{
					return style;
				}
			}
			
			return null;
		}
		
		/**
		*	@private	
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( this.hasOwnProperty( name ) )
			{
				this[ name ] = value;
				return;
			}
			
			_typeFaces.push( ITypeFace( value ) );
		}		
	}
}