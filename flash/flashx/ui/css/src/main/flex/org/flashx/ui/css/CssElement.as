package org.flashx.ui.css
{
	
	import flash.utils.*;
	import flash.utils.flash_proxy;	

	dynamic public class CssElement extends Proxy
	{
		private var _source:Object;
		//an array of the values
		private var _elements:Vector.<ElementMap>;
	
		public function CssElement( source:Object = null )
		{
			super();
			setSource( source );
		}
		
		/**
		* 	The source object containing enumerable style properties.
		*/
		public function get source():Object
		{
			if( _source == null )
			{
				_source = new Object();
			}
			return _source;
		}
		
		public function get length():uint
		{
			return _elements != null ? _elements.length : 0;
		}
		
		/**
		* 	@private
		*/
		private function setSource( source:Object ):void
		{
			_elements = new Vector.<ElementMap>();
			for( var z:String in source )
			{
				/*
				_elements.push(
					new ElementMap( z, source[ z ], _elements.length ) );
				*/
				
				this[ z ] = source[ z ];
			}
			_source = source;
		}

		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			return ( this.source.hasOwnProperty( name ) );
	    }
		
		/**
		*	@private	
		*/
	    override flash_proxy function getProperty( name:* ):*
		{
			if( name == null || name == "null" )
			{
				return null;
			}
			
			/*
			trace("CssElement::getProperty()", this, name, this.source[ name ] );
			
			for( var z:String in source )
			{
				trace("[ CSS ] CssElement::getProperty() got stored property name: ", z, source[ z ] );
			}
			*/
			
			return this.source[ name ];
	    }
		
		/**
		*	@private	
		*/
	    override flash_proxy function setProperty( name:*, value:* ):void
		{
			if( name == null || name == "null" )
			{
				return;
			}
			
			var hasProp:Boolean = ( this.source[ name ] != null );
			
			//add all elements to the array of elements
			if( !hasProp )
			{
				value = doWithNewProperty( name, value );
				_elements.push(
					new ElementMap( name, value, _elements.length ) );
			}else{
				//update the stored value
				var map:ElementMap = null;
				for each( map in _elements )
				{
					if( map.name == name )
					{
						map.value = value;
					}
				}
			}
			
			this.source[ name ] = value;
			
			//trace("[CSS] CssElement::setProperty()", name, this.source[ name ] );
	    }
	
		protected function doWithNewProperty( name:*, value:* ):*
		{
			return value;
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			//
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			//trace("CssElement::nextNameIndex()", index );
			if( index < _elements.length )
			{
				return index + 1;
			}
		
			return 0;
		}
	
		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			if( index <= _elements.length )
			{
				var map:ElementMap = ElementMap( _elements[ index - 1 ] );
				return map.name;
			}
			return null;
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
		{
			return ElementMap( _elements[ index - 1 ] ).value;
		}
		
		/**
		* 	@private
		*/
		override flash_proxy function deleteProperty( name:* ):Boolean
		{
			var map:ElementMap = null;
			for each( map in _elements )
			{
				if( map.name == name )
				{
					_elements.splice( map.index, 1 );
					break;
				}
			}
			return delete this.source[ name ];
		}
		
		/**
		* 	Gets a string representation of this instance.
		* 
		* 	@return A string representing this instance.
		*/
		public function toString():String
		{
			return "[" + getQualifiedClassName( this ) + "]";
		}		
	}
}

class ElementMap {
	public var name:String;
	public var value:*;
	public var index:int;
	
	public function ElementMap( name:String, value:*, index:int )
	{
		this.name = name;
		this.value = value;
		this.index = index;				
	}
}