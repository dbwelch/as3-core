package com.ffsys.ui.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	*	Abstract super class for layout implmentations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Layout extends Object
		implements ILayout
	{
		private var _horizontalSpacing:Number = 0;
		private var _verticalSpacing:Number = 0;
		private var _spacing:Number = 0;
		
		/**
		* 	Creates an <code>Layout</code> instance.
		*/
		public function Layout()
		{
			super();
		}
		
		/**
		*	Attempts to retrieve a display object at the
		*	previous depth.
		*	
		*	@param parent The parent display object container.
		*	@param child The display object.
		*/
		protected function getPreviousDisplayObject(
			parent:DisplayObjectContainer,
			child:DisplayObject ):DisplayObject
		{
			var index:int = parent.getChildIndex( child );
			
			if( index > 0 )
			{
				return parent.getChildAt( index - 1 );
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function added( child:DisplayObject ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function removed( child:DisplayObject ):void
		{
			//
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get spacing():Number
		{
			return _spacing;
		}
		
		public function set spacing(
			spacing:Number ):void
		{
			_spacing = spacing;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get horizontalSpacing():Number
		{
			return _horizontalSpacing;
		}
		
		public function set horizontalSpacing(
			horizontalSpacing:Number ):void
		{
			_horizontalSpacing = horizontalSpacing;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get verticalSpacing():Number
		{
			return _verticalSpacing;
		}
		
		public function set verticalSpacing(
			verticalSpacing:Number ):void
		{
			_verticalSpacing = verticalSpacing;
		}		
	}
}