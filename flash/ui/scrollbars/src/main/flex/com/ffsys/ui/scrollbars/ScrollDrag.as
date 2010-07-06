package com.ffsys.ui.scrollbars {
	
	import com.ffsys.ui.buttons.GraphicButton;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
	import com.ffsys.ui.states.State;
	
	import com.ffsys.ui.drag.DragOperation;
	import com.ffsys.ui.drag.IDragOperation;
	
	/**
	*	Represents the draggable scroll thumb
	*	for a scroll bar.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public class ScrollDrag extends GraphicButton
		implements IScrollDrag {
			
		private var _scrollBar:IScrollBar;
		
		/**
		*	Creates a <code>ScrollDrag</code> instance.
		*	
		*	@param width The preferred width for the scroll track.
		*	@param height The preferred height for the scroll track.
		*/
		public function ScrollDrag(
			width:Number = 10,
			height:Number = 10 )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.interactive = true;
			this.drag = new DragOperation();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollBar():IScrollBar
		{
			return _scrollBar;
		}
		
		public function set scrollBar( scroller:IScrollBar ):void
		{
			_scrollBar = scroller;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function dragUpdate( drag:IDragOperation ):void
		{
			if( scrollBar )
			{
				AbstractScrollBar( scrollBar ).dragged( this );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set interactive(
			value:Boolean ):void
		{
			super.interactive = value;
			useHandCursor = false;
			buttonMode = false;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function configureDefaultSkin():void
		{
			//main state for this component
			var main:IViewState = new ViewState();
			
			main.graphics.push(
				new RectangleGraphic(
					width,
					height ) );
					
			main.fills.push(
				new SolidFill( 0x212121 ) );
			
			this.skin.addState( main );
		}
	}
}