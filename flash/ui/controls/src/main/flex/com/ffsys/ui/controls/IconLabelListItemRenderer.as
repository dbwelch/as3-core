package com.ffsys.ui.controls
{
	import com.ffsys.ui.containers.HorizontalBox;
	import com.ffsys.ui.data.*;
	import com.ffsys.ui.text.Label;
	import com.ffsys.ui.display.RuntimeAsset;
	
	/**
	*	Default implementation of an item renderer that appears in lists.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class IconLabelListItemRenderer extends ItemRenderer
	{
		private var _hbox:HorizontalBox;
		private var _label:Label;
		private var _asset:RuntimeAsset;
		
		/**
		* 	Creates a <code>IconLabelListItemRenderer</code> instance.
		*/
		public function IconLabelListItemRenderer()
		{
			super();
		}
		
		/**
		* 	Creates the child components for this item renderer.
		*/
		override protected function createChildren():void
		{
			_hbox = new HorizontalBox();
			addChild( _hbox );
			
			if( this.dataBinding && ( this.dataBinding is IDataBindingProxy ) )
			{
				var proxy:IDataBindingProxy = IDataBindingProxy( this.dataBinding );
				var labelBinding:IDataBinding = proxy.getDataBindingByType( StringDataBinding );
				var displayBinding:IDataBinding = proxy.getDataBindingByType( DisplayObjectDataBinding );
				
				_asset = new RuntimeAsset();
				_asset.dataBinding = displayBinding;
				_hbox.addChild( _asset );
			
				_label = new Label();
				_label.dataBinding = labelBinding;
				_hbox.addChild( _label );
			}
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