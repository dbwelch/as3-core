package org.flashx.ui.text.core
{
	import flash.text.*;	
	
	/**
	*	Represents a single line textfield that has
	* 	a fixed width.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class FixedSingleLineTextField extends SingleLineTextField
	{
		private var _measuredHeight:Number;
		
		/**
		* 	Creates a <code>FixedSingleLineTextField</code> instance.
		* 
		*	@param text The text for the textfield.
		*	@param properties An object containing properties to
		*	set on this instance.
		*	@param textformat An object containing textformat properties
		*	to apply to the default text format.
		*/
		public function FixedSingleLineTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super( text, properties, textformat );
			this.width = 120;
			this.autoSize = TextFieldAutoSize.NONE;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function afterSetText( text:String ):void
		{
			var metrics:TextLineMetrics = getLineMetrics( 0 );
			this.height = metrics.height + 4;
		}
	}
}