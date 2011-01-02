package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	
	import com.ffsys.core.IStringIdentifier;
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
		
		private var _document:IBeanDocument;
		private var _state:State;
		private var _dataBinding:IDataBinding;	
		private var _layers:Array;
		private var _graphics:IComponent;		
		
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
			//apply border graphics
			applyBorders();
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
		
		public function get stylesheet():ICssStyleSheet
		{
			if( this.styleManager )
			{
				return this.styleManager.stylesheet;
			}
			return null;
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
				var stylesheet:ICssStyleSheet = styleManager.stylesheet;
				var styleNames:Array = stylesheet.getStyleNameList( this );
				
				//apply all normal styles
				var output:Array = stylesheet.style( this );
				
				//find one matching a non-main state
				//if a state has been specified
				if( styleNames != null
					&& this.state != null
					&& this.state.primary != State.MAIN_ID )
				{

					//trace("UIComponent::applyStyles()", this.state.toStateString(), this, this.id, styleNames );
										
					//trace("UIComponent::applyStyles()", styleNames, this, this.id );
					
					var stateStyles:Array = new Array();
					var stateStyle:Object = null;
					var name:String = null;
  					for( var i:int = 0;i < styleNames.length;i++ )
					{

						name = styleNames[ i ]
							+ State.DELIMITER
							+ this.state.toStateString();
							
						//trace("UIComponent::applyStyles() state style search name:", name );
						
						stateStyle = stylesheet.getStyle( name );
						if( stateStyle != null )
						{
							//trace("UIComponent::applyStyles()", "GOT STATE STYLE", stateStyle, stateStyle.color );
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
			trace("AbstractComponent::notify()", notification, this );
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
			_state = null;
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