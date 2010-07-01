package com.ffsys.ui.scrollbars {
	
	import com.ffsys.ui.display.Graphic;
	import com.ffsys.ui.graphics.*;
	
	/**
	*	Represents the scroll track for a scroll bar.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.06.2010
	*/
	public class ScrollTrack extends Graphic
		implements IScrollTrack {
		
		/**
		*	Creates a <code>ScrollTrack</code> instance.
		*	
		*	@param width The preferred width for the scroll track.
		*	@param height The preferred height for the scroll track.
		*/
		public function ScrollTrack(
			width:Number = 10,
			height:Number = 10 )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.interactive = true;
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
				new SolidFill( 0x999999, 0.5 ) );
		}
	}
}