package com.ffsys.ui.core
{
	import com.ffsys.core.IClone;
	
	import com.ffsys.utils.properties.PropertiesMerge;	
	
	public class ComponentStyleCache extends Object
		implements IComponentStyleCache
	{
		private var _styleNames:Array;
		private var _styleObjects:Array;
		private var _styles:String;
		private var _main:Object;
		//private var _customStyles:Vector.<Object> = new Vector.<Object>();
		
		/**
		* 	Creates a <code>ComponentStyleCache</code> instance.
		*/
		public function ComponentStyleCache()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy():Object
		{
			//TODO: integrate deep copying using clone if the object implements IClone
			//once the clone logic has been integrated with the component objects - graphics first!
			var output:Object = new Object();
			if( _main != null )
			{
				var z:String = null;
				var target:*;
				for( z in _main )
				{
					target = _main[ z ];
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
				if( _main == null )
				{
					_main = new Object();
				}
				var merger:PropertiesMerge = new PropertiesMerge();
				var style:Object = null;
				for( var i:int = 0;i < styles.length;i++ )
				{
					style = styles[ i ];
					merger.merge( _main, style, false );
					
					/*
					if( style != null
					 	&& _customStyles.indexOf( style ) == -1 )
					{
						_customStyles.push( style );
					}
					*/
				}
			}
			return _main;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get main():Object
		{
			return _main;
		}
		
		public function set main( value:Object ):void
		{
			_main = value;
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
			cache.main = copy();
			return cache;
		}
	}
}