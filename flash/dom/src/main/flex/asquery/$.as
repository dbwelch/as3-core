package asquery
{
	import com.ffsys.dom.*;
	
	public var $:Function = function( query:String ):*
	{
		//DOM implementations that we are aware of
		var doms:Vector.<Document>;
		
		//no DOM implementations to operate on
		if( doms.length == 0 )
		{
			return null;
		}
		
		var asQuery:Function = function( query:String ):*
		{
			trace("::()", query );
		}
		return new asQuery( query );
	}
}