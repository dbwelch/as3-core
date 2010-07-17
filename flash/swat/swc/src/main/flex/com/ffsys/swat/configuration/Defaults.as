package com.ffsys.swat.configuration {
	
	/**
	*	Encapsulates a set of defaults to be used
	*	in the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Defaults extends Object
		implements IDefaults {
		
		private var _textfield:Object;
		private var _textformat:Object;
		
		/**
		*	Creates a <code>Defaults</code> instance.	
		*/
		public function Defaults()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get textfield():Object
		{
			return _textfield;
		}
		
		public function set textfield( textfield:Object ):void
		{
			_textfield = textfield;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function get textformat():Object
		{
			return _textformat;
		}
		
		public function set textformat( textformat:Object ):void
		{
			_textformat = textformat;
		}
	}
}