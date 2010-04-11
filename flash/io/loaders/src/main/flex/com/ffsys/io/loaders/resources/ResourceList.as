package com.ffsys.io.loaders.resources {
	
	import com.ffsys.core.Destroyer;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
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
		implements 	IResourceList,
		 			IObjectInspector {
			
		private var _id:String;
		private var _resources:Array;
		
		public function ResourceList( id:String = null )
		{
			super();
			clear();
			this.id = id;
		}
		
		public function destroy():void
		{
			//trace("ResourceList::destroy(), " + _resources );
			
			var destroyer:Destroyer = new Destroyer();
			
			if( _resources )
			{
				destroyer.attack( _resources );
			}
			
			_id = null;
			_resources = null;
		}
		
		/*
		*	IResourceElement implementation.
		*/
		
		public function set id( val:String ):void
		{
			_id = val;
		}		
		
		public function get id():String
		{
			return _id;
		}		
		
		/*
		*	IResourceList implementation.
		*/
		
		public function addResource( val:IResourceElement ):int
		{
			if( !_resources )
			{
				throw new Error( "Cannot add a resource with a null resources Array." );
			}
			
			return _resources.push( val );
		}
		
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
		
		public function getResourceAt( index:int ):IResourceElement
		{
			return IResourceElement( _resources[ index ] );
		}	

		public function removeResourceAt( index:int ):IResourceElement
		{
			
			if( index < 0 || ( index > ( getLength() - 1 ) ) )
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
		
		public function getLength():int
		{
			return _resources.length;
		}
		
		public function last():IResourceElement
		{
			return _resources[ _resources.length - 1 ];
		}
		
		public function first():IResourceElement
		{
			return _resources[ 0 ];
		}
		
		public function clear():void
		{
			_resources = new Array();
		}
		
		public function isEmpty():Boolean
		{
			return ( _resources == null ) || ( _resources.length == 0 );
		}
		
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
		*	Recursively adds the contents of the source list
		*	into the destination IResourceList passed to the merge method. If
		*	destination is not specified it defaults to the instance that the merge
		*	method is invoked on.
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
		
		/*
		*	IResourceAccess implementation.
		*/
		
		public function get resources():IResourceList
		{
			return this;
		}
		
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
		
		public function getResourceListById( id:String ):IResourceList
		{
			var list:IResourceList = IResourceList( getElementByClass( id, IResourceList ) );	
			return list;
		}
		
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
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}
		
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object
			return output;
		}
		
		public function getCommonStringOutputComposites():Array
		{
			return _resources;
		}
		
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}
		
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}
		
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			output.detail = getLength();
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		public function toString():String
		{
			return getObjectString( true );
		}
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
