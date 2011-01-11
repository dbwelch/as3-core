package asquery
{
	public var $:Function = function( query:String ):*
	{
		var asQuery:Function = function( query:String ):*
		{
			trace("::()", query );
		}
		return new asQuery( query );
	}
}

