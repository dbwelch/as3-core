package com.ffsys.ui.controls
{
	import com.ffsys.ui.data.StringDataBinding;
	import com.ffsys.ui.text.Label;
	
	/**
	*	Default implementation of an item renderer that appears in lists.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class DefaultListItemRenderer extends ItemRenderer
	{
		private var _label:Label;
		
		/**
		* 	Creates a <code>DefaultListItemRenderer</code> instance.
		*/
		public function DefaultListItemRenderer()
		{
			super();
		}
		
		/**
		* 	Creates the child components for this item renderer.
		*/
		override protected function createChildren():void
		{
			_label = new Label();
			_label.dataBinding = this.dataBinding;
			addChild( _label );
		}
		
		/**
		* 	The label for this list item renderer.
		*/
		public function get label():Label
		{
			return _label;
		}
	}
}