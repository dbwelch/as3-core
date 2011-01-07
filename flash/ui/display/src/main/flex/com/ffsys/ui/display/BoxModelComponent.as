package com.ffsys.ui.display {
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.Graphic;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.RectangleGraphic;
	import com.ffsys.ui.graphics.Stroke;
	
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
		* 	dimensions.
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
			trace("BoxModelComponent::target()", this, this.id );
			if( _target != null )
			{								
				
				var parentComponent:IComponent = IComponent( _target );
				var rect:Rectangle = parentComponent.getRectangle();
				
				trace("BoxModelComponent::target()", component, content, outer, component.fill );
				trace("BoxModelComponent::target()", parentComponent, rect.width, rect.height );
				
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
				
				if( component != null )
				{
					component.tx = rect.x;
					component.ty = rect.x;
					component.draw( rect.width, rect.height );
				}

				rect = parentComponent.getPaddingRectangle();
				if( content != null )
				{
					content.tx = rect.x;
					content.ty = rect.x;
					content.draw( rect.width, rect.height );
				}
					
				rect = parentComponent.getMarginRectangle();
				if( outer != null )
				{
					outer.tx = rect.x;
					outer.ty = rect.x;
					outer.draw( rect.width, rect.height );
				}
				
		
				if( _outer != null
				 	&& !contains( DisplayObject( _outer ) ) )
				{
					addChild( DisplayObject( _outer ) );
				}
			
				if( _component != null
				 	&& !contains( DisplayObject( _component ) ) )
				{
					addChild( DisplayObject( _component ) );
				}
			
				if( _content != null
				 	&& !contains( DisplayObject( _content ) ) )
				{
					addChild( DisplayObject( _content ) );
				}				
			}	
		}
	}
}