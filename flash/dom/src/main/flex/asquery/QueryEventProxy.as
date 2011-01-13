package asquery
{
	import flash.events.*;
	import com.ffsys.dom.*;
	
	public class QueryEventProxy extends Object {
		
		public static const CLICK:String = "click";

		public var methodName:*;
		public var type:String = null;
		public var scope:Object;
		public var handler:Function = null;
		public var parameters:Array = null;

		public function QueryEventProxy()
		{
			super();
		}
		
		public function getEventByType( type:String ):Event
		{
			var e:Event = null;
			switch( type )
			{
				case CLICK:
					e = new MouseEvent( type );
					break;
				default:
					//allows for binding of custom events
					e = new Event( type );
			}
			return e;
		}
		
		public function accept( event:Event ):*
		{
			//trace("[ACCEPT] QueryEventProxy::accept()", event, this, handler );
			handler.apply( scope, [ event ].concat( parameters != null ? parameters : [] ) );
		}

		public function execute( scope:Node ):void
		{
			//trace("[EXECUTE] QueryEventProxy::execute()", scope );
			if( Object( scope ).eventProxy != null )
			{
				this.scope = scope;
				//TODO: generate a correct mouse event - co-ordinates !
				
				var e:Event = getEventByType( this.type );
				//trace("[EXECUTE] QueryEventProxy::execute()", scope, e );				
				if( e != null )
				{
					Object( scope ).dispatchEvent( e );
				}
			}			
		}
	}
}