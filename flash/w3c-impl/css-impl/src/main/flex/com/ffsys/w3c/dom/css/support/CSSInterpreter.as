package com.ffsys.w3c.dom.css.support
{
	import com.ffsys.w3c.dom.css.CSSStyleSheetImpl;
	
	import javax.script.scanner.Token;
	
	/**
	* 	Responsible for interpreting scan tokens into
	* 	the appropriate CSS DOM implementations.
	*/
	public class CSSInterpreter extends CSSScanner
	{
		private var _factory:CSSStyleSheetImpl;
		
		/**
		* 	@private
		* 	
		* 	Creates a <code>CSSInterpreter</code> instance.
		* 
		* 	@param factory The style sheet used to create
		* 	CSS DOM implementations.
		*/
		public function CSSInterpreter(
			factory:CSSStyleSheetImpl = null )
		{
			super();
			_factory = factory;
		}
		
		/**
		* 	Scans the specified text into tokens
		* 	and converts the tokens into an
		* 	object graph of the appropriate types.
		* 
		* 	@param text The CSS text to interpret.
		* 
		* 	@return An object representing all the
		* 	matching tokens as CSS DOM implementations.
		*/
		public function interpret( text:String ):Object
		{
			trace("CSSInterpreter::interpret()", text );
			var results:Vector.<Token> = scan( text );
			
			trace("[RESULTS] CSSInterpreter::interpret()",
				results.length, source );
			
			if( results.length > 0 )
			{
				var last:Token = results[ results.length - 1 ];
				trace("[LAST TOKEN] CSSInterpreter::interpret()", last );
			}			
			
			return null;
		}
		
		/**
		* 	@private
		*/
		override protected function beginToken( token:Token ):void
		{
			//
		}
		
		/**
		* 	@private
		*/
		override protected function token( token:Token ):void
		{
			//
		}
		
		/**
		* 	@private
		*/
		override protected function endToken( token:Token ):void
		{
			//
		}
		
		/**
		* 	@private
		*/
		override protected function dispose( token:Token ):void
		{
			//
		}
		
		/**
		* 	Creates a new CSS interpreter.
		* 
		* 	@param factory The implementation responsible
		* 	for creating CSS DOM implementations.
		* 
		* 	@return A new CSS interpreter.
		*/
		public static function newInstance(
			factory:CSSStyleSheetImpl ):CSSInterpreter
		{
			//no caching for the moment
			return new CSSInterpreter( factory );
		}
	}
}