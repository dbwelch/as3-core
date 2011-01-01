package com.ffsys.ui.suite.view {
	
	import com.ffsys.swat.view.DefaultApplicationMain;

	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.ui.suite.core.ComponentSuiteController;
	
	/**
	*	Main entry point for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	[Frame(factoryClass="com.ffsys.ui.suite.view.ComponentSuitePreloader")]
	public class ComponentSuiteMain extends DefaultApplicationMain {
		
		/**
		*	Creates a <code>ComponentSuiteMain</code> instance.
		*/
		public function ComponentSuiteMain()
		{
			super();
		}
		
		override public function getRuntimeClasses():Array
		{
			var output:Array = new Array();
			output.push( ComponentSuiteController );
			
			output.push( RectangleGraphic );
			output.push( SquareGraphic );
			output.push( CircleGraphic );
			output.push( EllipseGraphic );
			output.push( ArrowGraphic );
			output.push( BevelRectangleGraphic );
			output.push( RoundedRectangleGraphic );
			output.push( BorderGraphic );
			
			output.push( ArrowPointer );
			output.push( SolidFill );
			output.push( BitmapFill );
			output.push( GradientFill );
			output.push( CompositeFill );
			output.push( Gradient );
			output.push( Stroke );
			return output;
		}
	}
}