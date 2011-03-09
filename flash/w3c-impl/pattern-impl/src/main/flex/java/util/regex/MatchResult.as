package java.util.regex
{

	public interface MatchResult
	{
		
		function start( group:int = -1 ):int;
		
		function end( group:int = -1 ):int;
		
		function group( group:int = -1 ):int;
		
		function groupCount():int;
		
		/*
		
		int	end() 
		          Returns the offset after the last character matched.
		 int	end(int group) 
		          Returns the offset after the last character of the subsequence captured by the given group during this match.
		 String	group() 
		          Returns the input subsequence matched by the previous match.
		 String	group(int group) 
		          Returns the input subsequence captured by the given group during the previous match operation.
		 int	groupCount() 
		          Returns the number of capturing groups in this match result's pattern.
		 int	start() 
		          Returns the start index of the match.
		 int	start(int group) 
		          Returns the start index of the subsequence captured by the given group during this match.		
		
		*/
	}
}