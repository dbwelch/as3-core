package com.ffsys.ui.core
{	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.BlendMode;
	
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.skins.ComponentSkin;
	import com.ffsys.ui.skins.IComponentSkin;
	import com.ffsys.ui.skins.ISkinCollection;
	import com.ffsys.ui.skins.SkinCollection;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
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
		*	Adds the logic to set the disabled state for the component
		*	when not enabled. When enabled the main state is set by default.
		*/
		override public function set enabled( value:Boolean ):void
		{
			super.enabled = value;
			
			if( !this.enabled )
			{
				if( this.skin
					&& this.skin.hasState( State.DISABLED ) )
				{
					this.state = State.DISABLED;
				}
			}else{
				if( this.skin
					&& this.skin.hasState( State.MAIN ) )
				{
					this.state = State.MAIN;
				}
			}
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
			
			if( _state != state )
			{
				_state = state;
			
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
			}
		}
		
		public function get current():IViewState
		{
			return _current;
		}
		
		public function get main():IViewState
		{
			return this.skin.getStateById( State.MAIN );
		}
		
		/**
		*	Applies all styles for the current state.
		*	
		*	This method is automatically invoked when the state
		*	of the component is set.
		*/
		protected function applyStyles():void
		{
			applyGraphicStyles( preferredWidth, preferredHeight );
			applyAlpha();
			applyBlendMode();
		}
		
		/**
		*	Applies alpha properties for the current state.	
		*/
		protected function applyAlpha():void
		{
			if( current )
			{
				if( !isNaN( current.alpha ) )
				{
					this.alpha = current.alpha;
				}else{
					this.alpha = 1;
				}
			}
		}
		
		/**
		*	Applies the blend mode for the current state.
		*/
		protected function applyBlendMode():void
		{
			if( current )
			{
				if( current.blendMode )
				{
					this.blendMode = current.blendMode;
				}else{
					this.blendMode = BlendMode.NORMAL;
				}
			}
		}
		
		/**
		*	Applies the graphic styles for the current state.
		*/
		protected function applyGraphicStyles(
			width:Number = NaN,
			height:Number = NaN ):void
		{
			//trace("SkinAwareComponent::applyGraphicStyles(), current ", current );
			
			if( current )
			{
				var g:Vector.<IComponentGraphic> = current.graphics;
				if( g.length == 0 )
				{
					g = main.graphics;
				}
				
				var graphic:IComponentGraphic = null;
				for( var i:int = 0;i < g.length;i++ )
				{
					graphic = g[ i ];
				
					if( i < current.strokes.length )
					{
						graphic.stroke = current.strokes[ i ];
					}
				
					if( i < current.fills.length )
					{
						graphic.fill = current.fills[ i ];
						
						/*
						trace("SkinAwareComponent::applyGraphicStyles(), assigning fill:",
							graphic.fill );
						*/
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
					
					if( !isNaN( width ) )
					{
						graphic.preferredWidth = width;
					}
					
					if( !isNaN( height ) )
					{
						graphic.preferredHeight = height;
					}
					
					/*
					trace("SkinAwareComponent::applyGraphicStyles(), ",
						graphic.preferredWidth, graphic.preferredHeight );
					*/
					
					graphic.draw();
				}
			}
		}
		
		/**
		*	Creates the graphics from the current skin.
		*/
		protected function createGraphics():void
		{
			if( current )
			{
				var graphic:IComponentGraphic = null;
				for( var i:int = 0;i < current.graphics.length;i++ )
				{
					graphic = current.graphics[ i ];
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
			//set up the default disabled state
			var disabled:IViewState = new ViewState(
			 	State.DISABLED );
			disabled.alpha = .5;
			this.skin.addState( disabled );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function setSize(
			width:Number,
			height:Number ):void
		{
			super.setSize( width, height );
			applyStyles();
		}
	}
}