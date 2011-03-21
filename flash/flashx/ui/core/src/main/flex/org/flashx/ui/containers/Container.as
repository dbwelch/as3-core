package org.flashx.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.geom.*;
	
	import org.flashx.ioc.*;
	
	import org.flashx.core.IClone;
	
	import org.flashx.ui.core.*;
	import org.flashx.ui.common.*;	
	import org.flashx.ui.layout.*;
	
	/**
	*	Component implementation that is aware of a layout,
	*	this is the super class for all containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	dynamic public class Container extends InteractiveComponent
		implements IContainer {
		
		private var _layout:ILayout;
		private var _spacing:Number = 0;
		
		/**
		*	Creates a <code>Container</code> instance.
		*/
		public function Container()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function measure():IComponentDimensions
		{	
			var output:IComponentDimensions = super.measure();
			
			//trace("*************************** STARTING Container::measure() ***************************");
			//trace("Container::measure() this/id: ", this, this.id );
			
			/*
			var debug:Boolean = id == "main-navigation";
			if( debug )
			{			
			trace("Container::measure() CHECKING EXPLICIT DIMENSIONS: ", this, this.id, output.hasExplicitWidth(), output.hasExplicitHeight(), output );
			}
			*/
			
			if( output.hasExplicitWidth() )
			{
				output.preferredWidth =
					Rectangle( dimensions ).width;
			}
			
			if( output.hasExplicitHeight() )
			{
				output.preferredHeight =
					Rectangle( dimensions ).width;
			}
			
			//nothing more to do fully explicit dimensions
			if( output.hasExplicitWidth()
				&& output.hasExplicitHeight() )
			{
				return output;
			}
		
			//default measured sizes
			if( this.width > 0
				&& !output.hasExplicitWidth() )
			{
				output.preferredWidth = this.width + paddings.width + border.width;
			}

			if( this.height > 0
				&& !output.hasExplicitHeight() )
			{
				output.preferredHeight = this.height + paddings.height + border.height;
			}
			
			//still no valid dimensions try looking in the hierarchy
			if( isNaN( output.preferredWidth )
				|| isNaN( output.preferredHeight ) )
			{
				var ancestors:Vector.<IComponent> = this.ancestors;
				var p:IComponent = null;
				
				trace("Container::measure() SEARCHING PARENT HIERARCHY", this, this.id );
				
				//look in reverse up the hierarchy first
				ancestors.reverse();
				for each( p in ancestors )
				{
					if( !isNaN( output.preferredWidth ) && !isNaN( output.preferredHeight ) )
					{
						break;
					}
					
					if( isNaN( output.preferredWidth ) )
					{
						//percent dimensions
						if( dimensions.hasPercentWidth() )
						{
							if( p.dimensions.hasExplicitWidth()
								|| p.dimensions.measuredWidth > 0 )
							{
								trace("Container::measure()", "FIND PERCENT WIDTH: ", dimensions.percentWidth );
								output.preferredWidth = p.dimensions.innerWidth * ( dimensions.percentWidth / 100 );
							}
						//inherited dimensions
						}else if( p.dimensions.hasExplicitWidth() )
						{
							output.preferredWidth = p.dimensions.innerWidth;
							trace("Container::measure()", "FOUND PARENT EXPLICIT WIDTH: ", output.preferredWidth );
						}						
					}
					
					
					if( isNaN( output.preferredHeight ) )
					{
						//percent dimensions						
						if( dimensions.hasPercentHeight() )
						{
							if( p.dimensions.hasExplicitHeight()
								|| p.dimensions.measuredHeight > 0 )
							{							
								trace("Container::measure()", "FIND PERCENT HEIGHT: ", dimensions.percentWidth );							
								output.preferredHeight = p.dimensions.innerHeight * ( dimensions.percentHeight / 100 );	
							}
						//inherited dimensions												
						}else if( p.dimensions.hasExplicitHeight() )
						{
							output.preferredHeight = p.dimensions.innerHeight;
							trace("Container::measure()", "FOUND PARENT EXPLICIT HEIGHT: ", output.preferredHeight );
						}
					}	
					
				}
				
				//bubble back down the hierarchy for inner dimensions
				//overwriting as we go
				if( isNaN( output.preferredWidth )
					|| isNaN( output.preferredHeight ) )
				{
					ancestors.reverse();
					for each( p in ancestors )
					{
						/*
						if( !isNaN( output.preferredWidth )
							&& !isNaN( output.preferredHeight ) )
						{
							break;
						}
						*/

						//output.preferredWidth = Rectangle( p.dimensions ).width;
						//output.preferredHeight = Rectangle( p.dimensions ).height;
						
						//output.preferredWidth = p.dimensions.innerWidth;
						//output.preferredHeight = p.dimensions.innerHeight;						
					}					
				}
			}
			
			//if(debug) trace("Container::measure() width/ width > 0:", this, this.id, dimensions.measuredWidth, dimensions.measuredWidth > 0 );
			
			if( isNaN( output.preferredWidth ) )
			{
				var dw:Number = 16;
				if( stage )
				{
					dw = stage.stageWidth;
				}
				trace( "[WARNING] Could not determine width of component '"
					+ this + "' with id '" + this.id + "', setting to " + dw + " pixels" );
				output.preferredWidth = dw;
			}
			
			if( isNaN( output.preferredHeight ) )
			{
				var dh:Number = 16;
				if( stage )
				{
					dh = stage.stageWidth;
				}
				trace( "[WARNING] Could not determine height of component '"
					+ this + "' with id '" + this.id + "', setting to " + dh + " pixels" );
				output.preferredHeight = dh;
			}
			
			//trace("Container::measure() FINAL PREFERRED DIMENSIONS: ", output.preferredWidth, output.preferredHeight );
			//trace("*************************** FINISHED Container::measure() ***************************");
			
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get layout():ILayout
		{
			return _layout;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set layout( layout:ILayout ):void
		{
			_layout = layout;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function doWithStyleCache(
			cache:IComponentStyleCache ):void
		{
			super.doWithStyleCache( cache );
			if( cache != null
			 	&& cache.source != null
				&& cache.source.spacing is Number )
			{
				this.spacing = Number( cache.source.spacing );
			}
		}
		
		/**
		*	The spacing for this container layout.
		*/
		public function get spacing():Number
		{
			return _spacing;
		}
		
		public function set spacing( spacing:Number ):void
		{
			_spacing = spacing;
			if( layout )
			{
				layout.spacing = this.spacing;
			}			
		}
		
		/**
		* 	@private
		*/
		override public function afterProperties(
			descriptor:IBeanDescriptor ):void
		{
			super.afterProperties( descriptor );
			if( layout )
			{
				layout.spacing = this.spacing;
			}
			//trace("UIComponent::afterProperties()", this, descriptor );
		}
		
		public var divider:DisplayObject;
		
		/**
		*	@inheritDoc
		*/
		
		/*
		override protected function beforeChildAdded(
			child:DisplayObject, index:int ):Boolean
		{
			var output:Boolean = super.beforeChildAdded( child, index );

			
			return output;
		}
		*/
		
		/**
		*	@inheritDoc	
		*/
		override protected function afterChildAdded(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildAdded( child, index );
			
			/*
			if( divider != null )
			{
				trace("::::::::::::::::::::::::::: Container::beforeChildAdded() FOUND A DIVIDER TO DUPLCIATE");
			
				var duplicate:DisplayObject = null;
			
				if( divider is IClone
				 	&& Object( divider ).clone is Function )
				{
					duplicate = DisplayObject( Object( divider ).clone() );
				}else
				{
					addChild( divider );
					duplicate = getBitmap( divider );
					removeChild( divider );
				}
			
				trace("::::::::::::::::::::::::::: Container::beforeChildAdded() GOT DUPLCIATE", duplicate);
			
				if( duplicate != null )
				{
					addChild( duplicate );
				}
			}			
			*/
			
			if( layout && child && isFinalized() )
			{
				layout.added( child, this, index );
				//TODO: update here for alignment
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function afterChildRemoved(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildRemoved( child, index );
			if( layout && child && isFinalized() )
			{
				layout.removed( child, this, index );
				//TODO: update here for alignment
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function update():void
		{
			if( layout != null )
			{
				layout.update( this );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getBorderDimensions():Rectangle
		{
			return dimensions.getBorderRectangle();
		}		
		
		/**
		* 	@inheritDoc
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			update();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_layout = null;
		}
	}
}