package com.ffsys.ui.layout {
	
	/**
	*	A layout that is aware of some spacing properties
	*	to specify horizontal and vertical spacing as well
	*	as a generic spacing property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class SpacingAwareLayout extends AbstractLayout {
		
		private var _horizontalSpacing:Number = 0;
		private var _verticalSpacing:Number = 0;
		private var _spacing:Number = 0;
		
		/**
		*	Creates a <code>SpacingAwareLayout</code> instance.	
		*/
		public function SpacingAwareLayout()
		{
			super();
		}
		
		public function get spacing():Number
		{
			return _spacing;
		}
		
		public function set spacing(
			spacing:Number ):void
		{
			_spacing = spacing;
		}
		
		public function get horizontalSpacing():Number
		{
			return _horizontalSpacing;
		}
		
		public function set horizontalSpacing(
			horizontalSpacing:Number ):void
		{
			_horizontalSpacing = horizontalSpacing;
		}
		
		public function get verticalSpacing():Number
		{
			return _verticalSpacing;
		}
		
		public function set verticalSpacing(
			verticalSpacing:Number ):void
		{
			_verticalSpacing = verticalSpacing;
		}
	}
}