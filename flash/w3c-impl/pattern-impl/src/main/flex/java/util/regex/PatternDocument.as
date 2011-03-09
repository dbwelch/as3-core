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
		* 	@param pattern The source pattern to compile.
		* 	@param comment An optional comment for the rule.
		*/
		function createRule(
			pattern:String = "",
			comment:String = null ):Rule;
		
		/**
		* 	Creates a Pattern using the specified source.
		* 
		* 	@param source The source for the pattern.
		* 	@param comment A comment for the pattern.
		*/
		function createPattern(
			source:String = null,
			comment:String = null ):Pattern;
	}
}