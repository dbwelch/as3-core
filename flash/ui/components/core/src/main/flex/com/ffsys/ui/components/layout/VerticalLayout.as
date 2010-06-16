package com.ffsys.ui.components.layout
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.components.core.IComponent;
	

	/**
	*	Handles laying out components in a vertical
	*	manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class VerticalLayout extends AbstractLayout
	{	
		/**
		* 	Creates a <code>VerticalLayout</code> instance.
		*/
		public function VerticalLayout()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function added( child:DisplayObject ):void
		{
			//TODO
			trace("VerticalLayout::added(), ", child, child.parent );
			
			var y:Number = 0;
			
			var previous:DisplayObject = getPreviousDisplayObject(
				child.parent, child );
				
			if( previous )
			{
				y = previous.y + previous.height;
			}
			
			if( child is IComponent )
			{
				var component:IComponent = IComponent( child );
				trace("VerticalLayout::added(), component: ", component );
				
				//TODO: add style additions here
			}
			
			child.y = y;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function removed( child:DisplayObject ):void
		{
			//TODO
			trace("VerticalLayout::removed(), ", child, child.parent );
			
			if( child is IComponent )
			{
				var component:IComponent = IComponent( child );
				trace("VerticalLayout::removed(), component: ", component );
			}			
		}
	}
}