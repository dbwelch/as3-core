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
		private var _size:Number = NaN;
		
		/**
		* 	Creates an <code>Layout</code> instance.
		*/
		public function Layout()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function added( child:DisplayObject ):void
		{
			layoutChildren( [ child ] );
				
			var next:Array = getNextDisplayObjects( child );
			if( next.length > 0 )
			{
				layoutChildren( next );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function removed( child:DisplayObject ):void
		{
			var next:Array = getNextDisplayObjects( child );
			if( next.length > 0 )
			{
				layoutChildren( next );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function update( container:DisplayObjectContainer ):void
		{
			if( container )
			{
				var child:DisplayObject = null;
				for( var i:int = 0;i < container.numChildren;i++ )
				{
					child = container.getChildAt( i );
					
					layoutChild(
						child.parent,
						child,
						getPreviousDisplayObject( child.parent, child ) );
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get spacing():Number
		{
			return _spacing;
		}
		
		public function set spacing( spacing:Number ):void
		{
			_spacing = spacing;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get size():Number
		{
			return _size;
		}
		
		public function set size( size:Number ):void
		{
			_size = size;
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
		
		/**
		*	Performs layout on an individual child.
		*/
		protected function layoutChild(
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):void
		{
			//
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
		*	Attempts to retrieve a display object at the
		*	next depth.
		*	
		*	@param parent The parent display object container.
		*	@param child The display object.
		*/
		protected function getNextDisplayObject(
			parent:DisplayObjectContainer,
			child:DisplayObject ):DisplayObject
		{
			var index:int = parent.getChildIndex( child );
			
			if( index < ( parent.numChildren - 1 ) )
			{
				return parent.getChildAt( index + 1 );
			}
			
			return null;
		}
		
		protected function layoutChildren( children:Array ):void
		{
			var child:DisplayObject = null;
			for( var i:int = 0;i < children.length;i++ )
			{
				child = DisplayObject( children[ i ] );
				layoutChild(
					child.parent,
					child,
					getPreviousDisplayObject( child.parent, child ) );		
			}
		}
		
		protected function getNextDisplayObjects( child:DisplayObject ):Array
		{
			var output:Array = new Array();
			
			var index:int = child.parent.getChildIndex( child ) + 1;
			
			for( ;index < child.parent.numChildren;index++ )
			{
				output.push( child.parent.getChildAt( index ) );
			}
			
			return output;
		}
		
		protected function getPreviousDisplayObjects( child:DisplayObject ):Array
		{
			var output:Array = new Array();
			
			var index:int = child.parent.getChildIndex( child ) - 1;
			
			for( ;index >= 0;index-- )
			{
				output.push( child.parent.getChildAt( index ) );
			}
			
			return output;
		}
	}
}