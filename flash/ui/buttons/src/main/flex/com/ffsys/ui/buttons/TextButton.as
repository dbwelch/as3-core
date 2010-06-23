package com.ffsys.ui.buttons
{
	import com.ffsys.ui.text.Label;

	/**
	*	Represents a button that consists of a single
	* 	text field.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextButton extends ButtonComponent
	{
		private var _label:Label;
		
		/**
		* 	Creates a <code>TextButton</code> instance.
		*/
		public function TextButton( text:String )
		{
			super();
			_label = new Label( text );
			addChild( _label );
		}
		
		/**
		* 	The label being used to render the text for this button.
		*/
		public function get label():Label
		{
			return _label;
		}
		
		/**
		* 	@inheritDic
		*/
		override protected function createChildren():void
		{
			//
		}
	}
}