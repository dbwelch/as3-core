package com.ffsys.ui.core
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import com.ffsys.ui.common.*;

	/**
	*	Represents the dimensions of a component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public class ComponentDimensions extends Dimensions
		implements IComponentDimensions
	{
		/**
		* 	Creates a ComponentDimensions instance.
		* 
		* 	@param left The left offset.
		* 	@param top The top offset.
		* 	@param width A width value.
		* 	@param height A height value.
		*/
		public function ComponentDimensions(
			left:Number = 0,
			top:Number = 0,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( left, top, width, height );
		}		
		
		/**
		* 	Measures the dimension of a component.
		* 
		* 	@param w The preferred width for the component.
		* 	@param h The preferred height for the component.
		* 	@param component The component being measured.
		* 
		* 	@return This component dimensions updated to reflect
		* 	the measurement changes.
		*/
		public function measure(
			w:Number,
			h:Number,
			component:IComponent ):IComponentDimensions
		{
			//force explicit dimension overrides
			if( hasExplicitWidth() )
			{
				w = this.width;
			}
			if( hasExplicitHeight() )
			{
				h = this.height;
			}
			
			var output:IComponentDimensions = IComponentDimensions(
				calculate( preferredWidth, preferredHeight ) );
				
			//completely explicit dimensions
			//no further calculation necessary
			if( hasExplicitWidth()
			 	&& hasExplicitHeight() )
			{
				return output;
			}
			
			/*
			if( component != null )
			{
				var measured:IDimensions = getMeasuredComponentDimensions(
					w, h, component );
					
				trace("ComponentDimensions::measure()", preferredWidth, preferredHeight, measured );
				//
				//preferredWidth = Rectangle( output ).width;
				//preferredHeight = Rectangle( output ).height;	
				
				//trace("ComponentDimensions::measure()", preferredWidth, preferredHeight );
				
				//TODO: calculate percentage values
			
				//TODO: constrain calculated values
			}
			*/
			return output;
		}
		
		/**
		* 	@private
		*/
		private function getMeasuredComponentDimensions(
			w:Number,
			h:Number,
			component:IComponent ):IComponentDimensions
		{
			var dimensions:IComponentDimensions = 
				IComponentDimensions( clone() );
				
			var requiresWidth:Boolean = isNaN( w );
			var requiresHeight:Boolean = isNaN( h );
			
			var parents:Vector.<DisplayObjectContainer> = component.parents;
			var ancestors:Vector.<IComponent> = component.ancestors.reverse();
			var ancestor:IComponent = null;
			for( var i:int; i < ancestors.length;i++ )
			{
				ancestor = ancestors[ i ];
				//retrieves some dimensions
				if( !requiresWidth
					&& !requiresHeight )
				{
					break
				}
				
				if( ancestor != null )
				{
					if( requiresWidth )
					{
						if( ancestor.dimensions.hasExplicitWidth() )
						{
							//TODO: make it the inner dimensions				
							w = Rectangle( ancestor.dimensions ).width;
						}
					}
					
					if( requiresHeight )
					{
						if( ancestor.dimensions.hasExplicitHeight() )
						{
							//TODO: make it the inner dimensions
							h = Rectangle( ancestor.dimensions ).height;
						}
					}
					
					requiresWidth = isNaN( w );
					requiresHeight = isNaN( h );
				}
			}
			
			//update the output
			Rectangle( dimensions ).width = w;
			Rectangle( dimensions ).height = h;
			
			return dimensions;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return ComponentDimensions;
		}		
	}
}