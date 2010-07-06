package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.scrollbars.HorizontalScrollBar;
	import com.ffsys.ui.scrollbars.IScrollBar;
	import com.ffsys.ui.scrollbars.VerticalScrollBar;
	
	/**
	*	Encapsulates the scroll bar settings for a container.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public class Scroller extends UIComponent
		implements IScroller {
		
		private var _alwaysShowVerticalScrollBar:Boolean;
		private var _alwaysShowHorizontalScrollBar:Boolean;
		
		private var _verticalScrollBarEnabled:Boolean = true;
		private var _horizontalScrollBarEnabled:Boolean = true;
		
		private var _verticalScrollBar:IScrollBar;
		private var _horizontalScrollBar:IScrollBar;
		
		/**
		*	Creates a <code>Scroller</code> instance.
		*	
		*	@param width The width of the scroller.
		*	@param height The height of the scroller.
		*/
		public function Scroller(
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
			preferredWidth = width;
			preferredHeight = height;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number,
			height:Number ):void
		{
			trace("Scroller::layoutChildren(), ", width, height );
			
			var w:Number = preferredWidth;
			var h:Number = preferredHeight;
			
			if( _verticalScrollBar )
			{
				w -= _verticalScrollBar.preferredWidth;
			}
			
			if( _horizontalScrollBar )
			{
				h -= _horizontalScrollBar.preferredHeight;
			}
			
			if( _verticalScrollBar )
			{
				_verticalScrollBar.setSize(
					_verticalScrollBar.preferredWidth, h );
				_verticalScrollBar.x = 
					preferredWidth - _verticalScrollBar.preferredWidth;
			}
			
			if( _horizontalScrollBar )
			{
				_verticalScrollBar.setSize(
					w, _horizontalScrollBar.preferredHeight );
				_horizontalScrollBar.y =
					preferredHeight - _verticalScrollBar.preferredHeight;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			if( _verticalScrollBarEnabled )
			{
				_verticalScrollBar = new VerticalScrollBar();
				addChild( DisplayObject( _verticalScrollBar ) );
			}
			
			if( _horizontalScrollBarEnabled )
			{
				_horizontalScrollBar = new HorizontalScrollBar();
				addChild( DisplayObject( _horizontalScrollBar ) );
			}
		}
	}
}