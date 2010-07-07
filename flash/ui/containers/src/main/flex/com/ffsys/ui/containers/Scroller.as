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
		
		private var _verticalScrollEnabled:Boolean = true;
		private var _horizontalScrollEnabled:Boolean = true;
		
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
		public function get target():DisplayObject
		{
			if( _verticalScrollBar )
			{
				return _verticalScrollBar.target;
			}else if( _horizontalScrollBar )
			{
				return _horizontalScrollBar.target;
			}
			
			return null;
		}
		
		public function set target( target:DisplayObject ):void
		{
			if( target && !target.parent )
			{
				addChildAt( target, 0 );
			}			
			
			if( _verticalScrollBar )
			{
				_verticalScrollBar.target = target;
				
				if( target )
				{
					_verticalScrollBar.measure();
				}
			}
			
			if( _horizontalScrollBar )
			{
				_horizontalScrollBar.target = target;
				
				if( target )
				{
					_horizontalScrollBar.measure();
				}
			}
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
			
			trace("Scroller::layoutChildren(), w/h: ", w, h );
			
			if( _verticalScrollBar )
			{
				_verticalScrollBar.setSize(
					_verticalScrollBar.preferredWidth, h );
				_verticalScrollBar.x = w;
			}
			
			if( _horizontalScrollBar )
			{
				_horizontalScrollBar.setSize(
					w, _horizontalScrollBar.preferredHeight );
				_horizontalScrollBar.y = h;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			if( _verticalScrollEnabled )
			{
				_verticalScrollBar = new VerticalScrollBar();
				addChild( DisplayObject( _verticalScrollBar ) );
			}
			
			if( _horizontalScrollEnabled )
			{
				_horizontalScrollBar = new HorizontalScrollBar();
				addChild( DisplayObject( _horizontalScrollBar ) );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get verticalScrollBar():IScrollBar
		{
			return _verticalScrollBar;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get horizontalScrollBar():IScrollBar
		{
			return _horizontalScrollBar;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get verticalScrollEnabled():Boolean
		{
			return _verticalScrollEnabled;
		}	
		
		public function set verticalScrollEnabled( enabled:Boolean ):void
		{
			_verticalScrollEnabled = enabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get horizontalScrollEnabled():Boolean
		{
			return _horizontalScrollEnabled;
		}
		
		public function set horizontalScrollEnabled( enabled:Boolean ):void
		{
			_horizontalScrollEnabled = enabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get alwaysShowVerticalScrollBar():Boolean
		{
			return _alwaysShowVerticalScrollBar;
		}
		
		public function set alwaysShowVerticalScrollBar( value:Boolean ):void
		{
			_alwaysShowVerticalScrollBar = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get alwaysShowHorizontalScrollBar():Boolean
		{
			return _alwaysShowHorizontalScrollBar;
		}
		
		public function set alwaysShowHorizontalScrollBar( value:Boolean ):void
		{
			_alwaysShowHorizontalScrollBar = value;
		}
	}
}