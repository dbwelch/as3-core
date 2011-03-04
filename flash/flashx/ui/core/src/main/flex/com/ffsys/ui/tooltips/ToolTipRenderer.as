package com.ffsys.ui.tooltips
{
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IPointer;
	import com.ffsys.ui.graphics.IPointerAwareGraphic;
	
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
		private var _pointer:IPointer;
		private var _graphic:IPointerAwareGraphic;
		private var _maximumTextWidth:Number = NaN;
		private var _maximumTextHeight:Number = NaN;
		
		/**
		*	Creates a <code>ToolTipRenderer</code> instance.
		*/	
		public function ToolTipRenderer()
		{
			super();
			enabled = false;
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get maximumTextWidth():Number
		{
			return _maximumTextWidth;
		}
		
		public function set maximumTextWidth( value:Number ):void
		{
			_maximumTextWidth = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get maximumTextHeight():Number
		{
			return _maximumTextHeight;
		}
		
		public function set maximumTextHeight( value:Number ):void
		{
			_maximumTextHeight = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get pointer():IPointer
		{
			return _pointer;
		}
		
		public function set pointer( value:IPointer ):void
		{
			_pointer = value;
			
			//we always draw pointers outside the bounds
			//of the graphic
			if( this.pointer )
			{
				this.pointer.inside = false;
				
				if( graphic )
				{
					graphic.pointer = pointer;
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get graphic():IPointerAwareGraphic
		{
			return _graphic;
		}
		
		public function set graphic( value:IPointerAwareGraphic ):void
		{
			_graphic = value;
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