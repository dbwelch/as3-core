package asquery
{
	import com.ffsys.dom.*;
	
	public var $:Function = function( query:Object = null ):ActionscriptQuery
	{
		arguments.callee.document =
			ActionscriptQuery.doms.length > 0 ? ActionscriptQuery.doms[ 0 ] : null;
		return new ActionscriptQuery().handle( query );
	}
}