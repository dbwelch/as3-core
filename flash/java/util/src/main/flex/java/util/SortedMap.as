package java.util
{
	import flash.utils.Dictionary;
	
	import java.lang.*;
	
	/**
	* 	
	*/
	public class SortedMap extends Object
		implements Map
	{
		private var _dictionary:Dictionary = new Dictionary();
		
		private var _keyType:K = null;
		private var _valueType:V = null;
		
		/**
		* 	
		*/
		public function SortedMap()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get keyType():K
		{
			return _keyType;
		}
		
		public function set keyType( value:K ):void
		{
			_keyType = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get valueType():V
		{
			return _valueType;
		}
		
		public function set valueType( value:V ):void
		{
			_valueType = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function clear():void
		{
			
		}
		
		/**
		*	@inheritDoc
		*/
		public function containsKey( key:Object ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function containsValue( value:Object ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function entrySet():Set
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function equals( o:Object ):Boolean
		{
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function item( key:Object ):Object
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hashCode():int
		{
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function keySet():Set
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function put( key:Object, value:Object ):Object
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function putAll( m:Map ):void
		{
			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function remove( key:Object ):Object
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function size():int
		{
			return 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function values():Collection
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get iterator():Iterator
		{
			return null;
		}
	}
}