package org.flashx.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;	
	
	import org.flashx.ui.common.ISelectable;
	import org.flashx.ui.core.IComponent;	
	
	/**
	*	Abstract component group manager implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public class ComponentGroupManager extends EventDispatcher
		implements IComponentGroupManager
	{
		private var _id:String;
		private var _components:Vector.<IComponent>;
		private var _selectedIndex:int;
		
		/**
		* 	Creates a <code>ComponentGroupManager</code> instance.
		*/
		public function ComponentGroupManager()
		{
			super();
		}
		
		/**
		* 	An identifier for this group manager.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get components():Vector.<IComponent>
		{
			if( _components == null )
			{
				_components = new Vector.<IComponent>();
			}
			return _components;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasComponent( component:IComponent ):Boolean
		{
			return this.components.indexOf( component ) > -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function addComponent( component:IComponent ):Boolean
		{
			if( component != null
			 	&& !hasComponent( component ) )
			{
				this.components.push( component );
				
				if( component is ISelectable )
				{
					if( ISelectable( component ).selected )
					{
						this.selectedIndex = ( this.length - 1 );
					}
					component.addEventListener( MouseEvent.CLICK, childClick );	
				}
				
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeComponent( component:IComponent ):Boolean
		{
			if( component != null )
			{
				var index:int = this.components.indexOf( component );
				if( index > -1 )
				{
					this.components.splice( index, 1 );
					component.removeEventListener( MouseEvent.CLICK, childClick );
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return this.components.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get selectedItem():DisplayObject
		{
			if( this.selectedIndex >= 0
				&& this.selectedIndex < this.components.length )
			{
				return this.components[ this.selectedIndex ] as DisplayObject;
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set selectedItem( item:DisplayObject ):void
		{
			if( item != null )
			{
				var index:int = this.components.indexOf( item );							
				if( index > -1 )
				{
					this.selectedIndex = index;
				}
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
			}else if(
				index != _selectedIndex
				&& index >= 0
				&& index < components.length )
			{
				//deal with an existing selection
				var selected:DisplayObject = this.selectedItem;
				if( selected != null
					&& ( selected is ISelectable ) )
				{
					ISelectable( selected ).selected = false;
				}
				
				_selectedIndex = index;
				
				selected = this.selectedItem;
				
				//trace("ComponentGroupManager::set selectedIndex()", index, child, ( child is ISelectable ) );
				
				if( selected is ISelectable )
				{
					ISelectable( selected ).selected = true;
				}
				
				//TODO: re-implement
				//dispatchEvent( new SelectionEvent( SelectionEvent.CHANGED ) );
			}
		}
		
		/**
		* 	@private
		*/
		protected function childClick( event:MouseEvent ):void
		{
			if( event.target != null
			 	&& event.target is IComponent )
			{
				var index:int = this.components.indexOf( event.target );
				this.selectedIndex = index;
			}
		}
	}
}