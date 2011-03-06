package java.util
{
	import java.lang.JavaObject;
	import java.lang.V;
	import java.lang.T;	
	
	/**
	* 	
	*/
	public class AbstractCollection extends JavaObject
		implements Collection
	{
		private var _valueType:V = null;		
		private var _items:Object;
		
		/**
		* 	@private
		*	
		*	Creates an <code>AbstractCollection</code> instance.
		* 
		* 	@param c The class of the collection values.
		*/
		public function AbstractCollection( c:Class = null )
		{
			super();
			var v:V = V.OBJECT;
			if( c != null )
			{
				v = new V( c );
			}
			setValueType( v );
		}
		
		/**
		* 	@private
		* 
		* 	The list of items encapsulated by this collection.
		*/
		protected function get items():Object
		{
			if( _items == null )
			{
				_items = T.vector( valueType.type );
			}
			return _items;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get valueType():V
		{
			if( _valueType == null )
			{
				_valueType = V.OBJECT;
			}
			return _valueType;
		}
		
		/**
		* 	@private
		* 	
		* 	Sets the value type of this collection.
		*/
		internal function setValueType( value:V ):void
		{
			_valueType = value;
		}

		/**
		* 	
		*/
		public function add( e:Object ):Boolean
		{
			var len:uint = items.length;
			_items.push( e );
			return _items.length > len;
		}
		
		/**
		* 	
		*/
		public function addAll( c:Collection ):Boolean
		{
			return false;
		}
		
		/**
		* 
		*/
		public function clear():void
		{
			//TODO
		}
		
		/**
		* 	
		*/
		public function contains():Boolean
		{
			return false;
		}
		
		/**
		* 	
		*/
		public function containsAll( c:Collection ):Boolean
		{
			return false;
		}
		
		/**
		* 	
		*/
		public function isEmpty():Boolean
		{
			return _items == null || _items.length == 0;
		}
		
		/**
		* 
		*/
		public function remove( o:Object ):Boolean
		{
			
			return false;
		}
		
		/**
		* 	
		*/
		public function removeAll( c:Collection ):Boolean
		{
			
			return false;
		}
		
		/**
		* 
		*/
		public function retainAll( c:Collection ):Boolean
		{
			return false;
		}
		
		/**
		* 	
		*/
		public function size():int
		{
			if( _items == null )
			{
				return 0;
			}
			return _items.length;
		}
		
		/**
		* 	
		*/
		public function toArray():Array
		{
			var output:Array = new Array();
			//TODO
			return output;
		}
		
		/**
		* 	
		*/
		public function toVector( c:Class ):Vector
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function iterator():Iterator
		{
			return null;
		}
	}
}