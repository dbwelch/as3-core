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
		private var _horizontalAlign:String;
		private var _verticalAlign:String;	
		private var _spacing:Number = 0;
		private var _size:Number = NaN;
		private var _collapsed:Boolean;
		
		/**
		* 	Creates an <code>Layout</code> instance.
		*/
		public function Layout()
		{
			super();
		}
		
		/**
		*	Horizontal alignment associated with this layout.
		*/
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign( value:String ):void
		{
			_horizontalAlign = value;
		}
		
		/**
		*	Vertical alignment associated with this layout.
		*/
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign( value:String ):void
		{
			_verticalAlign = value;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function added(
			child:DisplayObject,
			parent:DisplayObjectContainer,
			index:int ):void
		{
			dolayoutChild( child, parent, index );
				
			var next:Array = getNextDisplayObjects( parent, index );
			if( next.length > 0 )
			{
				layoutChildren( next, parent, index );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function removed(
			child:DisplayObject,
			parent:DisplayObjectContainer,
			index:int ):void
		{
			var next:Array = getNextDisplayObjects( parent, index > 0 ? index - 1 : index );
			
			//trace("Layout::removed(), index/numChildren/next/next length: ", index, parent.numChildren, next, next.length );
			
			if( next.length > 0 )
			{
				layoutChildren( next, parent, index + 1 );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function update( container:DisplayObjectContainer ):void
		{
			if( container != null
				&& container.numChildren > 0 )
			{
				var child:DisplayObject = null;
				for( var i:int = 0;i < container.numChildren;i++ )
				{
					child = container.getChildAt( i );
					dolayoutChild( child, container, i );
				}
				after( container );
			}
		}
		
		/**
		* 	Invoked after an update operation has completed.
		* 
		* 	Derived implementations can utilize this method
		* 	to perform post layout alignment operations.
		* 
		* 	@param container The container that was updated.
		*/
		protected function after( container:DisplayObjectContainer ):void
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
		public function get collapsed():Boolean
		{
			return _collapsed;
		}

		public function set collapsed( collapsed:Boolean ):void
		{
			_collapsed = collapsed;
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
			//TODO: remove debug
			//return 0;
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
			index:int,
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
			index:int ):DisplayObject
		{
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
			index:int ):DisplayObject
		{
			if( index < ( parent.numChildren - 1 ) )
			{
				return parent.getChildAt( index + 1 );
			}
			
			return null;
		}
		
		protected function layoutChildren(
			children:Array,
			parent:DisplayObjectContainer,
			index:int ):void
		{
			var child:DisplayObject = null;
			for( var i:int = 0;i < children.length;i++ )
			{
				child = DisplayObject( children[ i ] );
				dolayoutChild( child, parent, index );
			}
		}
		
		protected function getNextDisplayObjects(
			parent:DisplayObjectContainer, index:int ):Array
		{
			var output:Array = new Array();
			
			index++;
			
			for( ;index < parent.numChildren;index++ )
			{
				output.push( parent.getChildAt( index ) );
			}
			
			return output;
		}
		
		protected function getPreviousDisplayObjects(
			parent:DisplayObjectContainer, index:int ):Array
		{
			var output:Array = new Array();
			
			index--;
			
			for( ;index >= 0;index-- )
			{
				output.push( parent.getChildAt( index ) );
			}
			
			return output;
		}
		
		private function dolayoutChild(
			child:DisplayObject,
			parent:DisplayObjectContainer,
			index:int ):void
		{
			//we never layout fixed layout items
			if( child is IFixedLayout )
			{
				return;
			}
			
			var previous:DisplayObject = getPreviousDisplayObject(
				parent, index );

			//trace("Layout::dolayoutChild(), parent/child/previous ", parent, child, previous );
			
			if( previous )
			{
				
				/*
				trace("Layout::dolayoutChild(), ", previous.x, previous.y,
					previous.parent.getChildIndex( previous ) );
				*/
			}
			
			layoutChild(
				index,
				parent,
				child,
				previous );
		}
	}
}