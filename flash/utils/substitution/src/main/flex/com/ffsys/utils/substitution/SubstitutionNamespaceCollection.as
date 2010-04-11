package com.ffsys.utils.substitution {
	
	/**
	*	Represents a collection of SubstitutionNamespace instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.07.2007
	*/
	public class SubstitutionNamespaceCollection extends Object
		implements ISubstitutionNamespaceCollection {
			
		protected var _namespaces:Array;
		
		public function SubstitutionNamespaceCollection()
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
		
		public function addSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):void
		{
			if( substitutionNamespace )
			{
				var existing:ISubstitutionNamespace = getSubstitutionNamespaceByPrefix( substitutionNamespace.prefix );
				
				if( existing )
				{
					existing.merge( substitutionNamespace );
				}else{
					_namespaces.push( substitutionNamespace );
				}
			}
		}
		
		public function hasSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):Boolean
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:ISubstitutionNamespace;
			
			for( ;i < l;i++ )
			{
				child = getSubstitutionNamespaceAt( i );
				
				if( child == substitutionNamespace )
				{
					return true;
				}
				
			}
			
			return false;
		}
		
		public function getSubstitutionNamespaceIndex( substitutionNamespace:ISubstitutionNamespace ):int
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:ISubstitutionNamespace;
			
			for( ;i < l;i++ )
			{
				child = getSubstitutionNamespaceAt( i );
				
				if( child == substitutionNamespace )
				{
					return i;
				}
				
			}
			
			return -1;	
		}
		
		public function removeSubstitutionNamespace( substitutionNamespace:ISubstitutionNamespace ):Boolean
		{
			if( hasSubstitutionNamespace( substitutionNamespace ) )
			{
				return removeSubstitutionNamespaceAt(
					getSubstitutionNamespaceIndex( substitutionNamespace ) );
			}
			
			return false;
		}
		
		public function getSubstitutionNamespaceAt( index:int ):ISubstitutionNamespace
		{
			if( hasSubstitutionNamespaceAt( index ) )
			{
				return _namespaces[ index ];
			}
			
			return null;
		}
		
		public function hasSubstitutionNamespaceAt( index:int ):Boolean
		{
			var child:ISubstitutionNamespace = _namespaces[ index ];
			return ( child && ( child is ISubstitutionNamespace ) );
		}
		
		public function removeSubstitutionNamespaceAt( index:int ):Boolean
		{
			var removed:Array = _namespaces.splice( index, 1 );
			return ( removed && removed.length );
		}
		
		public function getSubstitutionNamespaceByPrefix( prefix:String ):ISubstitutionNamespace
		{
			var i:int = 0;
			var l:int = getLength();
			
			var child:ISubstitutionNamespace;
			
			for( ;i < l;i++ )
			{
				child = getSubstitutionNamespaceAt( i );
				
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
			
			var child:ISubstitutionNamespace;
			
			for( ;i < l;i++ )
			{
				child = getSubstitutionNamespaceAt( i );
				
				if( child.prefix == prefix )
				{
					return removeSubstitutionNamespaceAt( i );
				}
				
			}
			
			return false;
		}
		
		public function clone():ISubstitutionNamespaceCollection
		{
			var output:ISubstitutionNamespaceCollection = new SubstitutionNamespaceCollection();
			
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				output.addSubstitutionNamespace( getSubstitutionNamespaceAt( i ).clone() );
			}
			
			return output;
		}
	}
}