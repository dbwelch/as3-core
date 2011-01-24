package com.ffsys.ui.css
{
	import com.ffsys.core.IClone;
	
	import com.ffsys.utils.properties.PropertiesMerge;	
	
	//TODO: extend proxy
	public class CssStyleCache extends Object
	{
		private var _names:Vector.<String>;
		private var _styles:Vector.<CssStyle>;
		private var _source:CssStyle;
		private var _parent:CssStyleCache;
		
		/**
		* 	Creates a <code>CssStyleCache</code> instance.
		*/
		public function CssStyleCache(
			parent:CssStyleCache = null,
			names:Vector.<String> = null, 
			styles:Vector.<CssStyle> = null )
		{
			super();
			this.parent = parent;
			this.names = names;
			this.styles = styles;
		}
		
		/**
		* 	A parent style cache.
		*/
		public function get parent():CssStyleCache
		{
			return _parent;
		}
		
		public function set parent( value:CssStyleCache ):void
		{
			_parent = value;
		}
		
		/**
		* 	Inherits style properties from another style cache.
		* 
		* 	
		*/
		public function inherit( parent:CssStyleCache ):void
		{
			trace("[INHERITING STYLES] CssStyleCache::inherit()", parent );
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
		* 	TODO
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
		public function get names():Vector.<String>
		{
			return _names;
		}
		
		public function set names( value:Vector.<String> ):void
		{
			_names = value;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get styles():Vector.<CssStyle>
		{
			return _styles;
		}
		
		public function set styles( value:Vector.<CssStyle> ):void
		{
			_styles = value;
		}

		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return CssStyleCache;
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
		public function clone():CssStyleCache
		{
			var cache:CssStyleCache =
				CssStyleCache( getCloneInstance() );
			cache.names = names.slice();
			//TODO: deep clone style objects
			cache.styles = styles.slice();
			cache.source = copy();
			return cache;
		}
	}
}