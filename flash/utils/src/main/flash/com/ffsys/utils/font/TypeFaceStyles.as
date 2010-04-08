package com.ffsys.utils.font {
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Encapsulates a collection of
	*	<code>ITypeFaceStyle</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.05.2008
	*/
	public class TypeFaceStyles extends Object
		implements  ITypeFaceStyles,
		 			IDeserializeProperty {
			
		/**
		*	@private	
		*/
		private var _styles:Array;
		
		/**
		*	@private
		*/
		private var _font:String;
		
		/**
		*	Creates a <code>TypeFaceStyles</code> instance.
		*/
		public function TypeFaceStyles()
		{
			super();
			_styles = new Array();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getLength():int
		{
			return _styles.length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleAt( index:int ):ITypeFaceStyle
		{
			if( index < 0 || index >= getLength() )
			{
				return null;
			}
			
			return _styles[ index ];
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleById( id:String ):ITypeFaceStyle
		{
			var i:int = 0;
			var l:int = getLength();
			
			var style:ITypeFaceStyle;
			
			for( ;i < l; i++ )
			{
				style = getStyleAt( i );
				
				if( style.id == id )
				{
					return style;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set font( val:String ):void
		{
			_font = val;
			
			//crude hack - requires that
			//the font element is after all TypeFaceStyle
			//elements in the font definition xml document
			var i:int = 0;
			var l:int = _styles.length;
			
			for( ;i < l; i++ )
			{
				_styles[ i ].font = val;
			}
		}
		
		public function get font():String
		{
			return _font;
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
			
			if( value is ITypeFaceStyle )
			{
				_styles.push( ITypeFaceStyle( value ) );
			}
		}
	}
}