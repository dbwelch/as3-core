package com.ffsys.core {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import com.ffsys.core.IClose;
	import com.ffsys.core.IUnload;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IDestroyListeners;
	import com.ffsys.core.IDispose;
	
	/**
	*	Helper class for performing
	*	destruction on instances.
	*	
	*	@see com.ffsys.core.IDestroy
	*	@see com.ffsys.core.IDestroyListeners
	*	@see com.ffsys.core.IDispose
	*	@see com.ffsys.io.core.IClose
	*	@see com.ffsys.io.core.IUnload
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public class Destroyer
		extends Object {
		
		/**
		*	@private
		*	
		*	Determines whether this	instance is operating
		*	in a <code>brutal</code> manner.
		*/
		protected var _brutal:Boolean;
		
		/**
		*	@private	
		*
		*	Determines whether a destroy() method
		*	should be invoked which should perform
		*	any core destruction for the enemy.	
		*/
		protected var _shouldDestroy:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether the destroyListeners()
		*	method should be invoked to clean any listeners
		*	that the enemy may have active.	
		*/
		protected var _shouldDestroyListeners:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether any IConnection
		*	implementations should have their connection
		*	closed.
		*/
		protected var _shouldDestroyConnections:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether DisplayObject instances
		*	should be removed from the display list.	
		*/
		protected var _shouldDestroyDisplayObjects:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether an unload() method should
		*	be invoked. This should unload and loaded content
		*	that may have been loaded using a Loader instance.
		*/
		protected var _shouldDestroyLoadedContent:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether a </code>dispose</code> method should
		*	be invoked. A <code>dispose</code> method should release
		*	any memory stored using BitmapData.
		*/
		protected var _shouldDispose:Boolean;
		
		public function Destroyer(
			brutal:Boolean = true )
		{
			super();
			
			this.brutal = brutal;
			
			//we always try to call destroy()
			//to null references unless explicitly
			//switched off
			shouldDestroy = true;
		}
		
		public function set brutal( val:Boolean ):void
		{
			_brutal = val;
			
			//NOTE: we never touch the core shouldDestroy
			//this should be explicitly switched off
			
			shouldDestroyListeners = val;
			shouldDestroyConnections = val;
			shouldDestroyDisplayObjects = val;
			shouldDestroyLoadedContent = val;
			shouldDispose = val;
		}
		
		public function get brutal():Boolean
		{
			return _brutal;
		}

		public function set shouldDestroy( val:Boolean ):void
		{
			_shouldDestroy = val;
		}
		
		public function get shouldDestroy():Boolean
		{
			return _shouldDestroy;
		}
		
		public function set shouldDestroyListeners( val:Boolean ):void
		{
			_shouldDestroyListeners = val;
		}
		
		public function get shouldDestroyListeners():Boolean
		{
			return _shouldDestroyListeners;
		}		
		
		public function set shouldDestroyConnections( val:Boolean ):void
		{
			_shouldDestroyConnections = val;
		}
		
		public function get shouldDestroyConnections():Boolean
		{
			return _shouldDestroyConnections;
		}
		
		public function get shouldDestroyDisplayObjects():Boolean
		{
			return _shouldDestroyDisplayObjects;
		}
		
		public function set shouldDestroyDisplayObjects( val:Boolean ):void
		{
			_shouldDestroyDisplayObjects = val;
		}
		
		public function set shouldDestroyLoadedContent( val:Boolean ):void
		{
			_shouldDestroyLoadedContent = val;
		}
		
		public function get shouldDestroyLoadedContent():Boolean
		{
			return _shouldDestroyLoadedContent;
		}
		
		public function set shouldDispose( val:Boolean ):void
		{
			_shouldDispose = val;
		}
		
		public function get shouldDispose():Boolean
		{
			return _shouldDispose;
		}
		
		private function __close(
			enemy:IClose ):Boolean
		{
			if( shouldDestroyConnections && enemy )
			{
				enemy.close();
				return true;
			}
			
			return false;
		}
		
		private function __unload(
			enemy:IUnload ):Boolean
		{
			if( shouldDestroyLoadedContent && enemy )
			{
				enemy.unload();
				return true;
			}
			
			return false;
		}
		
		private function __destroyListeners(
			enemy:IDestroyListeners ):Boolean
		{
			if( shouldDestroyListeners && enemy )
			{
				enemy.destroyListeners();
				return true;
			}
			
			return false;
		}
		
		private function __dispose(
			enemy:IDispose ):Boolean
		{
			if( shouldDispose && enemy )
			{
				enemy.dispose();
				return true;
			}
			
			return false;
		}				
		
		private function __destroy(
			enemy:Object ):Boolean
		{
			if( !enemy )
			{
				return false;
			}
			
			var destroyed:Boolean = false;
			
			//trace("Destroyer::__destroy(), " + enemy );
			
			//destroy any listeners
			if( enemy is IDestroyListeners )
			{
				destroyed = __destroyListeners( enemy as IDestroyListeners );
			}
			
			//close any connections
			if( enemy is IClose )
			{
				destroyed = __close( enemy as IClose ) || destroyed;
			}
			
			//unload and loaded content
			if( enemy is IUnload )
			{
				destroyed = __unload( enemy as IUnload ) || destroyed;
			}
			
			if( enemy is IDispose )
			{
				destroyed = __dispose( enemy as IDispose ) || destroyed;
			}
			
			//call any main destroy method
			if( shouldDestroy && ( enemy is IDestroy ) )
			{
				( enemy as IDestroy ).destroy();
				destroyed = true;
			}
			
			if( enemy is Array )
			{
				//trace("Destroyer::__destroy(), destroy Array contents !!!! " );
				
				//destroy all child elements
				//removing them from the Array
				destroyed =
					destroyArray( enemy as Array ) || destroyed;
			}
			
			//always try to destroy enumerable properties
			
			destroyed =
				destroyObjectProperties( enemy ) || destroyed;
			
			return destroyed;
		}
		
		private function destroyDisplayObject( enemy:DisplayObject ):Boolean
		{
			var destroyed:Boolean = false;
			
			if( enemy )
			{
				if( enemy.parent &&
					enemy.parent.contains( enemy ) )
				{
					destroyed = destroyChild( enemy.parent, enemy );
				}
			}
			
			return destroyed;
		}
		
		private function removeChild(
			parent:DisplayObjectContainer,
			child:DisplayObject ):Boolean		
		{
			if( parent &&
				child &&
				parent.contains( child ) &&
				shouldDestroyDisplayObjects )
			{
				try {
					parent.removeChild( child );
					return true;
				}catch( e:Error )
				{
					//
				}
			}
			
			return false;
		}
		
		private function destroyChild(
			parent:DisplayObjectContainer,
			child:DisplayObject ):Boolean
		{
			
			var destroyed:Boolean = __destroy( child );
			destroyed = removeChild( parent, child ) || destroyed;
			return destroyed;
		}
		
		public function stopMovieClip(
			enemy:DisplayObject, recurse:Boolean = false ):void
		{
			if( enemy && ( enemy is MovieClip ) )
			{
				( enemy as MovieClip ).stop();
				
				if( ( enemy is DisplayObjectContainer ) && recurse )
				{
					var container:DisplayObjectContainer = ( enemy as DisplayObjectContainer );
					
					var i:int = 0;
					var l:int = container.numChildren;
					var child:DisplayObject;
				
					for( ;i < l;i++ )
					{
						child = container.getChildAt( i );
						stopMovieClip( child, recurse );
					}
				}		
			}
		}
		
		/**
		*	Recursively calls destroy on any children of a
		*	DisplayObjectContainer, if you specify the second
		*	argument as false the DisplayObject instances will
		*	not be automatically removed from the parent
		*	DisplayObjectContainer's display list.
		*	
		*	@param enemy the enemy DisplayObjectContainer
		*/
		public function destroyChildren(
			enemy:DisplayObjectContainer ):Boolean
		{
			
			var destroyed:Boolean = false;
			
			stopMovieClip( enemy as DisplayObject );
			
			//ignore null enemys
			if( enemy )
			{
				
				//only bother if there are any child
				//display objects
				if( enemy.numChildren )
				{
					
					//trace("Destroyer::destroyChildren(), " + enemy );
					
					var i:int = 0;
					var l:int = enemy.numChildren;
					var child:DisplayObject;
				
					for( ;i < l;i++ )
					{
						child = enemy.getChildAt( i );
					
						if( child is DisplayObjectContainer )
						{
							//recurse down nested containers
							attack( child as DisplayObjectContainer );
						}

						destroyed = destroyChild( enemy, child );
					
						//we've just removed a child
						//update the loop parameters
						if( enemy.numChildren < l )
						{
							i--;
							l--;
						}
					
					}
				
				}
				
			}
			
			return destroyed;
		}
		
		private function destroyArray(
			enemy:Array ):Boolean
		{
			var destroyed:Boolean = false;
			
			if( enemy && enemy.length )
			{
				var i:int = 0;
				var l:int = enemy.length;
				
				var element:Object;
				
				for( ;i < l;i++ )
				{
					element = enemy[ i ];
					
					if( element )
					{
						destroyed = attack( element ) || destroyed;
					}
					
					enemy = enemy.splice( i, 1 );
					i--;
					l--;
					
				}
				
			}
			
			return destroyed;
		}
		
		private function destroyObjectProperties( enemy:Object ):Boolean
		{
			var destroyed:Boolean = false;
			var key:String = null;
			
			if( enemy )
			{
				for( key in enemy )
				{
					//call destroy on the nested Object
					//destroyed = attack( enemy[ key ] ) || destroyed;
					
					//null the reference
					enemy[ key ] = null;
					destroyed = delete( enemy[ key ] ) || destroyed;
				}
			}
			
			return destroyed;
		}
		
		public function attack(
			target:Object = null ):Boolean
		{
			var destroyed:Boolean = false;
			
			if( !target )
			{
				throw new Error( "Destroyer, cannot attack a null enemy." );
			}
			
			//trace("Destroyer::attack(), " + target );
			
			if( target is DisplayObjectContainer )
			{
				destroyed =
					destroyChildren( target as DisplayObjectContainer );
			}else if( target is DisplayObject )
			{
				destroyed =
					destroyDisplayObject( target as DisplayObject );
			}else
			{
				destroyed =
					__destroy( target );
			}
			
			return destroyed;
		}
		
	}
	
}
