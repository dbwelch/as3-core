package com.ffsys.ui.core
{
	import com.ffsys.core.IClone;
	
	import com.ffsys.ui.css.*;
	
	import com.ffsys.utils.properties.PropertiesMerge;	
	
	public class ComponentStyleCache extends Object
		implements IComponentStyleCache
	{
		private var _styleNames:Array;
		private var _styleObjects:Array;
		private var _styles:String;
		private var _source:CssStyle;
		//private var _customStyles:Vector.<Object> = new Vector.<Object>();
		
		private var _computedAncestorStyles:CssStyle;
		
		private var _ancestors:Vector.<IComponentStyleCache>;
		
		/**
		* 	Creates a <code>ComponentStyleCache</code> instance.
		*/
		public function ComponentStyleCache()
		{
			super();
		}
		
		public function propagate( component:IComponent ):void
		{
			var child:IComponent = null;
			for each( child in component.components )
			{
				child.getStyleCache().inherit( this );
			}
		}
		
		public function inherit( parent:IComponentStyleCache ):void
		{
			trace("[INHERITING STYLES] ComponentStyleCache::inherit()", parent );
		}
		
		protected function computeAncestorStyles( ancestors:Vector.<IComponentStyleCache> ):CssStyle
		{
			if( _computedAncestorStyles == null )
			{
				_computedAncestorStyles = new CssStyle( {} );
			}
					
			if( ancestors != null )
			{
				trace("[COMPUTING ANCESTOR STYLES] ComponentStyleCache::computeAncestorStyles()", ancestors.length );
				
				var merger:PropertiesMerge = new PropertiesMerge();
				var cache:IComponentStyleCache = null;
				for( var i:int = 0;i < ancestors.length;i++ )
				{
					cache = ancestors[ i ];
					merger.merge( _computedAncestorStyles, cache.source, true );
				}
			}
			
			//TODO: lookup font declarations in the parent
			return _computedAncestorStyles;
		}
		
		protected function getAncestorStyleCache(
			component:IComponent ):Vector.<IComponentStyleCache>
		{
			var output:Vector.<IComponentStyleCache> = new Vector.<IComponentStyleCache>();
			var ancestors:Vector.<IComponent> = component.ancestors;
			trace("[COMPONENT ANCESTORS] ComponentStyleCache::getAncestorStyleCache()", component, component.id, ancestors );
			for( var i:int = 0;i < ancestors.length;i++ )
			{
				output.push( ancestors[ i ].getStyleCache() );
			}
			trace("ComponentStyleCache::computeAncestorStyles()", "RETURNING STYLE CACHE ANCESTORS: ", output );
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy():CssStyle
		{
			//TODO: integrate deep copying using clone if the object implements IClone
			//once the clone logic has been integrated with the component objects - graphics first!
			var output:CssStyle = new CssStyle();
			if( _source != null )
			{
				var z:String = null;
				var target:*;
				for( z in _source )
				{
					target = _source[ z ];
					if( target is IClone
						&& Object( target ).clone is Function )
					{
						target = target.clone();
					}
					output[ z ] = target;
				}
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function update( styles:Array ):Object
		{
			if( styles != null )
			{
				if( _source == null )
				{
					_source = new CssStyle( {} );
				}
				var merger:PropertiesMerge = new PropertiesMerge();
				var style:Object = null;
				for( var i:int = 0;i < styles.length;i++ )
				{
					style = styles[ i ];
					merger.merge( _source, style, false );
					
					/*
					if( style != null
					 	&& _customStyles.indexOf( style ) == -1 )
					{
						_customStyles.push( style );
					}
					*/
				}
			}
			return _source;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get source():CssStyle
		{
			return _source;
		}
		
		public function set source( value:CssStyle ):void
		{
			_source = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleNames():Array
		{
			return _styleNames;
		}
		
		public function set styleNames( value:Array ):void
		{
			_styleNames = value;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get styleObjects():Array
		{
			return _styleObjects;
		}
		
		public function set styleObjects( value:Array ):void
		{
			_styleObjects = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styles():String
		{
			return _styles;
		}
		
		public function set styles( value:String ):void
		{
			_styles = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function apply( target:IComponent ):Array
		{
			//
			
			/*
			trace("UIComponent::applyStyles() APPLY STYLES: ",
				this, this.id, this.styles, _styleCache, _styleCache.source.textTransform );
			*/
			
			if( target != null )
			{
				
				//getAncestorStyleCache
				
				/*
				var ancestors:Vector.<IComponentStyleCache> =
					getAncestorStyleCache( target );
				if( _computedAncestorStyles == null )
				{
					computeAncestorStyles( ancestors );
				}
				
				trace("[COMPUTED STYLE CHECK] ComponentStyleCache::apply()", _computedAncestorStyles );
				
				for( var k:String in _computedAncestorStyles )
				{
					trace("[COMPUTED ANCESTOR STYLE CHECK] ComponentStyleCache::apply()", k, _computedAncestorStyles[k] );
				}
				*/
				
				//var styleNames:Array = stylesheet.getStyleNameList( this );
				var styleNames:Array = styleNames;
				var styleObjects:Array = styleObjects;
			
				//apply all normal styles
				//trace("UIComponent::applyStyles() UICOMPONENT: ", this, styleNames, styleObjects, source );
				//stylesheet.style( this );
			
				//trace("UIComponent::applyStyles()", source, source.color );
				//apply the source flattened style object
			
				//stylesheet.applyStyle( this, source );
			
				//
				source.apply( target );
			
				var output:Array = styleObjects;
			
				//find one matching a non-source state
				//if a state has been specified
				//and apply state level styles over the top
				//of the source style data
				if( styleNames != null
					&& target.state != null
					&& target.state.primary != State.MAIN_ID )
				{
					//trace("UIComponent::applyStyles()", this, target.id, styleNames, target.state.toStateString() );
				
					var stateStyles:Array = new Array();
					var stateStyle:CssStyle = null;
					var name:String = null;
					for( var i:int = 0;i < styleNames.length;i++ )
					{
					
						//TODO: attempt to locate style objects for every element in a state
					
						name = styleNames[ i ]
							+ State.DELIMITER
							+ target.state.toStateString();
						
						//trace("UIComponent::applyStyles() state style search name:", name );
					
						//stateStyle = stylesheet.getStyle( name );
					
						stateStyle = CssStyle( target.stylesheet.getStyle( name ) );
					
						if( stateStyle != null )
						{
							//trace("UIComponent::applyStyles()", "GOT STATE STYLE", name, stateStyle, stateStyle.icon );
							stateStyles.push( stateStyle );
						}
					}

					if( stateStyles.length > 0 )
					{
						output = output.concat( stateStyles );
						
						//target.stylesheet.applyStyles( target, stateStyles );
						
						var cumulative:CssStyle = target.stylesheet.getFlatStyle( stateStyles );
						cumulative.apply( target );
					}
				}
				return output;
			}
			return null;		
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return ComponentStyleCache;
		}
		
		/**
		* 	Gets an instance for use as a clone.
		* 
		* 	@return The instance to use as a clone.
		*/
		public function getCloneInstance():Object
		{
			var clazz:Class = getCloneClass();
			return new clazz();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clone():IComponentStyleCache
		{
			var cache:IComponentStyleCache =
				IComponentStyleCache( getCloneInstance() );
			cache.styleNames = styleNames.slice();
			cache.styles = new String( this.styles );
			//TODO: deep clone style objects
			cache.styleObjects = styleObjects.slice();
			cache.source = copy();
			return cache;
		}
	}
}