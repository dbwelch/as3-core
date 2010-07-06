package com.ffsys.ui.states
{
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.IFill;
	import com.ffsys.ui.graphics.IStroke;
	import com.ffsys.ui.styles.IStyleCollection;
	import com.ffsys.ui.styles.StyleCollection;
	
	/**
	*	Represents the style information associated with a single
	*	state.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ViewState extends Object
		implements IViewState
	{	
		private var _id:String;
		private var _styles:IStyleCollection = new StyleCollection();
		private var _graphics:Vector.<IComponentGraphic>
			= new Vector.<IComponentGraphic>();
		private var _fills:Vector.<IFill> = new Vector.<IFill>();
		private var _strokes:Vector.<IStroke> = new Vector.<IStroke>();
		private var _classPath:String;
		private var _blendMode:String;
		private var _alpha:Number;
		
		/**
		* 	Creates a <code>ViewState</code> instance.
		*	
		*	@param id The identifier for the state.
		*/
		public function ViewState(
			id:String = State.MAIN )
		{
			super();
			this.id = id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha( alpha:Number ):void
		{
			_alpha = alpha;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get blendMode():String
		{
			return _blendMode;
		}
		
		public function set blendMode( blendMode:String ):void
		{
			_blendMode = blendMode;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get styles():IStyleCollection
		{
			return _styles;
		}
		
		public function set styles( styles:IStyleCollection ):void
		{
			_styles = styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get graphics():Vector.<IComponentGraphic>
		{
			return _graphics;
		}
		
		public function set graphics( graphics:Vector.<IComponentGraphic> ):void
		{
			_graphics = graphics;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get fills():Vector.<IFill>
		{
			return _fills;
		}
		
		public function set fills( fills:Vector.<IFill> ):void
		{
			_fills = fills;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get strokes():Vector.<IStroke>
		{
			return _strokes;
		}

		public function set strokes( strokes:Vector.<IStroke> ):void
		{
			_strokes = strokes;
		}
	}
}