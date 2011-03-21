package org.flashx.utils.substitution {
	
	/**
	*	Represents a collection of Binding instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.07.2007
	*/
	public class BindingCollection extends Object
		implements IBindingCollection {
			
		protected var _namespaces:Array;
		
		public function BindingCollection()
		{
			super();
			clear();
		}
		
		public function clear():void
		{
			_namespaces = new Array();
		}
		
		public function getLength():int
		{
			return _namespaces.length;
		}
		
		public function addBinding( binding:IBinding ):void
		{
			if( binding )
			{
				var existing:IBinding = getBindingByPrefix( binding.prefix );
				
				if( existing )
				{
					existing.merge( binding );
				}else{
					_namespaces.push( binding );
				}
			}
		}
		
		public function hasBinding( binding:IBinding ):Boolean
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:IBinding;
			
			for( ;i < l;i++ )
			{
				child = getBindingAt( i );
				
				if( child == binding )
				{
					return true;
				}
				
			}
			
			return false;
		}
		
		public function getBindingIndex( binding:IBinding ):int
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:IBinding;
			
			for( ;i < l;i++ )
			{
				child = getBindingAt( i );
				
				if( child == binding )
				{
					return i;
				}
				
			}
			
			return -1;	
		}
		
		public function removeBinding( binding:IBinding ):Boolean
		{
			if( hasBinding( binding ) )
			{
				return removeBindingAt(
					getBindingIndex( binding ) );
			}
			
			return false;
		}
		
		public function getBindingAt( index:int ):IBinding
		{
			if( hasBindingAt( index ) )
			{
				return _namespaces[ index ];
			}
			
			return null;
		}
		
		public function hasBindingAt( index:int ):Boolean
		{
			var child:IBinding = _namespaces[ index ];
			return ( child && ( child is IBinding ) );
		}
		
		public function removeBindingAt( index:int ):Boolean
		{
			var removed:Array = _namespaces.splice( index, 1 );
			return ( removed && removed.length );
		}
		
		public function getBindingByPrefix( prefix:String ):IBinding
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:IBinding;
			
			for( ;i < l;i++ )
			{
				child = getBindingAt( i );
				
				if( child.prefix == prefix )
				{
					return child;
				}
				
			}
			
			return null;			
		}
		
		public function removeSubstitutionByPrefix( prefix:String ):Boolean
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:IBinding;
			
			for( ;i < l;i++ )
			{
				child = getBindingAt( i );
				
				if( child.prefix == prefix )
				{
					return removeBindingAt( i );
				}
				
			}
			
			return false;
		}
		
		public function clone():IBindingCollection
		{
			var output:IBindingCollection = new BindingCollection();
			
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				output.addBinding( getBindingAt( i ).clone() );
			}
			
			return output;
		}
	}
}