package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.core.IMaskComponent;
	import com.ffsys.ui.core.MaskComponent;
	
	/**
	*	Encapsulates an arbitrary display object as a
	*	target for scrolling adding the ability to mask
	*	the target to the preferred dimensions and the
	*	ability to drag the scroll target.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public class ScrollTarget extends InteractiveComponent
		implements IScrollTarget {
		
		private var _target:DisplayObject;
		private var _masker:IMaskComponent;
		
		/**
		*	Creates a <code>ScrollTarget</code> instance.
		*	
		*	@param width The preferred width for the component.
		*	@param height The preferred height for the component.
		*	@param target The target display object being scrolled.
		*/
		public function ScrollTarget(
			width:Number = 100,
			height:Number = 100,
			target:DisplayObject = null )
		{
			super();
			preferredWidth = width;
			preferredHeight = height;
			this.target = target;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get masker():IMaskComponent
		{
			return _masker;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( target:DisplayObject ):void
		{
			if( this.target && contains( this.target ) )
			{
				this.target.mask = null;
				removeChild( this.target );
				
				if( this.contains( DisplayObject( _masker ) ) )
				{
					removeChild( DisplayObject( _masker ) );
					_masker = null;
				}
			}
			
			_target = target;
			
			if( this.target )
			{
				addChild( this.target );
				
				_masker = new MaskComponent(
					this.preferredWidth, this.preferredHeight );
				addChild( DisplayObject( _masker ) );
				this.target.mask = DisplayObject( _masker );
			}
		}
	}
}