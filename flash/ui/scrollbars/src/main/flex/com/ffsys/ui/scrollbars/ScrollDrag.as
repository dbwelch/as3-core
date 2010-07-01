package com.ffsys.ui.scrollbars {
	
	import com.ffsys.ui.display.Graphic;
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.ui.drag.DragOperation;
	
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
	public class ScrollDrag extends Graphic
		implements IScrollDrag {
		
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
		override public function set interactive(
			value:Boolean ):void
		{
			super.interactive = value;
			useHandCursor = false;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function createChildren():void
		{
			super.createChildren();
			
			this.graphic = new RectangleGraphic(
				this.preferredWidth,
				this.preferredHeight,
				null,
				new SolidFill( 0x000000, 0.75 ) );
		}
	}
}