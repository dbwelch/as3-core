package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.css.ICssProperty;
	
	/**
	*	A container for a graphic that adds the ability
	*	for the graphic to be interactive and to work
	*	with some containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class Graphic extends InteractiveComponent
		implements IGraphic, ICssProperty
	{
		private var _graphic:IComponentGraphic;
		
		/**
		* 	Creates a <code>Graphic</code> instance.
		* 
		* 	@param graphic The graphical shape.
		*/
		public function Graphic( graphic:IComponentGraphic = null )
		{
			super();
			this.interactive = false;
			if( graphic )
			{
				this.graphic = graphic;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldSetCssProperty( name:String, value:* ):Boolean
		{
			return ( value is IComponentGraphic );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setCssProperty( name:String, value:* ):void
		{
			this.graphic = IComponentGraphic( value );
		}
		
		/**
		*	The graphic for this component.
		*/
		public function get graphic():IComponentGraphic
		{
			return _graphic;
		}
		
		public function set graphic( graphic:IComponentGraphic ):void
		{
			if( this.graphic && this.contains( DisplayObject( graphic ) ) )
			{
				this.removeChild( DisplayObject( graphic ) );
			}
			
			_graphic = graphic;
			
			if( this.graphic )
			{
				if( isNaN( this.graphic.preferredWidth ) )
				{
					this.graphic.preferredWidth = preferredWidth;
				}
				
				if( isNaN( this.graphic.preferredHeight ) )
				{
					this.graphic.preferredHeight = preferredHeight;
				}
				
				addChild( DisplayObject( this.graphic ) );
			}
		}
		
		/**
		* 	Proxies drawing to the encapsulated graphic
		*	if it exists.
		*
		*	@param width The width of the graphic.
		*	@param height The height of the graphic.
		*/
		public function draw(
			width:Number = NaN, height:Number = NaN ):void
		{
			if( graphic )
			{
				graphic.draw( width, height );
			}
		}
		
		/**
		* 	Custom style application logic.
		* 
		* 	This method inspects the style objects that would be applied
		* 	searching for a style that is an <code>IComponentGraphic</code>
		* 	implementation and adds it as a child if it corresponds to a valid
		* 	graphic implementation.
		* 
		* 	Only one graphic may be assigned at any one time so the rule is that
		* 	the first located style declaration will be used.
		* 
		* 	As the order of style application may vary this could result in unexpected
		* 	behaviour. To prevent this, only ever apply a single graphic style declaration
		* 	to this component.
		*/
		override public function applyStyles():void
		{
			if( styleManager )
			{
				var styleNames:Array = styleManager.getStyleNameList( this );
				var styles:Array = styleManager.getStyleObjects( this );
				var style:Object = null;
				for( var i:int = 0;i < styles.length;i++ )
				{
					style = styles[ i ];
					if( style is IComponentGraphic )
					{
						this.graphic = IComponentGraphic( style );
						break;
					}
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number,
			height:Number ):void
		{
			draw( width, height );
		}
	}
}