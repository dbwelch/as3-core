package com.ffsys.ui.css
{
	import flash.geom.*;
	
	import com.ffsys.ioc.*;	
	
	import com.ffsys.ui.common.Border;
	
	import com.ffsys.ui.graphics.*;

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
		* 	The name of the expression used to define a solid fill.
		*/
		public static const FILL_EXPRESSION:String = "fill";
		
		/**
		* 	The name of the expression used to define a gradient fill.
		*/
		public static const GRADIENT_FILL_EXPRESSION:String = "gradient-fill";
		
		/**
		* 	The name of the expression used to define a stroke.
		*/
		public static const STROKE_EXPRESSION:String = "stroke";
		
		/**
		* 	The name of the expression used to define a gradient stroke.
		*/
		public static const GRADIENT_STROKE_EXPRESSION:String = "gradient-stroke";
		
		/**
		* 	The name of the expression used to define a gradient.
		*/
		public static const GRADIENT_EXPRESSION:String = "gradient";
		
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
			
			//TODO: improve this logic so that varargs can be used
			//by adding the validation on a minimum number of parameters
			
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
					break;
				case FILL_EXPRESSION:
					expected = new Vector.<Class>( 2, true );
					expected[ 0 ] = Number;
					expected[ 1 ] = Number;
					target.validate( expected );
					output = new SolidFill(
						parameters[ 0 ],
						parameters[ 1 ] );
					break;				
				case STROKE_EXPRESSION:
					expected = new Vector.<Class>( 8, true );
					expected[ 0 ] = Number;
					expected[ 1 ] = Number;
					expected[ 2 ] = Number;
					expected[ 3 ] = Boolean;
					expected[ 4 ] = String;
					expected[ 5 ] = String;
					expected[ 6 ] = String;
					expected[ 7 ] = Number;					
					
					target.validate( expected );
					output = new Stroke(
						parameters[ 0 ],
						parameters[ 1 ],
						parameters[ 2 ],
						parameters[ 3 ],
						parameters[ 4 ],
						parameters[ 5 ],
						parameters[ 6 ],
						parameters[ 7 ] );
					break;
					
				case GRADIENT_STROKE_EXPRESSION:
					expected = new Vector.<Class>( 7, true );
					expected[ 0 ] = IGradient;
					expected[ 1 ] = Number;
					expected[ 2 ] = Boolean;
					expected[ 3 ] = String;
					expected[ 4 ] = String;
					expected[ 5 ] = String;
					expected[ 6 ] = Number;

					target.validate( expected );
					output = new GradientStroke(
						parameters[ 0 ],
						parameters[ 1 ],
						parameters[ 2 ],
						parameters[ 3 ],
						parameters[ 4 ],
						parameters[ 5 ],
						parameters[ 6 ] );
					break;					
					
				
				case GRADIENT_EXPRESSION:
					expected = new Vector.<Class>( 8, true );
					expected[ 0 ] = String;
					expected[ 1 ] = Array;
					expected[ 2 ] = Array;
					expected[ 3 ] = Array;
					expected[ 4 ] = Matrix;
					expected[ 5 ] = String;
					expected[ 6 ] = String;
					expected[ 7 ] = Number;

					target.validate( expected );
					output = new Gradient(
						parameters[ 0 ],
						parameters[ 1 ],
						parameters[ 2 ],
						parameters[ 3 ],
						parameters[ 4 ],
						parameters[ 5 ],
						parameters[ 6 ],
						parameters[ 7 ] );
					break;
				case GRADIENT_FILL_EXPRESSION:
					expected = new Vector.<Class>( 1, true );
					expected[ 0 ] = Gradient;
					target.validate( expected );
					output = new GradientFill(
						parameters[ 0 ] );
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