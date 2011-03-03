package javax.script
{
	import java.lang.Exception;
	
	/**
	* 	
	*/
	public class ScriptException extends Exception
	{
		/**
		* 	Creates a ScriptException instance.
		*/
		public function ScriptException()
		{
			super();
		}
		
		/*
		
		int	getColumnNumber() 
	          Get the column number on which an error occurred.
	 String	getFileName() 
	          Get the source of the script causing the error.
	 int	getLineNumber() 
	          Get the line number on which an error occurred.
	 String	getMessage() 
	          Returns a message containing the String passed to a constructor as well as line and column numbers and filename if any of these are known.
		
		*/
	}
}