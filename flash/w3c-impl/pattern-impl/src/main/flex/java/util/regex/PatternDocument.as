package java.util.regex
{
	import org.w3c.dom.Document;
	
	/**
	* 	Describes the contract for pattern documents.
	*/
	public interface PatternDocument extends Document
	{
		
		/**
		* 	Creates a Rule from the specified pattern.
		* 
		* 	@param pattern The source pattern.
		* 	@param comment An optional comment for the rule.
		*/
		function createRule(
			pattern:String = "",
			comment:String = null ):Rule;
			
		/**
		* 	
		*/
		function createPattern(
			pattern:String,
			comment:String = null ):Pattern;		
	}
}