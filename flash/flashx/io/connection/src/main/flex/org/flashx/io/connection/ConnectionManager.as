package org.flashx.io.connection {
	
	/**
	*	Manages a collection of <code>IConnection</code>
	*	implementations.
	*	
	*	This allows for the closing of all
	*	open connections registered with this
	*	<code>IConnectionManager</code> by calling
	*	the <code>close</code> method.
	*	
	*	@see com.ffsys.io.core.IClose
	*	@see com.ffsys.io.connection.IConnection
	*	@see com.ffsys.io.connection.IConnectionManager
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public class ConnectionManager extends Object
		implements IConnectionManager {
			
		/**
		*	@private	
		*/
		protected var _connections:Array;
		
		/**
		*	Creates a <code>ConnectionManager</code>
		*	instance.
		*/
		public function ConnectionManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function addConnection( connection:IConnection ):void
		{
			//ignore null values
			if( connection )
			{
				if( !_connections )
				{
					clear();
				}	
				_connections.push( connection );
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function removeConnection( connection:IConnection ):Boolean
		{
			var removed:Boolean = false;
			
			if( connection )
			{
				var i:int = 0;
				var l:int = connections.length;
				
				var matches:Array;
				
				for( ;i < l;i++ )
				{
					if( connection == connections[ i ] )
					{
						matches = connections.splice( i, 1 );
						return ( matches && matches.length );
					}
				}
				
			}
			
			return removed;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get connections():Array
		{
			return _connections;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function clear():void
		{
			_connections = new Array();
		}
		
		/**
		*	Closes all connections
		*	registered with this
		*	<code>IConnectionManager</code>.
		*/
		public function close():void
		{
			if( connections )
			{
				var i:int = 0;
				var l:int = connections.length;
			
				var connection:IConnection;
			
				for( ;i < l;i++ )
				{
					connection = connections[ i ];
					if( connection )
					{
						connection.close();
					}
				}
			}
		}
	}
}