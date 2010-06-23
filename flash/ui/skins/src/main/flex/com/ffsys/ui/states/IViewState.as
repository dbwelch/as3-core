package com.ffsys.ui.states
{
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.IFill;
	import com.ffsys.ui.graphics.IStroke;
	import com.ffsys.ui.styles.IStyleCollection;
	
	/**
	*	Describes the contract for instances that
	* 	encapsulate state information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public interface IViewState extends IStringIdentifier
	{
		/**
		*	A style collection associated with this
		*	state.	
		*/
		function get styles():IStyleCollection;
		function set styles( styles:IStyleCollection ):void;
		
		/**
		*	A vector of graphics associated with this state.	
		*/
		function get graphics():Vector.<IComponentGraphic>;
		function set graphics( graphics:Vector.<IComponentGraphic> ):void;
		
		/**
		*	A vector of fills that should be applied to
		*	each graphic in the graphics vector.	
		*/
		function get fills():Vector.<IFill>;
		function set fills( fills:Vector.<IFill> ):void;
		
		/**
		*	A vector of strokes that should be applied to
		*	each graphic in the graphics vector.	
		*/
		function get strokes():Vector.<IStroke>;
		function set strokes( strokes:Vector.<IStroke> ):void;	
	}
}