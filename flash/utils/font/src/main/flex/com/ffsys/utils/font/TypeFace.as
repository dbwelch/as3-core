package com.ffsys.utils.font {
	
	/**
	*	Encapsulates the data associated with a single
	*	type face.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.05.2008
	*/
	public class TypeFace extends Object
		implements ITypeFace {
			
		/**
		*	@private	
		*/
		private var _id:String;
			
		/**
		*	@private	
		*/
		private var _styles:ITypeFaceStyles;
		
		/**
		*	Creates a <code>TypeFace</code> instance.
		*/
		public function TypeFace()
		{
			super();
			_styles = new TypeFaceStyles();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set styles( val:ITypeFaceStyles ):void
		{
			_styles = val;
		}
		
		public function get styles():ITypeFaceStyles
		{
			return _styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleById(
			id:String ):ITypeFaceStyle
		{
			return _styles.getStyleById( id );
		}
	}
}