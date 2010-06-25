package com.ffsys.ui.tooltips
{
	import com.ffsys.ui.core.UIComponent;
	
	/**
	*	Default tooltip renderer implementation this
	* 	implementation does nothing by default but simply
	* 	provides an abstract implementation for concrete
	* 	sub-classes to extend.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class ToolTipRenderer extends UIComponent
		implements IToolTipRenderer
	{
		private var _manager:IToolTipManager;
		private var _text:String;
		
		/**
		*	Creates a <code>ToolTipRenderer</code> instance.
		*/	
		public function ToolTipRenderer()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get manager():IToolTipManager
		{
			return _manager;
		}
		
		public function set manager( manager:IToolTipManager):void
		{
			_manager = manager;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
			return _text;
		}
		
		public function set text( text:String ):void
		{
			_text = text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function show( text:String ):void
		{
			if( manager )
			{
				manager.shown();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hide():void
		{
			if( manager )
			{
				manager.hidden();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function update( text:String ):void
		{
			this.text = text;
		}
	}
}