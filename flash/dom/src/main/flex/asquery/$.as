package asquery
{
	import com.ffsys.dom.*;
	
	public var $:Function = function( query:String ):*
	{
		return new ActionscriptQuery( null, ActionscriptQuery.doms ).find( query );
	}
}