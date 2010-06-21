package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.core.IBitmapGrab;
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.common.flash.ISprite;
	
	import com.ffsys.ui.graphics.IComponentDraw;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.layout.ILayout;
	import com.ffsys.ui.layout.ILayoutWidth;
	import com.ffsys.ui.layout.ILayoutHeight;
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	
	/**
	*	Describes the contract for all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface IComponent
		extends ISprite,
				IComponentDraw,
				ILayoutWidth,
				ILayoutHeight,
				IMarginAware,
				IPaddingAware,
				IBitmapGrab,
				IDestroy,
				IEnabled,
				IStringIdentifier
	{
		
		/**
		*	The preferred width for the component.	
		*/
		function get preferredWidth():Number;
		function set preferredWidth( val:Number ):void;
		
		/**
		*	The preferred height for the component.	
		*/
		function get preferredHeight():Number;
		function set preferredHeight( val:Number ):void;		
		
		/**
		* 	The text field factory used to create textfields.
		*/
		function get textFieldFactory():ITextFieldFactory;
	
		/**
		*	A border graphic for the component.
		*/
		function get border():IComponentGraphic;
		function set border( border:IComponentGraphic ):void;
	
		/**
		*	A background graphic for the component.
		*/
		function get background():IComponentGraphic;
		function set background( background:IComponentGraphic ):void;
		
		/**
		* 	Extra custom data to associate with the component.
		*/
		function get extra():Object;
		function set extra( extra:Object ):void;
		
		/**
		*	Gets a rectangle that represents the inner
		*	area inside any padding settings.	
		*/
		function getPaddingRectangle():Rectangle;
		
		/**
		*	Gets a rectangle that represents the dimensions
		*	of this component.
		*/
		function getRectangle():Rectangle;	
		
		/**
		*	Gets a rectangle that represents the outer
		*	area outside any margin settings.
		*/
		function getMarginRectangle():Rectangle;
		
		/**
		* 	Gets a runtime asset by fully qualified class path.
		* 
		* 	The class referenced must have a no argument constructor.
		* 
		* 	@param classPath The fully qualified class path to the runtime
		* 	asset.
		* 
		* 	@return An instance of the class referenced by class path.
		*/
		function getRuntimeAsset(
			classPath:String ):Object;
		
		/**
		* 	Gets a runtime asset as a display object.
		* 
		* 	@param classPath The fully qualified class path to the runtime
		* 	asset.
		* 
		* 	@return An instance of the class referenced by class path as a
		* 	display object.
		*/
		function getRuntimeDisplayObject(
			classPath:String ):DisplayObject;
	}
}