package com.ffsys.ui.css
{
	import com.ffsys.ioc.*;	
	
	import com.ffsys.ui.common.Border;

	/**
	*	Responsible for parsing css bean definitions.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.01.2011
	*/
	public class CssTextElementParser extends BeanTextElementParser
	{	
		/**
		* 	The name of the expression used to define css border
		* 	information.
		*/
		public static const BORDER_EXPRESSION:String = "border";		
		
		/**
		* 	Creates a <code>CssTextElementParser</code> instance.
		*/
		public function CssTextElementParser()
		{
			super();
		}
		
		/**
		* 	Invoked when an unknown expression is encountered,
		* 	this implementation deals with css specific bean
		* 	expressions.
		* 
		* 	@param target The unknown expression instance.
		* 
		* 	@throws Error An error indicating the expression could
		* 	not be handled by the css parser.
		*/
		override protected function doWithUnknownExpression(
			target:UnknownExpression ):Object
		{
			var output:Object = null;
			var expression:String = target.expression;
			var parameters:Array = target.parameters;
			var expected:Vector.<Class> = null;
			
			switch( expression )
			{
				case BORDER_EXPRESSION:
					expected = new Vector.<Class>( 6, true );
					expected[ 0 ] = Number;
					expected[ 1 ] = Number;
					expected[ 2 ] = Number;
					expected[ 3 ] = Number;
					expected[ 4 ] = Number;
					expected[ 5 ] = Number;
					target.validate( expected );
					output = new Border(
						parameters[ 0 ],
						parameters[ 1 ],
						parameters[ 2 ],
						parameters[ 3 ],
						parameters[ 4 ],
						parameters[ 5 ] );
						
					trace("CssTextElementParser::doWithUnknownExpression()", "FOUND BORDER EXPRESSION ?!?!?!?!?!!?!!?", output, ( output as Border ).left );					
					break;
			}
			
			if( output != null )
			{
				return output;
			}
			
			//default to the error behaviour
			return super.doWithUnknownExpression( target );
		}
	}
}