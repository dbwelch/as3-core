package asquery
{
	import com.ffsys.dom.*;
	
	public var $:Function = function( query:Object = null ):ActionscriptQuery
	{
		return new ActionscriptQuery().handle( query );
	}
}