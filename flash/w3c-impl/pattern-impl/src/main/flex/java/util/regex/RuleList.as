package java.util.regex
{
	
	/**
	* 	Represents a collection of rules.
	* 
	* 	This is the document element for a
	* 	pattern DOM Document.
	*/
	public class RuleList extends PatternList
	{
		/**
		* 	The bean name for a rule list.
		*/
		public static const NAME:String = "rules";
		
		/**
		* 	Creates a <code>RuleList</code> instance.
		*/
		public function RuleList()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get patternType():uint
		{
			return Pattern.RULE_LIST_TYPE;
		}
	}
}