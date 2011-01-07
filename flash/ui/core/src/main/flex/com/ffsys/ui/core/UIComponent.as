package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;	
	import flash.events.FocusEvent;
	
	import com.ffsys.core.*;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.ioc.*;	
	
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.ui.common.*;
	import com.ffsys.ui.css.*;
	import com.ffsys.ui.graphics.ComponentGraphic;
	
	import com.ffsys.ui.data.IDataBinding;
	import com.ffsys.ui.data.IDataBindingNotification;
	
	/**
	*	The default component implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class UIComponent extends AbstractComponent
		implements IComponent
	{
		/**
		*	@private
		*/
		//TODO: migrate this to an IStyleSheetAware implementation
		private var _styleManager:IStyleManager = null;	
		
		internal var _styleCache:IComponentStyleCache = null;
		private var _document:IBeanDocument;
		private var _state:State;
		private var _dataBinding:IDataBinding;	
		private var _layers:Array;
		private var _graphics:IComponent;
		private var _stage:Stage;
		private var _descriptor:IBeanDescriptor;
		private var _xml:XML;
		private var _parser:Object;
		
		/**
		* 	Creates a <code>UIComponent</code> instance.
		*/
		public function UIComponent()
		{
			super();
		}
		
		/**
		* 	The bean document that instantiated this component.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getComponentBean( beanName:String ):DisplayObject
		{
			if( this.document != null )
			{
				return this.document.getBean(
					beanName ) as DisplayObject;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xml():XML
		{
			return _xml;
		}
		
		public function set xml( value:XML ):void
		{
			_xml = value;
		}
		
		/**
		*	@inheritDoc 
		*/
		override public function getClass( target:Object = null ):Class
		{
			if( _descriptor != null )
			{
				return _descriptor.instanceClass;
			}
			return super.getClass( target );
		}
		
		/**
		*	Gets an instance used to create clone
		* 	of this component.
		* 
		* 	This implementation simply calls <code>copy</code>
		* 	to retrieve a new instance using the bean descriptor.
		* 
		* 	@return A copy of this component.
		*/
		public function getCloneInstance():Object
		{
			return copy();
		}
		
		/**
		* 	Gets the class of object used to create a clone
		* 	of this component.
		* 
		* 	@return The class used to create this component.
		*/
		public function getCloneClass():Class
		{
			return getClass();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get descriptor():IBeanDescriptor
		{
			return _descriptor;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parser():Object
		{
			return _parser;
		}
		
		public function set parser( value:Object ):void
		{
			_parser = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy( finalize:Boolean = true ):IComponent
		{
			if( _descriptor == null )
			{
				throw new Error( "Cannot get a component copy with no bean descriptor." );
			}
			
			var xmlDefinition:Boolean = 
				xml is XML
				&& parser != null
				&& parser.deserialize is Function;
			
			var component:IComponent = null;
			
			//return document.getBean( beanName ) as IComponent;
			
			//xml component definition recreate from our xml
			if( xmlDefinition )
			{
				//don't finalize the bean when deserializing using an xml partial 
				component = _descriptor.getBean( true, false ) as IComponent;
				
				//TODO: ensure the runtime reference is the same document used to create this component
				
				//recreate a new document to parse into
				parser.runtime = null;
				
				//trace("UIComponent::copy()", this.xml.copy(), parser, parser.deserialize );
				
				component = parser.deserialize(
					this.xml.copy(), component ) as IComponent;
				
				/*
				if( component != null )
				{
					trace("UIComponent::copy() AFTER DESERIALIZE: ",
						component, component == this, component.id == this.id, component.styles == this.styles );
				}
				*/
			}else{
				//normal bean retrieval so finalize
				component = _descriptor.getBean() as IComponent;
			}
			
			if( finalize )
			{
				finalizeCopy( component );
			}
			
			return component;
		}
		
		/**
		* 	@private
		*/
		protected function finalizeCopy( component:IComponent ):void
		{
			component.prefinalize();
			component.finalized();		
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clone():IComponent
		{
			var implementation:IComponent = copy( false );
			transfer( this, implementation );
			finalizeCopy( implementation );
			return implementation;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function transfer( source:IComponent, target:IComponent ):IComponent
		{
			//trace("UIComponent::transfer() TODO TRANSFER PROPERTIES: ", source, target );
			
			if( source != null
				&& target != null )
			{
				target.id = new String( this.id );
				target.identifier = new String( this.identifier );
				target.customData = this.customData;
				target.dimensions = IComponentDimensions( source.dimensions.clone() );
				
				//TODO: merge style cache properties
				UIComponent( target )._styleCache = this._styleCache.clone();
			}
			return target;
		}
		
		/**
		* 	@private
		*/
		public function afterConstructed(
			descriptor:IBeanDescriptor ):void
		{
			_descriptor = descriptor;
			//trace("UIComponent::afterConstructed()", this, descriptor, descriptor.id );
		}
		
		/**
		* 	@private
		*/
		public function afterInjection(
			descriptor:IBeanDescriptor ):void
		{	
			//trace("UIComponent::afterInjection()", this, descriptor );
		}		
		
		/**
		* 	@private
		*/
		public function afterProperties(
			descriptor:IBeanDescriptor ):void
		{
			//trace("UIComponent::afterProperties()", this, descriptor );
		}
		
		/**
		* 	@private
		*/
		public function afterResources(
			descriptor:IBeanDescriptor,
			queue:ILoaderQueue = null ):void
		{
			//TODO: verify this queue is correct when a bean declares file dependencies
			//trace("UIComponent::afterResources()", this, descriptor, queue );
		}
		
		/**
		*	@inheritDoc
		*/
		public function setSize(
			width:Number = 10, height:Number = 10 ):void
		{
			
			//should we be less strict here? 
			if( isNaN( width ) || width <= 0 )
			{
				//w = 10;
				//throw new Error( "The component width parameter must be valid." );
			}
			
			if( isNaN( height ) || height <= 0 )
			{
				//throw new Error( "The component height parameter must be valid." );
			}
			
			_preferredWidth = width;
			_preferredHeight = height;

			//TODO: re-layout borders
			
			//trace("AbstractComponent::setSize()", this, width, height );
			
			applyBorders();
			applyBackground();
			
			layoutChildren( width, height );
		}
		
		
		/**
		* 	Invoked prior to a display object being added to
		* 	the display list.
		* 
		* 	Derived implementations can create default child
		* 	display objects that have not been defined in this
		* 	method.
		*/
		public function prefinalize():void
		{
			//
		}
		
		/**
		* 	Measures this component based on it's
		* 	preferred rendering dimensions.
		* 
		* 	@return The measured dimensions.
		*/
		public function measure():IDimensions
		{
			return this.dimensions.measure(	
				preferredWidth,
				preferredHeight,
				this );
		}
		
		/**
		* 	Invoked when this component has been finalized.
		*/
		public function finalized():void
		{	
			//updateState( this.state == null ? State.MAIN : state.clone() );
			
			var d:IDimensions = measure();
			
			trace("UIComponent::finalized() MEASURED DIMENSIONS: ", d );
			
			//apply border and background graphics
			applyBorders();
			applyBackground();
			
			//update any child positioning
			layoutChildren( preferredWidth, preferredHeight );
			
			//trace("UIComponent::finalized()", this, this.id );			
			
			//setSize( preferredWidth, preferredHeight );
		}
		
		/**
		* 	Overriden so that the <code>width</code> property
		* 	can be used as a shortcut for setting the <code>preferredWidth</code>.
		*/
		override public function set width( value:Number ):void
		{
			_preferredWidth = value;
			Dimensions( this.dimensions ).width = width;
		}
		
		/**
		* 	Overriden so that the <code>height</code> property
		* 	can be used as a shortcut for setting the <code>preferredHeight</code>.
		*/
		override public function set height( value:Number ):void
		{
			_preferredHeight = value;
			Dimensions( this.dimensions ).height = height;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle(
			style:Object, ... styles ):Object
		{
			if( _styleCache == null )
			{
				getStyleCache();
			}
			
			var existing:Object = _styleCache.copy();
			
			var output:Object = null;
			if( style != null )
			{
				if( !( styles is Array ) )
				{
					styles = new Array();
				}
				styles.unshift( style );
				output = _styleCache.update( styles );
				afterStyleCacheUpdated( existing, output );
			}
			return output;
		}
		
		/**
		* 	Invoked after the style cache is updated.
		* 
		* 	@param previous The object containing the previous style data.
		* 	@param updated The object containing the updated style data.
		*/
		protected function afterStyleCacheUpdated(
			previous:Object, updated:Object ):void
		{
			//simply apply the styles for now.
			applyStyles();
			
			if( invalidatesChildLayout( previous, updated ) )
			{
				layoutChildren( preferredWidth, preferredHeight );
			}
		}
		
		/**
		* 	Determines whether a style change would invalidate
		* 	the layout of child components.
		* 
		* 	@param previous The object containing the previous style data.
		* 	@param updated The object containing the updated style data.
		* 
		* 	@return A boolean indicating whether the child layout should
		* 	be updated after the styles have changed.
		*/
		protected function invalidatesDimensions(
			previous:Object, updated:Object ):Boolean
		{
			//TODO: implement
			return false;
		}
		
		/**
		* 	Determines whether a style change would invalidate
		* 	the layout of child components.
		* 
		* 	@param previous The object containing the previous style data.
		* 	@param updated The object containing the updated style data.
		* 
		* 	@return A boolean indicating whether the child layout should
		* 	be updated after the styles have changed.
		*/
		protected function invalidatesChildLayout(
			previous:Object, updated:Object ):Boolean
		{
			//TODO: implement
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasStyleCache():Boolean
		{
			return _styleCache != null;
		}
		
		/**
		* 	Clears the style cache.
		*/
		public function clearStyleCache():void
		{
			_styleCache = null;
		}
		
		/**
		* 	Gets the style cache for this component.
		* 
		* 	@return The component style cache.
		*/
		public function getStyleCache():IComponentStyleCache
		{
			//trace("UIComponent::getStyleCache() GET STYLE CACHE: ", hasStyleCache() );
			if( !hasStyleCache()
			 	&& _styleManager != null )
			{
				_styleCache = getComponentStyleCache();
				doWithStyleCache( _styleCache );
			}
			
			return _styleCache;
		}
		
		/**
		* 	Retrieves a cache of the styles associated with this
		* 	component.
		* 
		* 	@return The component style cache.
		*/
		protected function getComponentStyleCache():IComponentStyleCache
		{
			var output:IComponentStyleCache = null;
			
			if( this.stylesheet != null )
			{
				var data:Array = stylesheet.getStyleInformation( this );

				
				output = new ComponentStyleCache();
				output.styleNames = data[ 0 ];
				output.styleObjects = data[ 1 ];
				output.styles = this.styles;
				output.main = stylesheet.getFlatStyle( data[ 1 ] );
				
				
				
				//trace("UIComponent::getComponentStyleCache() this/styleNames: ", this, data[0], this.styles != null, output.main, output.main.spacing );
			}
			
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set stage( stage:Stage ):void
		{
			_stage = stage;
		}
		
		override public function get stage():Stage
		{
			if( _stage != null )
			{
				return _stage;
			}
			return super.stage;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set styles( value:String ):void
		{
			if( value == null )
			{
				_styleCache = null;
			}
			
			//nothing to do
			if( this.styles == value  )
			{
				return;
			}
			
			super.styles = value;
			
			//this will currently only work when the styles property is declared
			//in the xml document as we can be sure the style manager has already
			//been injected then - TODO add support for this property in plain bean declarations
			if( this.styles != null )
			{
				//update the style cache
				getStyleCache();
			}
		}
		
		/**
		* 	The style manager for the component.
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		private var _stylesheet:ICssStyleSheet;
		
		public function get stylesheet():ICssStyleSheet
		{
			if( this.styleManager )
			{
				return this.styleManager.stylesheet;
			}
			return _stylesheet;
		}
		
		public function set stylesheet( value:ICssStyleSheet ):void
		{
			_stylesheet = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get state():State
		{
			return _state;
		}				
		
		public function set state( value:State ):void
		{
			//force to the main state
			if( value == null )
			{
				value = State.MAIN;
			}

			_state = value;
		}
		
		override internal function beforeAdded():void
		{
			//apply style information by default
			//applyStyles();
			updateState( this.state == null ? State.MAIN : state.clone() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setState( state:State ):void
		{
			updateState( state );
		}
		
		/**
		* 	Sets the state of this component and updates
		* 	the styles applied to this component.
		* 
		* 	@param state The state for this component.
		*/
		protected function updateState(
			state:State ):void
		{
			//trace("UIComponent::updateState()", state );
			this.state = state;
			applyStyles();
		}
		
		/**
		*	Invoked when this component receives focus.	
		*	
		*	@param event The focus event.
		*/
		internal function focusIn( event:FocusEvent ):void
		{
			//trace("UIComponent::focusIn(), ", this );
		}
		
		/**
		*	Invoked when this component loses focus.
		*	
		*	@param event The focus event.
		*/
		internal function focusOut( event:FocusEvent ):void
		{
			//trace("UIComponent::focusOut(), ", this );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function applyStyles():Array
		{
			//add graphical layers
			applyLayers();			
			
			if( styleManager )
			{	
				if( _styleCache == null )
				{
					_styleCache = getStyleCache();
				}
				
				//
				
				/*
				trace("UIComponent::applyStyles() APPLY STYLES: ",
					this, this.id, this.styles, _styleCache, _styleCache.main.textTransform );
				*/
				
				//var styleNames:Array = stylesheet.getStyleNameList( this );
				var styleNames:Array = _styleCache.styleNames;
				var styleObjects:Array = _styleCache.styleObjects;
				var main:Object = _styleCache.main;
				
				//apply all normal styles
				//trace("UIComponent::applyStyles() UICOMPONENT: ", this, styleNames, styleObjects, main );
				//stylesheet.style( this );
				
				//trace("UIComponent::applyStyles()", main, main.color );
				
				//apply the main flattened style object
				stylesheet.applyStyle( this, main );
				
				var output:Array = styleObjects;
				
				//find one matching a non-main state
				//if a state has been specified
				//and apply state level styles over the top
				//of the main style data
				if( styleNames != null
					&& this.state != null
					&& this.state.primary != State.MAIN_ID )
				{
					//trace("UIComponent::applyStyles()", this, this.id, styleNames, this.state.toStateString() );
					
					var stateStyles:Array = new Array();
					var stateStyle:Object = null;
					var name:String = null;
  					for( var i:int = 0;i < styleNames.length;i++ )
					{
						
						//TODO: attempt to locate style objects for every element in a state
						
						name = styleNames[ i ]
							+ State.DELIMITER
							+ this.state.toStateString();
							
						//trace("UIComponent::applyStyles() state style search name:", name );
						
						//stateStyle = stylesheet.getStyle( name );
						
						stateStyle = stylesheet.getStyle( name );
						
						if( stateStyle != null )
						{
							//trace("UIComponent::applyStyles()", "GOT STATE STYLE", name, stateStyle, stateStyle.icon );
							stateStyles.push( stateStyle );
						}
					}

					if( stateStyles.length > 0 )
					{
						output = output.concat( stateStyles );
						stylesheet.applyStyles( this, stateStyles );
					}
				}
				
				return output;
			}
			return null;
		}
		
		/**
		* 	Applies graphical layers to this component.
		*/
		protected function applyLayers():void
		{
			if( _layers != null )
			{
				if( _graphics == null )
				{
					createLayers();
				}
				
				_graphics.removeAllChildren();
				
				var element:Object = null;
				for( var i:int = 0;i < layers.length;i++ )
				{
					element = layers[ i ];
					if( element is DisplayObject )
					{
						_graphics.addChild( DisplayObject( element ) );
					}
				}
			}else{
				if( _graphics != null )
				{
					_graphics.removeAllChildren();					
					if( contains( DisplayObject( _graphics ) ) )
					{
						removeChild( DisplayObject( _graphics ) );
					}
				}
				_graphics = null;
			}
		}
		
		
		/**
		* 	@inheritDoc
		*/
		public function getClassLevelStyleNames():Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			var className:String = getClassName();
			output.push( className );			
			if( _descriptor != null
				&& _descriptor.id != className.toLowerCase() )
			{
				output.push( _descriptor.id );
			}
			return output;
		}		
		
		/**
		* 	Creates the component used to store graphical
		* 	layers.
		* 
		* 	@return The created component.
		*/
		protected function createLayers():IComponent
		{
			_graphics = new UIComponent();
			if( numChildren <= 1 )
			{
				addChild( DisplayObject( _graphics ) );
			}else{
				addChildAt( DisplayObject( _graphics ), 1 );
			}
			return _graphics;
		}		
		
		/**
		* 	Gets the component used to render
		* 	graphical layers.
		* 
		* 	@return The component used to store graphical layers.
		*/
		public function getGraphicLayers():IComponent
		{
			return _graphics;
		}
		
		/**
		* 	Sets the graphical layers from an array of
		* 	display objects.
		*/
		public function get layers():Array
		{
			return _layers;
		}
		
		public function set layers( layers:Array ):void
		{
			_layers = layers;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get dataBinding():IDataBinding
		{
			return _dataBinding;
		}
		
		public function set dataBinding( value:IDataBinding ):void
		{
			if( _dataBinding && value && ( _dataBinding != value ) )
			{
				_dataBinding.removeObserver( this );
			}
			
			if( _dataBinding != value )
			{
				_dataBinding = value;
			}
			
			if( _dataBinding )
			{
				_dataBinding.addObserver( this );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function notify( notification:IDataBindingNotification ):void
		{	
			//trace("AbstractComponent::notify()", notification, this );
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):DisplayObject
		{
			if( id != null )
			{
				var child:DisplayObject = null;
				for( var i:int = 0;i < numChildren;i++ )
				{
					child = getChildAt( i );
					if( child is IStringIdentifier )
					{
						if( IStringIdentifier( child ).id == id )
						{
							return child;
						}
					}
				}
				return getChildByName( id );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByTypes( types:Vector.<Class> ):Vector.<DisplayObject>
		{
			var output:Vector.<DisplayObject> = new Vector.<DisplayObject>();		
			if( types != null )
			{
				var type:Class = null;
				for each( type in types )
				{
					output = output.concat(
						getElementsByType( type ) );
				}
			}
			return output;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByType( type:Class ):Vector.<DisplayObject>
		{
			var output:Vector.<DisplayObject> = new Vector.<DisplayObject>();		
			if( type != null )
			{
				var child:DisplayObject = null;
				for( var i:int = 0;i < numChildren;i++ )
				{
					child = getChildAt( i );
					if( child is type )
					{
						output.push( child );
					}
				}
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByMatch( re:RegExp ):Vector.<DisplayObject>
		{
			var output:Vector.<DisplayObject> = new Vector.<DisplayObject>();			
			if( re != null )
			{
				var child:DisplayObject = null;
				var id:String = null;
				for( var i:int = 0;i < numChildren;i++ )
				{
					child = getChildAt( i );
					id = child.name;
					if( child is IStringIdentifier )
					{
						id = IStringIdentifier( child ).id;
					}
					
					if( id != null
						&& re.test( id ) )
					{
						output.push( child );
					}
				}
			}
			return output;
		}
		
		
		/**
		* 	Invoked when a style cache is generated.
		* 
		* 	This allows derived implementations to access
		* 	style properties prior to the styles being
		* 	applied to the component.
		* 
		* 	@param cache The component style cache.
		*/
		protected function doWithStyleCache(
			cache:IComponentStyleCache ):void
		{
			//TODO: implement caching of borders and margins and remove
			//the margin / paddign application in css style sheet
			
			//trace("UIComponent::doWithStyleCache()", cache.main.padding );

			extractDimensions( cache );
			copyPaddingsFromStyleCache( cache );
			copyMarginsFromStyleCache( cache );
		}
		
		/**
		* 	@private
		*/
		private function extractDimensions(
			cache:IComponentStyleCache ):void
		{
			if( cache != null
			 	&& cache.main != null )
			{				
				if( cache.main.width is Number )
				{
					Dimensions( this.dimensions ).width = cache.main.width;
				}
			
				if( cache.main.height is Number )
				{
					Dimensions( this.dimensions ).height = cache.main.height;
				}
			
				if( cache.main.minWidth is Number )
				{
					this.dimensions.minWidth = cache.main.minWidth;
				}
			
				if( cache.main.minHeight is Number )
				{
					this.dimensions.minHeight = cache.main.minHeight;
				}
				
				if( cache.main.maxWidth is Number )
				{
					this.dimensions.maxWidth = cache.main.maxWidth;
				}
			
				if( cache.main.maxHeight is Number )
				{
					this.dimensions.maxHeight = cache.main.maxHeight;
				}
				
				if( cache.main.percentWidth is Number )
				{
					this.dimensions.percentWidth = cache.main.percentWidth;
					trace("UIComponent::extractDimensions() GOT PERCENTAGE WIDTH: ", dimensions.percentWidth );
				}
				
				if( cache.main.percentHeight is Number )
				{
					this.dimensions.percentHeight = cache.main.percentHeight;
					trace("UIComponent::extractDimensions() GOT PERCENTAGE HEIGHT: ", dimensions.percentHeight );
				}
			}					
		}
		
		private function copyPaddingsFromStyleCache( cache:IComponentStyleCache ):void
		{
			if( cache != null
			 	&& cache.main != null )
			{			
				if( cache.main.padding is Number )
				{
					this.paddings.padding = cache.main.padding;
				}

				if( cache.main.paddingTop is Number )
				{
					this.paddings.top = cache.main.paddingTop;
				}

				if( cache.main.paddingRight is Number )
				{
					this.paddings.right = cache.main.paddingRight;
				}							
			
				if( cache.main.paddingBottom is Number )
				{
					this.paddings.bottom = cache.main.paddingBottom;
				}			
			
				if( cache.main.paddingLeft is Number )
				{
					this.paddings.left = cache.main.paddingLeft;
				}
			}		
		}		
		
		private function copyMarginsFromStyleCache( cache:IComponentStyleCache ):void
		{
			if( cache != null
			 	&& cache.main != null )
			{
				if( cache.main.margin is Number )
				{
					this.margins.margin = cache.main.margin;
				}

				if( cache.main.marginTop is Number )
				{
					this.margins.top = cache.main.marginTop;
				}

				if( cache.main.marginRight is Number )
				{
					this.margins.right = cache.main.marginRight;
				}							

				if( cache.main.marginBottom is Number )
				{
					this.margins.bottom = cache.main.marginBottom;
				}			

				if( cache.main.marginLeft is Number )
				{
					this.margins.left = cache.main.marginLeft;
				}
			}
		}	
		
		
		/**
		* 	Cleans composite references.
		*/
		override public function destroy():void
		{
			super.destroy();
			
			if( this.dataBinding )
			{
				this.dataBinding.removeObserver( this );
			}			
			
			_document = null;
			_styleManager = null;
			_styleCache = null;
			_state = null;
			_stage = null;
			_dataBinding = null;
			_descriptor = null;
			_xml = null;
		}
		
		/**
		*	Provides static access to the utilities exposed
		*	to all components.
		*/
		public static function get utilities():IComponentViewUtils
		{
			return _utils;
		}
	}
}