package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.geom.*;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.layout.*;
	
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
	public class Container extends UIComponent
		implements IContainer {
		
		public static const INLINE:String = "inline";
		public static const BLOCK:String = "block";
		
		private var _layout:ILayout;
		private var _finalized:Boolean = false;
		private var _display:String;
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
		public function get display():String
		{
			return _display;
		}
		
		public function set display( value:String ):void
		{
			_display = value;
			
			if( _display != null )
			{
				switch( _display )
				{
					case INLINE:
						layout = new HorizontalLayout( this.spacing );
						break;
					case BLOCK:
						layout = new VerticalLayout( this.spacing );
						break;
					default:
						throw new Error( "Unknown container display property '" + _display + "'." );
				}
				
				if( numChildren > 0 )
				{
					update();
				}
			}
		}
		
		override public function measure():IComponentDimensions
		{	
			var output:IComponentDimensions = super.measure();
			
			trace("*************************** STARTING Container::measure() ***************************");
			trace("Container::measure() this/id: ", this, this.id );
			
			trace("Container::measure() CHECKING EXPLICIT DIMENSIONS: ", this, this.id, output.hasExplicitWidth(), output.hasExplicitHeight(), output );
			
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
			
			trace("Container::measure() width/ width > 0:", this, this.id, this.width, this.width > 0 );
			
			if( this.width > 0
				&& !output.hasExplicitWidth() )
			{
				output.preferredWidth = this.width + paddings.width + border.width;
			}
			
			//TODO: handle percentage values here
			
			trace("Container::measure() height/ height > 0:", this, this.id, this.height, this.height > 0 );
			
			if( this.height > 0
				&& !output.hasExplicitHeight() )
			{
				output.preferredHeight = this.height + paddings.height + border.height;
			}
			
			//still no valid dimensions try looking in the hierarchy
			if( isNaN( output.preferredWidth )
				|| isNaN( output.preferredHeight ) )
			{

				
				var parent:IContainer = getAncestorByType( IContainer ) as IContainer;
				
				trace("Container::measure()", "STILL NO VALID DIMENSONS SEARCHING PARENT CONTAINER: ", parent );				
				
				if( parent != null )
				{
					if( !isNaN( parent.dimensions.preferredWidth ) )
					{
						output.preferredWidth = parent.innerWidth - margins.width;
					}
					
					if( !isNaN( parent.dimensions.preferredHeight ) )
					{
						output.preferredHeight = parent.innerHeight - margins.height;
					}
				}
			}
			
			if( isNaN( output.preferredWidth ) )
			{
				trace( "[WARNING] Could not determine width of component '"
					+ this + "' with id '" + this.id + "', setting to 16 pixels" );
				output.preferredWidth = 16;
			}
			
			if( isNaN( output.preferredHeight ) )
			{
				trace( "[WARNING] Could not determine height of component '"
					+ this + "' with id '" + this.id + "', setting to 16 pixels" );
				output.preferredHeight = 16;
			}
			
			trace("*************************** FINISHED Container::measure() ***************************");			
			
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		override public function get preferredWidth():Number
		{
			//explicitly set
			if( !isNaN( _preferredWidth ) )
			{
				return _preferredWidth;
			}			
			//got some width content
			if( this.width > 0 )
			{
				//flex container dimensions to child size
				return this.width + paddings.width + border.width;
			}
			
			//try parent hierarchy lookup
			var parent:IContainer = getAncestorByType( IContainer ) as IContainer;
			if( parent != null
				&& !isNaN( parent.preferredWidth ) )
			{
				//trace("Container::get preferredWidth() FOUND PARENT DIMENSION:", this.id, parent.id, parent, parent.innerWidth, margins.width, parent.paddings.width );
				//
				return ( parent.innerWidth / parent.numChildren ) - margins.width;
			}
			return super.preferredWidth;
		}
		*/
		
		/**
		* 	@inheritDoc
		*/
		
		/*
		override public function get preferredHeight():Number
		{
			//explicitly set
			if( !isNaN( _preferredHeight ) )
			{
				return _preferredHeight;
			}
			
			//got some height content
			if( this.height > 0 )
			{
				//flex container dimensions to child size
				return this.height + paddings.height + border.height;
			}
			
			//try parent hierarchy lookup			
			var parent:IContainer = getAncestorByType( IContainer ) as IContainer;
			if( parent != null
				&& !isNaN( parent.preferredHeight ) )
			{
				return parent.innerHeight - margins.height;
			}
			
			return super.preferredHeight;
		}
		*/
		
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
			 	&& cache.main != null
				&& cache.main.spacing is Number )
			{
				this.spacing = Number( cache.main.spacing );
			}
			
			//trace("Container::doWithStyleCache()", this, layout, this.parent, cache, cache.main, cache.main.spacing, this.spacing );
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
		
		/**
		*	@inheritDoc	
		*/
		override protected function afterChildAdded(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildAdded( child, index );
			if( layout && child && _finalized )
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
			if( layout && child && _finalized )
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
			if( layout == null )
			{
				layout = new VerticalLayout();
			}

			if( this.id != null )
			{
				trace("Container::update()",
					this,
					this.id,
					this.layout,
					dimensions.hasExplicitWidth(),
					dimensions.hasExplicitHeight() );
			}
			
			//trace("Container::update() UPDATING: ", this, this.id, this.layout );			
			//measureChildDimensions();
			layout.update( this );
		}
		
		/**
		* 	@private
		*/
		//TODO: move to the layout manager
		protected function measureChildDimensions():void
		{
			var child:DisplayObject = null;
			var component:IComponent = null;
			for each( child in children )
			{
				if( child is IComponent )
				{
					component = IComponent( child );
					
					if( layout is VerticalLayout )
					{
						if( component.dimensions.hasExplicitWidth() )
						{
							//force the component to use it's looked up dimensions
							component.width = this.innerWidth;
						}
						if( component.dimensions.hasExplicitHeight() )
						{
							component.height = component.preferredHeight;
						}
					}else if( layout is HorizontalLayout )
					{
						if( component.dimensions.hasExplicitWidth() )
						{
							//force the component to use it's looked up dimensions
							component.width = component.preferredWidth;
						}
						if( component.dimensions.hasExplicitHeight() )
						{
							component.height = this.innerHeight;
						}
					}
					
					/*
					trace("Container::measureChildDimensions()",
						component, component.id, component.hasExplicitWidth(), component.hasExplicitHeight() );
					*/
				}
			}
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
		override public function finalized():void
		{
			super.finalized();
			_finalized = true;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_layout = null;
			_display = null;
		}
	}
}