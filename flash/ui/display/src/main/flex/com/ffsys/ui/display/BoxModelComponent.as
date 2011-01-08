package com.ffsys.ui.display {
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.Graphic;
	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.ui.layout.IFixedLayout;
	
	/**
	*	A utiity component that draws a rectangle
	*	for the bounds of a component around the outers,
	*	another rectangle around the object dimensions
	*	and the last around the padding.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class BoxModelComponent extends UIComponent
		implements IFixedLayout {
		
		private var _outer:IComponentGraphic;
		private var _component:IComponentGraphic;
		private var _content:IComponentGraphic;
		
		private var _target:IComponent;
		
		/**
		*	Creates a <code>BoxModelComponent</code> instance.
		*	
		*	@param outer A rectangle used to display the parent
		* 	component outer.
		*	@param component A rectangle used to display the parent component
		* 	dimensions.
		*	@param content A rectangle used to display the inner content
		* 	area of the parent component taking into account it's padding.
		*/
		public function BoxModelComponent(
			outer:IComponentGraphic = null,
			component:IComponentGraphic = null, 
			content:IComponentGraphic = null )
		{
			super();
			this.outer = outer;
			this.component = component;
			this.content = content;
		}
		
		/**
		*	A rectangle used to display the parent
		* 	component outer.	
		*/
		public function get outer():IComponentGraphic
		{
			return _outer;
		}
		
		public function set outer( outer:IComponentGraphic ):void
		{
			if( _outer != null && contains( DisplayObject( _outer ) ) )
			{
				removeChild( DisplayObject( _outer ) );
			}
			
			_outer = outer;
		}
		
		/**
		*	A rectangle used to display the component
		* 	content area.
		*/
		public function get component():IComponentGraphic
		{
			return _component;
		}

		public function set component( component:IComponentGraphic ):void
		{
			if( _component != null && contains( DisplayObject( _component ) ) )
			{
				removeChild( DisplayObject( _component ) );
			}
			
			_component = component;			
		}
		
		/**
		*	A rectangle used to display the inner content
		* 	area of a component taking into account it's padding.	
		*/
		public function get content():IComponentGraphic
		{
			return _content;
		}

		public function set content( content:IComponentGraphic ):void
		{
			if( _content != null && contains( DisplayObject( _content ) ) )
			{
				removeChild( DisplayObject( _content ) );
			}			
			
			_content = content;			
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get target():IComponent
		{
			return _target;
		}
		
		public function set target( value:IComponent ):void
		{
			_target = value;
			if( _target != null )
			{								
				
				var parentComponent:IComponent = IComponent( _target );
				var rect:Rectangle = parentComponent.dimensions.getRectangle();
				var borderGraphic:IBorderGraphic = null;
				
				var flush:Boolean = !parentComponent.margins.valid()
					&& !parentComponent.paddings.valid()
					&& !parentComponent.border.valid();
					
				trace("BoxModelComponent::target()", this, this.id, parentComponent, parentComponent.id, flush );													
					
				if( flush
					&& !isNaN( rect.width )
					&& !isNaN( rect.height ) )
				{
					var flushTarget:IComponentGraphic = ( outer != null ? outer : component );
					
					trace("BoxModelComponent::set target() DEAL WITH FLUSH BOX MODEL: ",
						flushTarget, parentComponent.id, rect.width, rect.height );
					
					if( flushTarget )
					{
						if( flushTarget is IBorderGraphic )
						{
							borderGraphic = IBorderGraphic( flushTarget );
							borderGraphic.border.top = 1;
							borderGraphic.border.right = 1;
							borderGraphic.border.bottom = 1;
							borderGraphic.border.left = 1;
						}
						
						trace("BoxModelComponent::set target() DRAWING FLUSH BOX MODEL: ", parentComponent.id, rect.x, rect.y, rect.width, rect.height );
						
						flushTarget.tx = rect.x;
						flushTarget.ty = rect.y;
						flushTarget.draw( rect.width, rect.height );
					}
				}else{
				
					trace("BoxModelComponent::set target() main rect: ", target, target.id, rect );
				
					//trace("BoxModelComponent::target()", component, content, outer, component.fill );
					//trace("BoxModelComponent::target()", parentComponent, rect.width, rect.height );
				
					if( numChildren > 1 )
					{
						if( contains( DisplayObject( content ) ) )
						{
							setChildIndex( DisplayObject( content ), 0 );
						}
					
						if( contains( DisplayObject( outer ) ) )
						{
							setChildIndex( DisplayObject( outer ), numChildren - 1 );
						}
					}
				
					if( component != null
						&& !isNaN( rect.width )
						&& !isNaN( rect.height ) )
					{
						trace(":::::::::::::::::::::::: BoxModelComponent::set target() DRAWING CONTENT AREA: ", target, target.id, rect );	
						
						component.tx = rect.x;
						component.ty = rect.y;
						component.draw( rect.width, rect.height );
					}

					rect = parentComponent.dimensions.getPaddingRectangle();
				
					trace("BoxModelComponent::set target() padding rect: ", target, target.id, rect );				
				
					if( content != null
						&& !isNaN( rect.width )
						&& !isNaN( rect.height ) )
					{	
						if( content is IBorderGraphic )
						{
							borderGraphic = IBorderGraphic( content );
							borderGraphic.border.top = parentComponent.paddings.top;
							borderGraphic.border.right = parentComponent.paddings.right;						
							borderGraphic.border.bottom = parentComponent.paddings.bottom;
							borderGraphic.border.left = parentComponent.paddings.left;
						}				
						content.tx = rect.x;
						content.ty = rect.y;
						content.draw( rect.width, rect.height );
					}
					
					rect = parentComponent.dimensions.getMarginRectangle();
				
					trace("BoxModelComponent::set target() margin rect: ", target, target.id, rect );
				
					if( outer != null
						&& !isNaN( rect.width )
						&& !isNaN( rect.height ) )
					{
						if( outer is IBorderGraphic )
						{
							borderGraphic = IBorderGraphic( outer );
							borderGraphic.border.top = parentComponent.margins.top;
							borderGraphic.border.right = parentComponent.margins.right;						
							borderGraphic.border.bottom = parentComponent.margins.bottom;
							borderGraphic.border.left = parentComponent.margins.left;
						}
					
						outer.tx = rect.x;
						outer.ty = rect.y;
						outer.draw( rect.width, rect.height );
					}
				
				}
		
				if( _outer != null
					&& _outer.width > 0
					&& _outer.height > 0
				 	&& !contains( DisplayObject( _outer ) ) )
				{
					addChild( DisplayObject( _outer ) );
				}
			
				if( _component != null
					&& _component.width > 0
					&& _component.height > 0
				 	&& !contains( DisplayObject( _component ) ) )
				{
					addChild( DisplayObject( _component ) );
				}
			
				if( _content != null
					&& _content.width > 0
					&& _content.height > 0
				 	&& !contains( DisplayObject( _content ) ) )
				{
					addChild( DisplayObject( _content ) );
				}				
			}	
		}
	}
}