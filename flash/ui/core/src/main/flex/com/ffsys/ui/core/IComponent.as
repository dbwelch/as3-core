package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.core.IBitmapGrab;
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.common.flash.ISprite;
	
	import com.ffsys.ui.data.IDataBinding;
	import com.ffsys.ui.data.IDataBindingNotification;
	import com.ffsys.ui.data.IDataBindingNotificationObserver;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.layout.ILayout;
	import com.ffsys.ui.layout.ILayoutWidth;
	import com.ffsys.ui.layout.ILayoutHeight;
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	
	import com.ffsys.ui.common.IStyleAware;
	
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
				IStyleAware,
				ILayoutWidth,
				ILayoutHeight,
				IMarginAware,
				IPaddingAware,
				IBitmapGrab,
				IDestroy,
				IEnabled,
				IDataBindingNotificationObserver,
				IStringIdentifier
	{
		
		/**
		* 	A data binding provider for this user interface component.
		*/
		function get dataBinding():IDataBinding;
		function set dataBinding( dataBinding:IDataBinding ):void;		
		
		/**
		* 	Gets the utility methods and properties available to all components.
		*/
		function get utils():IComponentViewUtils;
		
		/**
		*	The preferred width for the component.	
		*/
		function get preferredWidth():Number;
		function set preferredWidth( value:Number ):void;
		
		/**
		*	The preferred height for the component.	
		*/
		function get preferredHeight():Number;
		function set preferredHeight( value:Number ):void;		
		
		/**
		*	A minimum width for the component.
		*/
		function get minimumWidth():Number;
		function set minimumWidth( value:Number ):void;

		/**
		*	A minimum height for the component.
		*/
		function get minimumHeight():Number;
		function set minimumHeight( value:Number ):void;
		
		/**
		*	A maximum width for the component.
		*/
		function get maximumWidth():Number;
		function set maximumWidth( value:Number ):void;

		/**
		*	A maximum height for the component.
		*/
		function get maximumHeight():Number;
		function set maximumHeight( value:Number ):void;						
		
		/**
		* 	The text field factory used to create textfields.
		*/
		function get textFieldFactory():ITextFieldFactory;
	
		/**
		*	A border graphic for the component.
		*	
		*	A border component graphic is special in
		*	that it's depth is maintained at the top
		*	of the display hierarchy as child display
		*	objects are added to this component.
		*/
		function get border():IComponentGraphic;
		function set border( border:IComponentGraphic ):void;
	
		/**
		*	A background graphic for the component.
		*	
		*	A background component graphic is special in
		*	that it's depth is maintained at the bottom
		*	of the display hierarchy as child display
		*	objects are added to this component.
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
		*	Sets the size of this component.
		*	
		*	@param width The preferred width for the component.
		*	@param height The preferred height for the component.	
		*/
		function setSize(
			width:Number, height:Number ):void;
			
		/**
		* 	Forces a redraw of this component at the current preferred
		* 	dimensions.
		*/
		function redraw():void;
		
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
			
		/**
		* 	Gets a runtime instance by class.
		*	
		*	@param clazz The class of the instance.
		*	
		*	@return An instance of the class.
		*/
		function getRuntimeInstance( clazz:Class ):Object;			
	}
}