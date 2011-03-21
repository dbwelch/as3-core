package org.flashx.ui.loaders
{
	import org.flashx.ui.core.ISlideShow;
	import org.flashx.effects.tween.ITween;

	/**
	*	Describes the contract for slideshows that are aware
	* 	of a transition to use between slideshow items.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.06.2010
	*/
	public interface ITransitionAwareSlideShow extends ISlideShow
	{
		/**
		* 	A transition to use when revealing an item.
		*/
		function get reveal():ITween;
		function set reveal( reveal:ITween ):void;
		
		/**
		* 	A transition to use when hiding an item.
		*/
		function get hide():ITween;
		function set hide( hide:ITween ):void;
	}
}