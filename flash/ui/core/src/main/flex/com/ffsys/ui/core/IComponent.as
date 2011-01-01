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

	import com.ffsys.ui.css.IStyleManagerAware;	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.layout.ILayout;
	import com.ffsys.ui.layout.ILayoutWidth;
	import com.ffsys.ui.layout.ILayoutHeight;
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.ioc.IBeanDocumentAware;	
	import com.ffsys.ioc.IBeanFinalized;
	
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
				IStyleManagerAware,
				IBeanFinalized,
				IBeanDocumentAware,
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
		* 	The current state of this component.
		*/
		function get state():State;
		function set state( value:State ):void;
		
		/**
		* 	Sets the state of the component and forces
		* 	a redraw using the styles associated with the
		* 	state.
		* 
		* 	@param state The state for this component.
		*/
		function setState( state:State ):void;
		
		/**
		* 	Custom data to associate with this component.
		*/
		function get customData():Object;
		function set customData( value:Object ):void;	
		
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
		
		//TODO: remove this in favour of customData !!!
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
		* 	Gets a component bean from the bean document
		* 	associated with this component.
		* 
		* 	@param beanName The name of the component bean.
		* 
		* 	@return The component or <code>null</code> if no 
		* 	component was found.
		*/
		function getComponentBean( beanName:String ):DisplayObject;
		
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
		
		/**
		* 	Removes all child display objects from this component.
		*/
		function removeAllChildren():void;
	
		/**
		* 	Invoked to inform this component it is about
		* 	to be added to the stage and it should create
		* 	any required child components that do not already
		* 	exist.
		*/
		function prefinalize():void;
		
		/**
		* 	Attempts to retrieve a child component by identifier.
		* 
		* 	The default implementation of this method first tests
		* 	against and <code>id</code> property before comparing
		* 	against a <code>name</code> property.
		* 
		* 	@param id The identifier for the child component.
		* 
		* 	@return The child component if found otherwise null.
		*/
		function getElementById( id:String ):DisplayObject;
		
		/**
		* 	Gets a list of display objects whose identifier
		* 	matches the specified regular expression.
		* 	
		* 	@param re The regular expression to use.
		* 
		* 	@return The elements whose identifier matches
		* 	the specified regular expression. If no matches
		* 	were found this will be an empty vector.
		*/		
		function getElementsByMatch( re:RegExp ):Vector.<DisplayObject>;
		
		/**
		* 	Gets a collection of child display objects
		* 	that are of the specified collection of types.
		* 
		* 	@param types The collection of types to test against.
		* 
		* 	@return The collection of display objects that are of the specified
		* 	types. This collection will be empty when no child display objects
		* 	were found matching the specified types.
		*/
		function getElementsByTypes( types:Vector.<Class> ):Vector.<DisplayObject>;
	
		/**
		* 	Gets a collection of child display objects
		* 	that are of the specified type.
		* 
		* 	@param type The type to test against.
		* 
		* 	@return The collection of display objects that are of the specified
		* 	type. This collection will be empty when no child display objects
		* 	were found matching the specified type.
		*/
		function getElementsByType( type:Class ):Vector.<DisplayObject>;
	}
}