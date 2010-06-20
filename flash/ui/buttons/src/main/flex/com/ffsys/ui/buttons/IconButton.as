package com.ffsys.ui.buttons
{
	import com.ffsys.ui.text.Label;

	/**
	*	Represents a button that contains an icon.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class IconButton extends AbstractButton
	{		
		/**
		* 	Creates an <code>IconButton</code> instance.
		*/
		public function IconButton()
		{
			super();
			this.skin = this.skins.getComponentSkin( this );
		}
		
		/**
		* 	@inheritDic
		*/
		override protected function createChildren():void
		{
			//
			trace("IconButton::createChildren()");
		}
	}
}