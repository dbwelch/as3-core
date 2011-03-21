package org.flashx.ui.data
{
	import org.flashx.ui.core.IComponent;
	
	/**
	*	Abstract super class for data binding implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class DataBinding extends Object
		implements IDataBinding
	{
		private var _id:String;
		
		/**
		* 	@private
		*/
		private var _data:Object;
		
		private var _observers:Vector.<IComponent> = new Vector.<IComponent>;
		
		/**
		* 	Creates a <code>DataBinding</code> instance.
		* 
		* 	@param data The data encapsulated by this data binding.
		*/
		public function DataBinding( data:Object = null )
		{
			super();
			this.data = data;
		}
		
		/**
		* 	The components that are observing this binding.
		*/
		public function get observers():Vector.<IComponent>
		{
			return _observers;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeObserver( observer:IComponent ):Boolean
		{
			var index:int = _observers.indexOf( observer );
			if( index > -1 )
			{
				_observers.splice( index, 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasObserver( observer:IComponent ):Boolean
		{
			return _observers.indexOf( observer ) > -1;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function addObserver( observer:IComponent ):void
		{
			if( observer && !hasObserver( observer ) )
			{
				_observers.push( observer );
			}
			
			//fire the create notification
			if( _observers && observer && this.data )
			{
				notify( new CreateNotification() );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get data():Object
		{
			return _data;
		}
		
		public function set data( value:Object ):void
		{
			if( _data == null && value )
			{
				notify( new CreateNotification() );
			}else if( _data && ( value == null ) )
			{
				notify( new ClearNotification() );
			}
			
			var changed:Boolean = false;
			
			if( _data && value &&  _data != value )
			{
				changed = true;
			}
			
			_data = value;
			
			if( changed )
			{
				notify( new ChangeNotification() );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function notify( notification:IDataBindingNotification ):void
		{
			if( _observers )
			{
				for( var i:int = 0;i < _observers.length;i++ )
				{
					_observers[ i ].notify( notification );
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			this.data = null;
		}
		
		/**
		* 	An identifier of this data binding.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		* 	Destroys the data encapsulated by this instance allowing the garbage collector to free allocated memory.
		*/
		public function destroy():void
		{
			this.data = null;
			_id = null;
			_observers = null;
		}
	}
}