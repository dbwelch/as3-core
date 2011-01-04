package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;	
	import flash.events.FocusEvent;
	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	import com.ffsys.ioc.IBeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;	
	
	import com.ffsys.ui.common.ComponentIdentifiers;
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
		
		private var _styleCache:IComponentStyleCache = null;
		private var _document:IBeanDocument;
		private var _state:State;
		private var _dataBinding:IDataBinding;	
		private var _layers:Array;
		private var _graphics:IComponent;
		private var _stage:Stage;
		
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
		* 	Invoked when this component has been finalized.
		*/
		public function finalized():void
		{
			//apply border and background graphics
			applyBorders();
			applyBackground();
			
			//update any child positioning
			layoutChildren( preferredWidth, preferredHeight );
		}
		
		/**
		* 	@private
		* 
		* 	Invoked after dependencies injected by
		* 	type have been resolved.
		* 
		* 	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		public function afterInjection(
			descriptor:IBeanDescriptor ):void
		{	
			//trace("UIComponent::afterInjection()", this, descriptor );
		}
		
		/**
		* 	@private
		* 
		* 	Invoked after bean properties have been set.
		* 
		* 	Method calls are handled prior to setting properties
		* 	so method calls have also been handled when this
		* 	method is invoked.
		* 
		* 	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		public function afterProperties(
			descriptor:IBeanDescriptor ):void
		{
			//trace("UIComponent::afterProperties()", this, descriptor );
		}
		
		/**
		* 	@private
		* 
		* 	Invoked after any external file resources
		* 	declared by the bean have been handled.
		* 
		* 	This does not imply the resources have been
		* 	loaded simply that they have been resolved and
		* 	a loader queue encapsulating the resources is available.
		* 
		*	@param descriptor The bean descriptor that
		* 	created the bean.
		*/
		public function afterResources(
			descriptor:IBeanDescriptor,
			queue:ILoaderQueue = null ):void
		{
			trace("UIComponent::afterResources()", this, descriptor, queue );
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
			trace("UIComponent::doWithStyleCache()", cache.main.padding );
			
			if( cache != null
			 	&& cache.main != null
				&& cache.main.padding is Number )
			{
				this.paddings.padding = cache.main.padding;
			}

			if( cache != null
			 	&& cache.main != null
				&& cache.main.paddingTop is Number )
			{
				this.paddings.top = cache.main.paddingTop;
			}

			if( cache != null
			 	&& cache.main != null
				&& cache.main.paddingRight is Number )
			{
				this.paddings.right = cache.main.paddingRight;
			}							
			
			if( cache != null
			 	&& cache.main != null
				&& cache.main.paddingBottom is Number )
			{
				this.paddings.bottom = cache.main.paddingBottom;
			}			
			
			if( cache != null
			 	&& cache.main != null
				&& cache.main.paddingLeft is Number )
			{
				this.paddings.left = cache.main.paddingLeft;
			}
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
		override public function prefinalize():void
		{
			//trace("::::::::::::::::: UIComponent::prefinalize()", this, this.id, this.styles );
			
			trace("UIComponent::prefinalize()", this, this.stage, this.id );
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
				//trace("UIComponent::applyStyles()APPLY STYLES: ", this, this.id, this.styles );
				
				if( _styleCache == null )
				{
					_styleCache = getStyleCache();
				}
				
				//var styleNames:Array = stylesheet.getStyleNameList( this );
				var styleNames:Array = _styleCache.styleNames;
				var styleObjects:Array = _styleCache.styleObjects;
				var main:Object = _styleCache.main;
				
				//apply all normal styles
				//trace("UIComponent::applyStyles() UICOMPONENT: ", this, styleNames, styleObjects, main );
				//stylesheet.style( this );
				
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