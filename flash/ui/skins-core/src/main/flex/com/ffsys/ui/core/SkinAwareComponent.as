package com.ffsys.ui.core
{	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.skins.ComponentSkin;
	import com.ffsys.ui.skins.IComponentSkin;
	import com.ffsys.ui.skins.ISkinCollection;
	import com.ffsys.ui.skins.SkinCollection;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.State;

	/**
	*	Represents a component that is aware of an associated skin.
	* 
	* 	Components that do not have a visual display (for example, some containers)
	* 	should extend <code>UIComponent</code> while components that
	* 	require a visual display should extend this class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class SkinAwareComponent extends InteractiveComponent
		implements ISkinAwareComponent
	{
		static private var _skins:ISkinCollection = new SkinCollection();
		private var _skin:IComponentSkin = new ComponentSkin();
		private var _state:String;
		private var _current:IViewState;
		private var _graphicsLayer:IComponent;
		
		/**
		* 	Creates an <code>SkinAwareComponent</code> instance.
		*/
		public function SkinAwareComponent()
		{
			super();
			configureDefaultSkin();
			_graphicsLayer = new UIComponent();
			addChild( DisplayObject( _graphicsLayer ) );
		}
		
		/**
		*	The component layer that skin graphics
		*	are drawn in.
		*/
		public function get graphicsLayer():IComponent
		{
			return _graphicsLayer;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function createChildren():void 
		{
			trace("SkinAwareComponent::createChildren(), ", "CREATING CHILDREN", this );
			if( this.skin && this.skin.hasState( State.MAIN ) )
			{
				this.state = State.MAIN;
				createGraphics();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get skins():ISkinCollection
		{
			return _skins;
		}
		
		/**
		* 	The skin associated with this component.
		*/
		public function get skin():IComponentSkin
		{
			return _skin;
		}
		
		public function set skin( skin:IComponentSkin ):void
		{
			_skin = skin;
		}	
		
		/**
		*	The current state of the skin.
		*/
		public function get state():String
		{
			return _state;
		}
		
		public function set state( state:String ):void
		{
			if( !this.skin )
			{
				throw new Error( "Cannot set a skin aware component state with no skin." );
			}
			
			_state = state;
			
			trace("SkinAwareComponent::set stae(), ", this.state );
			
			if( this.state )
			{
				var current:IViewState = this.skin.getStateById(
					this.state );

				if( !current )
				{
					throw new Error( "Could not locate a skin state for '"
						+ this.state + "'." );
				}
				
				_current = current;
				
				applyStyles();
			}
			
			//TOOD:investigate resetting to main when state is null
		}
		
		public function get current():IViewState
		{
			return _current;
		}
		
		/**
		*	Applies all styles for the current state.
		*	
		*	This method is automatically invoked when the state
		*	of the component is set.
		*/
		protected function applyStyles():void
		{
			applyGraphicStyles();
		}
		
		/**
		*	Applies the graphic styles for the current state.
		*/
		protected function applyGraphicStyles():void
		{
			if( current )
			{
				var graphic:IComponentGraphic = null;
				for( var i:int = 0;i < current.graphics.length;i++ )
				{
					graphic = current.graphics[ i ];
				
					if( i < current.strokes.length )
					{
						graphic.stroke = current.strokes[ i ];
					}
				
					if( i < current.fills.length )
					{
						graphic.fill = current.fills[ i ];
					}
					
					if( isNaN( graphic.preferredWidth )
					 	|| graphic.preferredWidth == 0 )
					{
						graphic.preferredWidth = this.preferredWidth;
					}
					
					if( isNaN( graphic.preferredHeight )
					 	|| graphic.preferredHeight == 0 )
					{
						graphic.preferredHeight = this.preferredHeight;
					}
					
					trace("SkinAwareComponent::applyGraphicStyles(), ",
						graphic.preferredWidth, graphic.preferredHeight );
				
					graphic.draw();
					
					/*
					if( !graphicsLayer.contains( DisplayObject( graphic ) ) )
					{
						graphicsLayer.addChild( DisplayObject( graphic ) );
					}
					*/
				}
			}
		}
		
		/**
		*	Creates the graphics from the current skin.
		*/
		protected function createGraphics():void
		{
			trace("SkinAwareComponent::createGraphics(), ", current );
			if( current )
			{
				
				var graphic:IComponentGraphic = null;
				for( var i:int = 0;i < current.graphics.length;i++ )
				{
					graphic = current.graphics[ i ];
					trace("SkinAwareComponent::adding graphic(), ", graphic );
					DisplayObjectContainer( graphicsLayer ).addChild(
						DisplayObject( graphic ) );
				}
			}
		}
		
		/**
		*	Configures the default skin for the component.	
		*/
		protected function configureDefaultSkin():void
		{
			//
		}		
	}
}