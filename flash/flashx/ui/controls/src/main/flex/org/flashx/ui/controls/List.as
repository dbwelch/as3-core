package org.flashx.ui.controls
{
	import flash.display.DisplayObject;
	
	import org.flashx.ui.data.*;
	import org.flashx.ui.containers.Canvas;
	import org.flashx.ui.layout.VerticalLayout;
	
	/**
	*	Represents a list of items.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class List extends Canvas
	{
		private var _itemRendererClass:Class =
			DefaultListItemRenderer;
		
		/**
		* 	Creates a <code>List</code> instance.
		*/
		public function List()
		{
			super();
			this.layout = new VerticalLayout();
		}
		
		/**
		* 	
		*/
		override protected function createChildren():void
		{
			renderListItems();
		}
		
		/**
		* 	@private
		*/
		private function renderListItems():void
		{
			if( this.dataBinding
				&& ( this.dataBinding is IDataBindingCollection ) )
			{
				var collection:IDataBindingCollection = IDataBindingCollection( this.dataBinding );
				var children:Vector.<IDataBinding> = collection.children;
				var renderer:IItemRenderer = null;
				for( var i:int = 0;i < children.length;i++ )
				{
					renderer = getItemRenderer();
					renderer.dataBinding = children[ i ];
					addChild( DisplayObject( renderer ) );
				}
			}
		}
		
		protected function getItemRenderer():IItemRenderer
		{
			var instance:IItemRenderer = null;
			var clazz:Class = itemRendererClass;
			
			if( clazz == null )
			{
				throw new Error( "Cannot instantiate an item renderer with a null renderer class." );
			}
			
			try
			{
				instance = new clazz();
			}catch( e:Error )
			{
				throw e;
			}
			
			if( instance && !(instance is IItemRenderer) )
			{
				throw new Error( "The item renderer class does not adhere to the item renderer contract." );
			}
			
			return IItemRenderer( instance );
		}
		
		public function get itemRendererClass():Class
		{
			return _itemRendererClass;
		}
		
		public function set itemRendererClass( value:Class ):void
		{
			_itemRendererClass = value;
		}
	}
}