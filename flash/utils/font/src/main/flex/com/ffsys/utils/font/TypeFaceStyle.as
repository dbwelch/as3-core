package com.ffsys.utils.font {
	
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	
	/**
	*	Encapsulates text style information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2008
	*/
	public class TypeFaceStyle extends TextFormat
		implements ITypeFaceStyle {
			
		/**
		*	@private
		*/
		private var _id:String;
		
		/**
		*	@private	
		*/
		private var _css:String;
		
		/**
		*	@private	
		*/
		private var _stylesheet:StyleSheet;
		
		/**
		*	Creates a <code>TypeFaceStyle</code> instance.	
		*/
		public function TypeFaceStyle()
		{
			super();
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
		public function set css( val:String ):void
		{
			_css = val;
			_stylesheet = new StyleSheet();
			_stylesheet.parseCSS( val );
		}
		
		public function get css():String
		{
			return _css;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():StyleSheet
		{
			return _stylesheet;
		}		
	}
}