package org.flashx.ui.containers
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.flashx.ui.layout.HorizontalLayout;
	import org.flashx.ui.common.ISelectable;
	import org.flashx.ui.events.SelectionEvent;
	
	/**
	*	Represents a container for menu tabs.
	* 
	*	The default behaviour is to lay out children
	* 	horizontally, you can assign a vertical layout
	* 	if you need tabs laid out in a vertical manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	dynamic public class TabContainer extends Container
		implements ISelectableContainer
	{
		private var _selectedIndex:int = -1;
		
		/**
		* 	Creates a <code>TabContainer</code> instance.
		*/
		public function TabContainer()
		{
			super();
			this.layout = new HorizontalLayout();
		}
		
		/**
		* 	Selects the first child.
		*/
		public function first():void
		{
			if( numChildren > 0 )
			{
				this.selectedIndex = 0;
			}
		}
		
		/**
		* 	Selects the last child.
		*/
		public function last():void
		{
			if( numChildren > 0 )
			{
				this.selectedIndex = numChildren - 1;
			}
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get selectedItem():DisplayObject
		{
			if( this.selectedIndex >= 0 && this.selectedIndex < numChildren )
			{
				return this.getChildAt( this.selectedIndex );
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set selectedItem( item:DisplayObject ):void
		{
			if( item && contains( item ) )
			{
				var index:int = this.getChildIndex( item );
				this.selectedIndex = index;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set selectedIndex( index:int ):void
		{
			if( index == -1 )
			{
				_selectedIndex = index;
			}else if( index != _selectedIndex && index >= 0 && index < numChildren )
			{
				if( this.selectedItem
					&& ( this.selectedItem is ISelectable ) )
				{
					ISelectable( this.selectedItem ).selected = false;
				}
				
				_selectedIndex = index;
				
				var child:DisplayObject = this.selectedItem;
				
				//trace("TabContainer::set selectedIndex()", index, child, ( child is ISelectable ) );
				
				if( child is ISelectable )
				{
					ISelectable( child ).selected = true;
				}
				
				dispatchEvent( new SelectionEvent( SelectionEvent.CHANGED ) );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function afterChildAdded(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildAdded( child, index );

			if( child && ( child is ISelectable ) && enabled )
			{
				child.addEventListener( MouseEvent.CLICK, childClick );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function beforeChildRemoved(
			child:DisplayObject,
			index:int ):Boolean
		{
			if( child && ( child is ISelectable ) )
			{
				child.removeEventListener( MouseEvent.CLICK, childClick );
			}
			
			//constrain the selected index as children are removed
			if( _selectedIndex >= numChildren )
			{
				this.selectedIndex = numChildren - 1;
			}
			
			return super.beforeChildRemoved( child, index );
		}
			
		/**
		* 	@private
		*/
		protected function childClick( event:MouseEvent ):void
		{
			if( event.target
				&& contains( DisplayObject( event.target ) ) )
			{
				this.selectedIndex = this.getChildIndex(
					DisplayObject( event.target ) );
			}
		}
	}
}