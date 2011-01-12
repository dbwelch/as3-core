package asquery
{
	import com.ffsys.dom.*;

	public class ActionscriptQuery extends Object
	{
		/**
		* 	The delimiter between multiple queries.
		*/
		public static const QUERY_DELIMITER:String = " ";
		
		/**
		* 	A list of all registered DOM implementations.
		*/
		public static var doms:Vector.<Document> = new Vector.<Document>();
		
		private var _doms:Vector.<Document>;
		private var _query:String;
	
		public function ActionscriptQuery(
			query:String = null,
			doms:Vector.<Document> = null )
		{
			super();
			this.query = query
			this.doms = doms;
		}
		
		public function get doms():Vector.<Document>
		{
			return _doms;
		}
		
		public function set doms( value:Vector.<Document> ):void
		{
			_doms = value;
		}
		
		public function get query():String
		{
			return _query;
		}
		
		public function set query( value:String ):void
		{
			_query = value;
		}
		
		public function find( query:String = null ):ActionscriptQuery
		{
			if( query == null )
			{
				query = this.query;
			}
			
			var parts:Array = query.split( QUERY_DELIMITER );
			for( var i:int = 0;i < parts.length;i++ )
			{
				doFind( String( parts[ i ] ) );
			}

			return this;
		}
		
		private function doFind( query:String ):void
		{
			var dom:Document = null;
			for each( dom in doms )
			{
				trace("ActionscriptQuery::doFind()", dom, query );
			}
		}
	}
}