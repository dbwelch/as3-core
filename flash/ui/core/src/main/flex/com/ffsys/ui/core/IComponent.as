package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import com.ffsys.core.IBitmapGrab;
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IEnabled;
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.data.IDataBinding;
	import com.ffsys.ui.data.IDataBindingNotification;
	import com.ffsys.ui.data.IDataBindingNotificationObserver;
	
	import com.ffsys.ui.css.IStyleManagerAware;		
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.text.core.ITextFieldFactory;
	import com.ffsys.ui.layout.ILayout;
	import com.ffsys.ui.layout.ILayoutWidth;
	import com.ffsys.ui.layout.ILayoutHeight;

	import com.ffsys.ui.common.*;
	import com.ffsys.ui.common.flash.ISprite;	
	
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.support.*;
	
	import com.ffsys.ioc.*;
	
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
				IBean,
				IBeanDocumentAware,
				IStyleAware,
				ILayoutWidth,
				ILayoutHeight,
				IMarginAware,
				IPaddingAware,
				IStageAware,
				IBitmapGrab,
				IRuntimeXmlAware,
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
		* 	The stylesheet for this component.
		*/
		function get stylesheet():ICssStyleSheet;
		function set stylesheet( value:ICssStyleSheet ):void;
		
		/**
		* 	Updates the cached style information associated with
		* 	this component with the specified style objects.
		* 
		* 	The enumerable properties of the style objects are merged
		* 	with the existing cached representation of the style information.
		* 
		* 	@param style The primary style object.
		* 	@param styles Additional style objects to apply.
		* 
		* 	@return The object that contains the cached style properties.
		*/
		function setStyle(
			style:Object, ... styles ):Object;		
		
		/**
		* 	Determines whether this component has a style cache.
		* 
		* 	@return A boolean indicating whether a style cache is
		* 	available.
		*/
		function hasStyleCache():Boolean;
		
		/**
		* 	Clears the style cache.
		*/
		function clearStyleCache():void;
		
		/**
		* 	Gets the style cache for this component.
		* 
		* 	If a style cache does not exist this method
		* 	will attempt to create a style cache.
		* 
		* 	@return The component style cache.
		*/
		function getStyleCache():IComponentStyleCache;		
		
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
		* 	The message identifier used to locate a message
		* 	from the known messages.
		*/
		function get identifier():String;
		function set identifier( value:String ):void;			
		
		/**
		* 	Gets the utility methods and properties available to all components.
		*/
		function get utils():IComponentViewUtils;
		
		/**
		* 	A list of parent display object containers
		* 	calculated when this component was added to the
		* 	display list.
		*/
		function get parents():Vector.<DisplayObjectContainer>;
		
		/**
		* 	Retrieves a list of the parents that are component
		* 	implementations.
		*/
		function get ancestors():Vector.<IComponent>;
		
		/**
		* 	The dimensions of this component.
		*/
		function get dimensions():IComponentDimensions;
		function set dimensions( value:IComponentDimensions ):void;
		
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
		function get minWidth():Number;
		function set minWidth( value:Number ):void;

		/**
		*	A minimum height for the component.
		*/
		function get minHeight():Number;
		function set minHeight( value:Number ):void;
		
		/**
		*	A maximum width for the component.
		*/
		function get maxWidth():Number;
		function set maxWidth( value:Number ):void;

		/**
		*	A maximum height for the component.
		*/
		function get maxHeight():Number;
		function set maxHeight( value:Number ):void;					
		
		/**
		* 	The text field factory used to create textfields.
		*/
		function get textFieldFactory():ITextFieldFactory;
	
		/**
		* 	The border definition for this component.
		*/
		function get border():IBorder;
		function set border( border:IBorder ):void;
	
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
		*	Gets a rectangle that represents the inner
		*	area inside any padding settings.	
		*/
				
		//TODO: move to dimensions
		//function getPaddingRectangle():Rectangle;
		
		/**
		*	Gets a rectangle that represents the dimensions
		*	of this component.
		*/
		
		//TODO: move to dimensions		
		//function getRectangle():Rectangle;	
		
		/**
		*	Gets a rectangle that represents the outer
		*	area outside any margin settings.
		*/
		
		//TODO: move to dimensions		
		//function getMarginRectangle():Rectangle;
		
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
		* 	Measures this component based on it's
		* 	preferred rendering dimensions.
		* 
		* 	@return The measured dimensions.
		*/
		function measure():IComponentDimensions;
		
		/**
		*	Sets the size of this component.
		*	
		*	@param width The preferred width for the component.
		*	@param height The preferred height for the component.	
		*/
		function setSize(
			width:Number = 10, height:Number = 10 ):void;
		
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
		* 	Removes all child display objects from this component
		* 	or optionally another display object container.
		* 
		* 	@param target An optional display object container to remove
		* 	the child display objects from.
		*/
		function removeAllChildren( target:DisplayObjectContainer = null ):void;
	
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
		
		/**
		*	The inner width of this component.
		*/
		
		//TODO: move to dimensions
		function get innerWidth():Number;
		
		/**
		*	The inner height of this component.
		*/
		
		//TODO: move to dimensions		
		function get innerHeight():Number;	
		
		/**
		* 	Gets a list of the instance names of all parent
		* 	display object containers.
		* 
		* 	@param root Whether to include the root display list object
		* 	name.
		* 
		* 	@return A list of the parent names.
		*/
		function getAncestorNames( root:Boolean = false ):Vector.<String>;
	
		/**
		* 	Gets the class path to a target object.
		* 
		* 	If no target is specified then the class path
		* 	for this instance is returned.
		* 
		* 	@param target The target object.
		* 
		* 	@return The fully qualified class path.
		*/
		function getClassPath( target:Object = null ):String;
	
		/**
		* 	Retrieves the class of an object.
		* 
		* 	If the target is a <code>Class</code> the
		* 	target is returned. If the target is <code>null</code>
		* 	the <code>Class</code> of this component is returned.
		* 
		* 	@param target A target object to retrieve the class
		* 	of.
		* 
		* 	@return The type of this component.
		*/
		function getClass( target:Object = null ):Class;
	
		/**
		*	Gets a dot path to this instance.
		* 
		* 	@param delimiter The delimiter to use when building the path.
		* 	@param root Whether to include the root instance.
		* 
		* 	@return The dot style path to this instance.
		*/
		function toNameString(
			delimiter:String = ".", root:Boolean = false ):String;
			
		/**
		* 	The bean descriptor that instantiated
		* 	this component.
		*/
		function get descriptor():IBeanDescriptor;
		
		/**
		* 	A support implementation for managing
		* 	the depth of this component.
		*/
		function get depth():IComponentDepth;
		function set depth( value:IComponentDepth ):void;
		
		/**
		* 	Gets a copy of this component in it's
		* 	original initialization state.
		* 
		* 	@param finalise Whether the copy should be finalized
		* 	after instantiation.
		* 
		* 	@return A copy of this component.
		*/
		function copy( finalize:Boolean = true ):IComponent;		
			
		/**
		* 	Copies the properties from a source component
		* 	to a target component and returns the updated
		* 	target component.
		* 	
		* 	@param source The source component containing
		* 	properties to transfer.
		* 	@param target The target component to receive
		* 	the transferred properties.
		* 
		* 	@return The updated target component.
		*/
		function transfer( source:IComponent, target:IComponent ):IComponent;
		
		/**
		* 	Creates a clone of this component in it's
		* 	current state.
		* 
		* 	@return A clone of this component.
		*/
		function clone():IComponent;
	}
}