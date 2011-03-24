package org.flashx.io.loaders.resources {
	
	/**
	*	Encapsulates a list of available resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class ResourceList extends Object
		implements 	IResourceList {
			
		private var _id:String;
		private var _resources:Array;
		
		/**
		* 	Creates a <code>ResourceList</code> instance.
		* 
		* 	@param id An identifier for this resource list.
		*/
		public function ResourceList( id:String = null )
		{
			super();
			clear();
			this.id = id;
		}
		
		/**
		* 	Destroys this resource list.
		*/
		public function destroy():void
		{
			//destroy child resources first
			var target:IResourceElement;
			for( var i:int = 0;i < _resources.length;i++ )
			{
				target = _resources[ i ];
				target.destroy();
			}
			
			_id = null;
			_resources = null;
		}
		
		/**
		*	An identifier for this resource list.
		*/
		public function get id():String
		{
			return _id;
		}		
		
		public function set id( val:String ):void
		{
			_id = val;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function addResource( val:IResourceElement ):int
		{
			if( !_resources )
			{
				throw new Error( "Cannot add a resource with a null resources Array." );
			}
			
			return _resources.push( val );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeResource( val:IResourceElement ):Boolean
		{
			var i:int = 0;
			var l:int = _resources.length;
			
			var target:IResourceElement;
			
			for( ;i < l;i++ )
			{
				target = _resources[ i ];
				
				if( target == val )
				{
					removeResourceAt( i );
					return true;
				}
				
				if( ( target is IResourceList )
					&& ( target as IResourceList ).removeResource( val ) )
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceAt( index:int ):IResourceElement
		{
			return IResourceElement( _resources[ index ] );
		}	

		/**
		* 	@inheritDoc
		*/
		public function removeResourceAt( index:int ):IResourceElement
		{
			
			if( index < 0 || ( index > ( length - 1 ) ) )
			{
				throw new Error( "ResourceList.removeResourceAt() index out of bounds error: " + index );
			}
			
			var removed:Array = _resources.splice( index, 1 );
			
			if( removed && removed.length > 0 )
			{
				return removed[ 0 ] as IResourceElement;
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():int
		{
			return _resources.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function last():IResourceElement
		{
			if( isEmpty() )
			{
				return null;
			}
			return _resources[ _resources.length - 1 ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function first():IResourceElement
		{	
			if( isEmpty() )
			{
				return null;
			}
			return _resources[ 0 ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_resources = new Array();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return ( _resources == null ) || ( _resources.length == 0 );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourcesByType( type:Class ):IResourceList
		{
			var output:ResourceList = new ResourceList();
			
			if( !type )
			{
				return output;
			}
			
			var i:int = 0;
			var l:int = _resources.length;
			
			var target:IResourceElement;
			
			for( ;i < l;i++ )
			{	
				target = _resources[ i ] as IResourceElement;
				
				if( ( target is IResource ) && ( target is type ) )
				{
					output.addResource( target );
				}else if( target is IResourceList ) 
				{
					merge( ( target as IResourceList ).getResourcesByType( type ), output );
				}
			}
			
			return output;			
		}
		
		/**
		*	@inheritDoc
		*/
		public function merge(
			source:IResourceList,
			destination:IResourceList = null ):IResourceList
		{
			if( !source )
			{
				source = new ResourceList();
			}
			
			if( !destination )
			{
				destination = this;
			}
			
			var flattened:Array = source.getAllResources();	
			var i:int = 0;
			var l:int = flattened.length;
			for( ;i < l;i++ )
			{
				destination.addResource( flattened[ i ] );
			}
			return destination;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function flatten():IResourceList
		{
			var output:IResourceList = new ResourceList( this.id );
			var flattened:Array = getAllResources();
			var i:int = 0;
			var l:int = flattened.length;
			for( ;i < l;i++ )
			{
				output.addResource( flattened[ i ] );
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceList
		{
			return this;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceById( id:String, list:String = null ):IResource
		{
			if( list )
			{
				var resourceList:IResourceList = getResourceListById( list );
				if( resourceList )
				{
					return resourceList.getResourceById( id );
				}
			}
			return IResource( getElementByClass( id, IResource ) );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceListById( id:String ):IResourceList
		{
			return IResourceList( getElementByClass( id, IResourceList ) );	
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllResources():Array
		{
			var output:Array = new Array();
			
			if( _resources )
			{
			
				var i:int = 0;
				var l:int = _resources.length;
			
				var target:IResourceElement;
			
				for( ;i < l;i++ )
				{	
					target = _resources[ i ] as IResourceElement;
				
					if( target is IResource )
					{
						output.push( target );
					}else if( target is IResourceList ) 
					{
						output = output.concat.apply(
							output, ( target as IResourceList ).getAllResources() );
					}
				}
			
			}
			
			return output;
		}
		
		/*
		*	Utility methods.
		*/
		
		internal function getElementByClass( id:String, classReference:Class ):IResourceElement
		{
			var i:int = 0;
			var l:int = _resources.length;
			
			var target:IResourceElement;
			
			for( ;i < l;i++ )
			{
				target = _resources[ i ];
				
				if( ( target is classReference ) && target.id == id )
				{
					return ( target as IResourceElement );
				}
				
				if( ( target is ResourceList ) )
				{
					target = ( target as ResourceList ).getElementByClass( id, classReference );
					
					if( target && ( target is classReference ) )
					{
						return ( target as IResourceElement );
					}
					
				}
			}
			
			return null;			
		}
	}
}