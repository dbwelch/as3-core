package com.ffsys.css
{
	import com.ffsys.core.IClone;
	
	import com.ffsys.utils.properties.PropertiesMerge;
	
	public class StyleRuleCache extends StyleElement
	{
		private var _names:Vector.<String>;
		private var _rules:Vector.<StyleRule>;
		private var _computed:StyleRule;
		private var _parent:StyleRuleCache;
		
		/**
		* 	Creates a <code>StyleRuleCache</code> instance.
		* 
		* 	@param parent A parent style cache.
		* 	@param names A list of style names.
		* 	@param rules A list of style objects for each style name.
		*/
		public function StyleRuleCache(
			parent:StyleRuleCache = null,
			names:Vector.<String> = null, 
			rules:Vector.<StyleRule> = null )
		{
			super();
			this.parent = parent;
			this.names = names;
			this.rules = rules;
		}
		
		/**
		* 	A parent style cache.
		*/
		public function get parent():StyleRuleCache
		{
			return _parent;
		}
		
		public function set parent( value:StyleRuleCache ):void
		{
			_parent = value;
			if( value != null )
			{
				inherit( value );
			}
		}
		
		/**
		* 	Inherits style properties from another style cache.
		*/
		public function inherit( parent:StyleRuleCache ):void
		{
			if( parent != null )
			{
				//copy in the parent style properties
				update( [ parent.computed ] );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy():StyleRule
		{
			//TODO: integrate deep copying using clone if the object implements IClone
			//once the clone logic has been integrated with the component objects - graphics first!
			var output:StyleRule = new StyleRule();
			if( _computed != null )
			{
				var z:String = null;
				var target:*;
				for( z in _computed )
				{
					target = _computed[ z ];
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
		public function update( rules:Array ):Object
		{
			if( rules != null )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				var style:Object = null;
				for( var i:int = 0;i < rules.length;i++ )
				{
					style = rules[ i ];
					merger.merge( computed, style, false );
				}
			}
			return _computed;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get computed():StyleRule
		{
			if( _computed == null )
			{
				_computed = new StyleRule( {} );
			}
			return _computed;
		}
		
		public function set computed( value:StyleRule ):void
		{
			_computed = value;
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
		public function get rules():Vector.<StyleRule>
		{
			return _rules;
		}
		
		public function set rules( value:Vector.<StyleRule> ):void
		{
			_rules = value;
		}

		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return StyleRuleCache;
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
		public function clone():StyleRuleCache
		{
			var cache:StyleRuleCache =
				StyleRuleCache( getCloneInstance() );
			cache.names = names.slice();
			//TODO: deep clone style objects
			cache.rules = rules.slice();
			cache.computed = copy();
			return cache;
		}
	}
}